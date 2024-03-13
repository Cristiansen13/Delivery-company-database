
CREATE OR REPLACE PACKAGE my_project_pkg AS
    PROCEDURE GetAllDepotInventory;
    PROCEDURE GetCustomerOrders(p_start_date DATE, p_end_date DATE);
    PROCEDURE plaseaza_comanda(p_id_client INT, p_denumire_produs VARCHAR2, p_cantitate INT);
    FUNCTION GetCustomerOrderDetails(p_client_id INT) RETURN VARCHAR2;
END my_project_pkg;
/

CREATE OR REPLACE PACKAGE BODY my_project_pkg AS
    PROCEDURE GetAllDepotInventory AS
        TYPE ProductCountIndexByTable IS TABLE OF INT INDEX BY VARCHAR2(255);
        TYPE ProductListNestedTable IS TABLE OF VARCHAR2(255);
        TYPE StockVarray IS VARRAY(10) OF INT;
        TYPE DepotInfoRecord IS RECORD (
            DepotId INT,
            ProductCount INT,
            Products ProductListNestedTable,
            Stocks StockVarray
        );
        TYPE DepotInfoTable IS TABLE OF DepotInfoRecord;
        DepotsInfo DepotInfoTable := DepotInfoTable();
        CursorDepots SYS_REFCURSOR;
        DepotRec DepotInfoRecord;
    BEGIN
        OPEN CursorDepots FOR
        SELECT DISTINCT id_depozit FROM MODEL_PRODUS;
        LOOP
            FETCH CursorDepots INTO DepotRec.DepotId;
            EXIT WHEN CursorDepots%NOTFOUND;
            DepotRec.Products := ProductListNestedTable();
            DepotRec.Stocks := StockVarray();
            SELECT COUNT(*)
            INTO DepotRec.ProductCount
            FROM MODEL_PRODUS
            WHERE id_depozit = DepotRec.DepotId;
            FOR ProductRec IN (SELECT denumire FROM MODEL_PRODUS WHERE id_depozit = DepotRec.DepotId) LOOP
                DepotRec.Products.EXTEND;
                DepotRec.Products(DepotRec.Products.LAST) := ProductRec.denumire;
            END LOOP;
            FOR StockRec IN (SELECT stoc FROM MODEL_PRODUS WHERE id_depozit = DepotRec.DepotId) LOOP
                DepotRec.Stocks.EXTEND;
                DepotRec.Stocks(DepotRec.Stocks.LAST) := StockRec.stoc;
            END LOOP;
            DepotsInfo.EXTEND;
            DepotsInfo(DepotsInfo.LAST) := DepotRec;
        END LOOP;
        CLOSE CursorDepots;
        FOR i IN 1..DepotsInfo.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Depozit: ' || DepotsInfo(i).DepotId);
            DBMS_OUTPUT.PUT_LINE('Număr total de produse în depozit: ' || DepotsInfo(i).ProductCount);
            FOR j IN 1..DepotsInfo(i).Products.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE('Produs: ' || DepotsInfo(i).Products(j) || ', Stoc: ' || DepotsInfo(i).Stocks(j));
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    END GetAllDepotInventory;

    PROCEDURE GetCustomerOrders(p_start_date DATE, p_end_date DATE) AS
        CURSOR CustomerCursor IS
            SELECT id_client, nume, prenume
            FROM CLIENT;
        CURSOR OrderCursor (v_client_id INT) IS
            SELECT id_comanda, numar_produse, data, valoare
            FROM COMANDA
            WHERE id_client = v_client_id
            AND data BETWEEN p_start_date AND p_end_date;
        v_client_id INT;
        v_client_name VARCHAR2(255);
        v_client_surname VARCHAR2(255);
        v_order_id INT;
        v_order_products INT;
        v_order_date DATE;
        v_order_value DECIMAL(10, 2);
    BEGIN
        FOR CustomerRec IN CustomerCursor LOOP
            v_client_id := CustomerRec.id_client;
            v_client_name := CustomerRec.nume;
            v_client_surname := CustomerRec.prenume;
            DBMS_OUTPUT.PUT_LINE('Detalii pentru clientul cu ID ' || v_client_id || ': ' || v_client_name || ' ' || v_client_surname);
            OPEN OrderCursor(v_client_id);
            FETCH OrderCursor INTO v_order_id, v_order_products, v_order_date, v_order_value;
            IF OrderCursor%NOTFOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nicio comandă în intervalul specificat.');
            ELSE
                LOOP
                    DBMS_OUTPUT.PUT_LINE('Comanda ID: ' || v_order_id || ', Produse: ' || v_order_products || ', Data: ' || v_order_date || ', Valoare: ' || v_order_value);
                    FETCH OrderCursor INTO v_order_id, v_order_products, v_order_date, v_order_value;
                    EXIT WHEN OrderCursor%NOTFOUND;
                END LOOP;
            END IF;
            CLOSE OrderCursor;
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    END GetCustomerOrders;

    PROCEDURE plaseaza_comanda(p_id_client INT, p_denumire_produs VARCHAR2, p_cantitate INT) AS
        v_id_locatie INT;
        v_stoc_disponibil INT;
        v_id_comanda INT;
        v_pret_unitar DECIMAL(10, 2);
        v_valoare DECIMAL(10, 2);
    BEGIN
        SELECT dp.id_locatie
        INTO v_id_locatie
        FROM MODEL_PRODUS mp
        JOIN DEPOZIT dp ON mp.id_depozit = dp.id_depozit
        WHERE mp.denumire = p_denumire_produs;
        SELECT stoc, pret
        INTO v_stoc_disponibil, v_pret_unitar
        FROM MODEL_PRODUS
        WHERE denumire = p_denumire_produs;
        IF v_stoc_disponibil >= p_cantitate THEN
            UPDATE MODEL_PRODUS
            SET stoc = stoc - p_cantitate
            WHERE denumire = p_denumire_produs;
            v_valoare := p_cantitate * v_pret_unitar;
            SELECT seq_comanda.NEXTVAL INTO v_id_comanda FROM DUAL;
            INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare)
            VALUES (v_id_comanda, p_id_client, p_cantitate, SYSDATE, v_valoare);
            INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs)
            VALUES (v_id_comanda, (SELECT id_model_cuprins FROM MODEL_PRODUS WHERE denumire = p_denumire_produs));
            DBMS_OUTPUT.PUT_LINE('Comanda plasată cu succes! ID Comanda: ' || v_id_comanda || ', Valoare Comanda: ' || v_valoare);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Stoc insuficient pentru a plasa comanda. Stoc disponibil: ' || v_stoc_disponibil);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: Datele nu au fost găsite.');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: Prea multe înregistrări au fost returnate.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
    END plaseaza_comanda;

    FUNCTION GetCustomerOrderDetails(p_client_id INT) RETURN VARCHAR2 AS
        v_total_value DECIMAL(10, 2);
        v_last_order_details VARCHAR2(4000);
        NoOrdersException EXCEPTION;
        PRAGMA EXCEPTION_INIT(NoOrdersException, -20001);
        NoCustomerException EXCEPTION;
        PRAGMA EXCEPTION_INIT(NoCustomerException, -20003);
    BEGIN
        SELECT COUNT(*)
        INTO v_total_value
        FROM CLIENT
        WHERE id_client = p_client_id;
        IF v_total_value = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Nu există client cu ID-ul specificat.');
        END IF;
        SELECT NVL(SUM(c.valoare), 0), 
            MAX('Ultima comanda:' || CHR(10) || 'Comanda ID: ' || c.id_comanda || ', Produse: ' || c.numar_produse || ', Data: ' || TO_CHAR(c.data, 'DD-MM-YYYY')) ||
            CHR(10) || 'Produse cumparate: ' || CHR(10) ||
            LISTAGG('Produs: ' || mp.denumire || ', Producator: ' || mp.producator || ', Pret: ' || TO_CHAR(mp.pret, 'FM9999.99'), CHR(10)) WITHIN GROUP (ORDER BY pc.id_comanda)
        INTO v_total_value, v_last_order_details
        FROM COMANDA c
        JOIN PRODUS_CUPRINS pc ON c.id_comanda = pc.id_comanda
        JOIN MODEL_PRODUS mp ON pc.id_model_produs = mp.id_model_cuprins
        WHERE c.id_client = p_client_id;
        IF v_total_value = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Clientul nu a făcut nicio comandă.');
        END IF;
        RETURN 'Valoarea totală a comenzilor: ' || TO_CHAR(v_total_value) || CHR(10) || v_last_order_details;
    EXCEPTION
        WHEN NoOrdersException THEN
            RETURN 'Eroare: ' || SQLERRM;
        WHEN NoCustomerException THEN
            RETURN 'Eroare: ' || SQLERRM;
        WHEN OTHERS THEN
            RETURN 'Eroare nedefinită: ' || SQLERRM;
    END GetCustomerOrderDetails;

END my_project_pkg;
/

BEGIN
    my_project_pkg.GetAllDepotInventory;
END;
/

BEGIN
    my_project_pkg.GetCustomerOrders('01-01-2024', '31-01-2024');
END;
/

DECLARE
    v_result VARCHAR2(4000);
BEGIN
    v_result := my_project_pkg.GetCustomerOrderDetails(201);
    DBMS_OUTPUT.PUT_LINE('Rezultat 1: ' || v_result);
END;
/


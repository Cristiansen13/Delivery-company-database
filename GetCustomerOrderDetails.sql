CREATE OR REPLACE FUNCTION GetCustomerOrderDetails(
    p_client_id INT
) RETURN VARCHAR2 AS
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
END;
/

DECLARE
    v_result VARCHAR2(4000);
BEGIN
    v_result := GetCustomerOrderDetails(201);
    DBMS_OUTPUT.PUT_LINE('Rezultat 1: ' || v_result);

    v_result := GetCustomerOrderDetails(206);
    DBMS_OUTPUT.PUT_LINE('Rezultat 2: ' || v_result);

    v_result := GetCustomerOrderDetails(999);
    DBMS_OUTPUT.PUT_LINE('Rezultat 3: ' || v_result);
END;
/
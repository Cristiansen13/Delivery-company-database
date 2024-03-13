CREATE SEQUENCE seq_comanda START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE plaseaza_comanda(
    p_id_client INT,
    p_denumire_produs VARCHAR2,
    p_cantitate INT
)
AS
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
/

BEGIN
    plaseaza_comanda(206, 'Nonexistent Product', 2);
END;

BEGIN
    plaseaza_comanda(207, 'Tablet', 2);
END;

BEGIN
    plaseaza_comanda(206, 'Laptop', 2);
END;
INSERT INTO MODEL_PRODUS (denumire, producator, pret, stoc, id_depozit)
VALUES ('Laptop', 'ProducatorLaptop', 1500.00, 10, 1);
BEGIN
    plaseaza_comanda(206, 'Laptop', 2);
END;

select * from comanda

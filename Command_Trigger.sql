CREATE TABLE LOG_AUDIT_COMENZI (
    actiune VARCHAR2(10),
    timestamp TIMESTAMP
);
CREATE OR REPLACE TRIGGER trg_lmd_comanda
AFTER INSERT OR UPDATE OR DELETE ON COMANDA
DECLARE
    v_action VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
    ELSIF DELETING THEN
        v_action := 'DELETE';
    END IF;
    INSERT INTO LOG_AUDIT_COMENZI (actiune, timestamp)
    VALUES (v_action, SYSTIMESTAMP);
END trg_lmd_comanda;
/
INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES (207, 203, 3, SYSDATE, 3000.00);
UPDATE COMANDA SET numar_produse = 4 WHERE id_comanda = 303;
UPDATE COMANDA SET numar_produse = 4 WHERE id_comanda = 304;

select * from LOG_AUDIT_COMENZI
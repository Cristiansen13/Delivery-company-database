CREATE SEQUENCE error_log_sequence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER livrare_date_check
   BEFORE UPDATE OR INSERT
   ON LIVRARE
   FOR EACH ROW
DECLARE
   v_current_date DATE;
BEGIN
   SELECT SYSDATE INTO v_current_date FROM DUAL;

   IF (:NEW.data > v_current_date) THEN
       INSERT INTO error_log(id_error_log, error_code, error_message)
       VALUES (error_log_sequence.NEXTVAL, -20009, 'Data livrarii nu poate fi in viitor');
       RAISE_APPLICATION_ERROR(-20009, 'Data livrarii nu poate fi in viitor');
   END IF;
END;
/

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES (1, 2, SYSDATE + INTERVAL '1' DAY);

UPDATE LIVRARE 
SET data = SYSDATE + INTERVAL '3' DAY
WHERE id_livrator = 401 AND id_client = 201;

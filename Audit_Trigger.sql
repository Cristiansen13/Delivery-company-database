CREATE TABLE ldd_audit
(
   marca_temporală TIMESTAMP,
   nume_utilizator VARCHAR2(150),
   tip_comandă VARCHAR2(50),
   tip_obiect VARCHAR2(50),
   nume_obiect Varchar2(100)
);

CREATE OR REPLACE TRIGGER ldd_audit_trigger
   AFTER CREATE OR ALTER OR DROP
   ON SCHEMA
BEGIN
   INSERT INTO ldd_audit
   VALUES (SYSTIMESTAMP, USER, ORA_SYSEVENT, ORA_DICT_OBJ_TYPE, ORA_DICT_OBJ_NAME);
END;
/

CREATE TABLE test
(
   id NUMĂR
);

ALTER TABLE test ADD CONSTRAINT test_pk PRIMARY KEY (id);
DROP TABLE test;

SELECT * FROM LDD_AUDIT;
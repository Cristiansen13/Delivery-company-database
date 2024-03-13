
CREATE OR REPLACE PROCEDURE GetAllDepotInventory AS
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
END;
/

EXEC GetAllDepotInventory;
CREATE OR REPLACE PROCEDURE GetCustomerOrders(
    p_start_date DATE,
    p_end_date DATE
) AS
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
END;
/

EXEC GetCustomerOrders('01-01-2024', '31-01-2024');
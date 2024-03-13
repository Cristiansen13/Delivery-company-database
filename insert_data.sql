
INSERT INTO LOCATIE (id_locatie, judet, oras, strada, numar_strada) VALUES
(1, 'Bucharest', 'Bucharest', 'Main Street', '123');

INSERT INTO LOCATIE (id_locatie, judet, oras, strada, numar_strada) VALUES
(2, 'Ilfov', 'Voluntari', 'Central Street', '456');

INSERT INTO LOCATIE (id_locatie, judet, oras, strada, numar_strada) VALUES
(3, 'Cluj', 'Cluj-Napoca', 'Victory Street', '789');

INSERT INTO LOCATIE (id_locatie, judet, oras, strada, numar_strada) VALUES
(4, 'Timis', 'Timisoara', 'Freedom Street', '101');

INSERT INTO LOCATIE (id_locatie, judet, oras, strada, numar_strada) VALUES
(5, 'Constanta', 'Constanta', 'Seaside Street', '202');

INSERT INTO DEPOZIT (id_depozit, id_locatie, denumire, capacitate) VALUES
(101, 1, 'Main Depot', 500);

INSERT INTO DEPOZIT (id_depozit, id_locatie, denumire, capacitate) VALUES
(102, 2, 'Central Warehouse', 300);

INSERT INTO DEPOZIT (id_depozit, id_locatie, denumire, capacitate) VALUES
(103, 3, 'Victory Storage', 700);

INSERT INTO DEPOZIT (id_depozit, id_locatie, denumire, capacitate) VALUES
(104, 4, 'Freedom Stockroom', 400);

INSERT INTO DEPOZIT (id_depozit, id_locatie, denumire, capacitate) VALUES
(105, 5, 'Seaside Depot', 600);

INSERT INTO MODEL_PRODUS (id_model_cuprins, id_depozit, stoc, denumire, producator, pret) VALUES
(1001, 101, 50, 'Laptop', 'ABC Electronics', 1200.00);

INSERT INTO MODEL_PRODUS (id_model_cuprins, id_depozit, stoc, denumire, producator, pret) VALUES
(1002, 102, 30, 'Smartphone', 'XYZ Tech', 800.00);

INSERT INTO MODEL_PRODUS (id_model_cuprins, id_depozit, stoc, denumire, producator, pret) VALUES
(1003, 103, 80, 'Camera', 'CameraCo', 300.00);

INSERT INTO MODEL_PRODUS (id_model_cuprins, id_depozit, stoc, denumire, producator, pret) VALUES
(1004, 104, 40, 'Headphones', 'AudioTech', 150.00);

INSERT INTO MODEL_PRODUS (id_model_cuprins, id_depozit, stoc, denumire, producator, pret) VALUES
(1005, 105, 60, 'Tablet', 'TechGadget', 500.00);

INSERT INTO COMENTARIU (id_comentariu, likeuri) VALUES
(501, 10);

INSERT INTO COMENTARIU (id_comentariu, likeuri) VALUES
(502, 5);

INSERT INTO COMENTARIU (id_comentariu, likeuri) VALUES
(503, 15);

INSERT INTO COMENTARIU (id_comentariu, likeuri) VALUES
(504, 8);

INSERT INTO COMENTARIU (id_comentariu, likeuri) VALUES
(505, 12);

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(201, 'John', 'Doe', 'john.doe@example.com');

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(202, 'Jane', 'Smith', 'jane.smith@example.com');

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(203, 'Alex', 'Johnson', 'alex.johnson@example.com');

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(204, 'Emily', 'Williams', 'emily.williams@example.com');

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(205, 'David', 'Brown', 'david.brown@example.com');

INSERT INTO CLIENT (id_client, nume, prenume, email) VALUES
(206, 'Andrew', 'Lee', 'andrew.lee@example.com');

INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES
(301, 201, 2, '01-01-2024', 2400.00);

INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES
(302, 202, 1, '02-01-2024', 800.00);

INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES
(303, 203, 3, '03-01-2024', 900.00);

INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES
(304, 204, 1, '04-01-2024', 150.00);

INSERT INTO COMANDA (id_comanda, id_client, numar_produse, data, valoare) VALUES
(305, 205, 2, '05-01-2024', 1000.00);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(301, 1001);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(302, 1002);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(303, 1003);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(304, 1004);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(305, 1005);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(301, 1002);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(302, 1003);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(302, 1004);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(303, 1002);

INSERT INTO PRODUS_CUPRINS (id_comanda, id_model_produs) VALUES
(303, 1001);

INSERT INTO LIVRATOR (id_livrator, nume, prenume) VALUES
(401, 'Michael', 'Smith');

INSERT INTO LIVRATOR (id_livrator, nume, prenume) VALUES
(402, 'Laura', 'Johnson');

INSERT INTO LIVRATOR (id_livrator, nume, prenume) VALUES
(403, 'Daniel', 'Brown');

INSERT INTO LIVRATOR (id_livrator, nume, prenume) VALUES
(404, 'Emma', 'Davis');

INSERT INTO LIVRATOR (id_livrator, nume, prenume) VALUES
(405, 'William', 'Jones');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1001, 401, '06-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1002, 402, '07-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1003, 403, '08-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1004, 404, '09-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1005, 405, '10-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1001, 402, '06-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1002, 403, '07-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1003, 404, '08-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1004, 405, '09-01-2024');

INSERT INTO RIDICARE (id_model_produs, id_livrator, data) VALUES
(1005, 404, '10-01-2024');

INSERT INTO VEHICUL_DE_TRANSPORT (id_masina, id_livrator, model, autonomie) VALUES
(501, 401, 'Van', 300);

INSERT INTO VEHICUL_DE_TRANSPORT (id_masina, id_livrator, model, autonomie) VALUES
(502, 402, 'Car', 250);

INSERT INTO VEHICUL_DE_TRANSPORT (id_masina, id_livrator, model, autonomie) VALUES
(503, 403, 'Truck', 400);

INSERT INTO VEHICUL_DE_TRANSPORT (id_masina, id_livrator, model, autonomie) VALUES
(504, 404, 'Scooter', 100);

INSERT INTO VEHICUL_DE_TRANSPORT (id_masina, id_livrator, model, autonomie) VALUES
(505, 405, 'Bike', 50);

INSERT INTO RECENZIE (id_recenzie, id_comentariu, id_client, id_model_produs, stele) VALUES
(601, 501, 201, 1001, 5);

INSERT INTO RECENZIE (id_recenzie, id_comentariu, id_client, id_model_produs, stele) VALUES
(602, 502, 202, 1002, 4);

INSERT INTO RECENZIE (id_recenzie, id_comentariu, id_client, id_model_produs, stele) VALUES
(603, 503, 203, 1003, 5);

INSERT INTO RECENZIE (id_recenzie, id_comentariu, id_client, id_model_produs, stele) VALUES
(604, 504, 204, 1004, 3);

INSERT INTO RECENZIE (id_recenzie, id_comentariu, id_client, id_model_produs, stele) VALUES
(605, 505, 205, 1005, 4);

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(401, 201, '11-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(402, 202, '12-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(403, 203, '13-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(404, 204, '14-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(405, 205, '15-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(402, 201, '11-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(403, 201, '12-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(404, 202, '13-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(405, 204, '14-01-2024');

INSERT INTO LIVRARE (id_livrator, id_client, data) VALUES
(404, 203, '15-01-2024');
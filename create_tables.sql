CREATE TABLE LOCATIE (
    id_locatie INT PRIMARY KEY,
    judet VARCHAR(255),
    oras VARCHAR(255),
    strada VARCHAR(255),
    numar_strada VARCHAR(255)
);

CREATE TABLE DEPOZIT (
    id_depozit INT PRIMARY KEY,
    id_locatie INT,
    denumire VARCHAR(255),
    capacitate INT,
    FOREIGN KEY (id_locatie) REFERENCES LOCATIE(id_locatie)
);

CREATE TABLE MODEL_PRODUS (
    id_model_cuprins INT PRIMARY KEY,
    id_depozit INT,
    stoc INT,
    denumire VARCHAR(255),
    producator VARCHAR(255),
    pret DECIMAL(10, 2),
    FOREIGN KEY (id_depozit) REFERENCES DEPOZIT(id_depozit)
);

CREATE TABLE COMENTARIU (
    id_comentariu INT PRIMARY KEY,
    likeuri INT
);

CREATE TABLE CLIENT (
    id_client INT PRIMARY KEY,
    nume VARCHAR(255),
    prenume VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE COMANDA (
    id_comanda INT PRIMARY KEY,
    id_client INT,
    numar_produse INT,
    data DATE,
    valoare DECIMAL(10, 2),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

CREATE TABLE PRODUS_CUPRINS (
    id_comanda INT,
    id_model_produs INT,
    PRIMARY KEY (id_comanda, id_model_produs),
    FOREIGN KEY (id_comanda) REFERENCES COMANDA(id_comanda),
    FOREIGN KEY (id_model_produs) REFERENCES MODEL_PRODUS(id_model_cuprins)
);

CREATE TABLE LIVRATOR (
    id_livrator INT PRIMARY KEY,
    nume VARCHAR(255),
    prenume VARCHAR(255)
);

CREATE TABLE RIDICARE (
    id_model_produs INT,
    id_livrator INT,
    data DATE,
    PRIMARY KEY (id_model_produs, id_livrator),
    FOREIGN KEY (id_model_produs) REFERENCES MODEL_PRODUS(id_model_cuprins),
    FOREIGN KEY (id_livrator) REFERENCES LIVRATOR(id_livrator)
);

CREATE TABLE VEHICUL_DE_TRANSPORT (
    id_masina INT PRIMARY KEY,
    id_livrator INT,
    model VARCHAR(255),
    autonomie INT,
    FOREIGN KEY (id_livrator) REFERENCES LIVRATOR(id_livrator)
);

CREATE TABLE RECENZIE (
    id_recenzie INT PRIMARY KEY,
    id_comentariu INT,
    id_client INT,
    id_model_produs INT,
    stele INT,
    FOREIGN KEY (id_comentariu) REFERENCES COMENTARIU(id_comentariu),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
    FOREIGN KEY (id_model_produs) REFERENCES MODEL_PRODUS(id_model_cuprins)
);

CREATE TABLE LIVRARE (
    id_livrator INT,
    id_client INT,
    data DATE,
    PRIMARY KEY (id_livrator, id_client),
    FOREIGN KEY (id_livrator) REFERENCES LIVRATOR(id_livrator),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);
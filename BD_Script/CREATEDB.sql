

USE master
go

CREATE DATABASE BD_Coeco
go

use BD_Coeco
go

CREATE TABLE tbl_Status
(
	idStatus INT IDENTITY (1,1) PRIMARY KEY,
	nomStatus VARCHAR(250) NOT NULL
)

INSERT INTO tbl_Status (nomStatus) VALUES ('En cours');
INSERT INTO tbl_Status (nomStatus) VALUES ('En attente d''approbation');
INSERT INTO tbl_Status (nomStatus) VALUES ('Terminé');

CREATE TABLE tbl_TypeEmploye
(
	idType INT IDENTITY (1,1) PRIMARY KEY,
	nomType VARCHAR(20) NOT NULL
)

INSERT INTO tbl_TypeEmploye (nomType) VALUES ('Bureau');
INSERT INTO tbl_TypeEmploye (nomType) VALUES ('Terrain');

CREATE TABLE tbl_Employe
(
	idEmploye INT IDENTITY (1,1) PRIMARY KEY,
	prenom VARCHAR(250) NOT NULL,
	nom VARCHAR(250) NOT NULL,
	idTypeEmpl INT NOT NULL,
	noTel VARCHAR(50),
	email VARCHAR(250),
	username VARCHAR(250) NOT NULL,
	password VARCHAR(250),
	inactif BIT DEFAULT 0,

	--FOREIGN KEY
	CONSTRAINT FK_tbl_Employe_idTypeEmpl FOREIGN KEY (idTypeEmpl) REFERENCES tbl_TypeEmploye(idType)
)

INSERT INTO tbl_Employe (prenom, nom, idTypeEmpl, noTel, email, username, password, inactif) 
VALUES ('Marc-André', 'Fortin', 1 , '123-456-7890', 'monemail@gmail.com', 'marc', 'pwd123', 0)
INSERT INTO tbl_Employe (prenom, nom, idTypeEmpl, noTel, email, username, password, inactif) 
VALUES ('Mathieu', 'Rioux', 2 , '123-456-7890', 'monemail@gmail.com', 'mathieu', 'pwd123', 0)
INSERT INTO tbl_Employe (prenom, nom, idTypeEmpl, noTel, email, username, password, inactif) 
VALUES ('David', 'Jalbert', 2 , '123-456-7890', 'monemail@gmail.com', 'david', 'pwd123', 1)

CREATE TABLE tbl_Projet
(
	idProjet INT IDENTITY (1,1) PRIMARY KEY,
	titre VARCHAR(250) NOT NULL,
	description VARCHAR(MAX),
	idStatus INT NOT NULL,
	idEmployeResp INT,
	tempsAllouer FLOAT(24),
	dateDebut SMALLDATETIME DEFAULT GETDATE(),
	dateFin SMALLDATETIME DEFAULT GETDATE(),
	archiver BIT DEFAULT 0,

	--FOREIGN KEY
	CONSTRAINT FK_tbl_Projet_idEmployeResp FOREIGN KEY (idEmployeResp) REFERENCES tbl_Employe(idEmploye),
	CONSTRAINT FK_tbl_Projet_idStatus FOREIGN KEY (idStatus) REFERENCES tbl_Status(idstatus)
)

INSERT INTO tbl_Projet(titre, description, idStatus, idEmployeResp, tempsAllouer,archiver) 
VALUES ('Mon premier projet', 'Une belle description', 1, 1, 24, 0)
INSERT INTO tbl_Projet(titre, description, idStatus, idEmployeResp, tempsAllouer,archiver) 
VALUES ('Mon deuxième projet', 'Une autre belle description', 2, 2, 12, 0)
INSERT INTO tbl_Projet(titre, description, idStatus, idEmployeResp, tempsAllouer,archiver) 
VALUES ('Mon troisième projet', 'Une tout autre belle description', 3, 3, 40, 1)

CREATE TABLE tbl_ProjetCat
(
	idCat INT IDENTITY(1,1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCatMaitre INT,
	titre VARCHAR(250) NOT NULL,
	description VARCHAR(MAX),

	--FOREIGN KEY
	CONSTRAINT FK_tbl_ProjetCat_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_ProjetCat_idCatMaitre FOREIGN KEY (idCatMaitre) REFERENCES tbl_ProjetCat(idCat)
)

INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, NULL, 'Sous-Categorie Projet 1', 'Une description');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Sous-Sous-Categorie 1 Projet 1', 'Une description 2');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Sous-Sous-Categorie 2 Projet 1', 'Une description 2');

INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (2, NULL, 'Sous-Categorie Projet 2', 'Une description');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (2, 4, 'Sous-Sous-Categorie 1 Projet 2', 'Une description 2');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (2, 4, 'Sous-Sous-Categorie 2 Projet 2', 'Une description 2');

INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (3, NULL, 'Sous-Categorie Projet 3', 'Une description');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (3, 7, 'Sous-Sous-Categorie 1 Projet 3', 'Une description 2');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (3, 7, 'Sous-Sous-Categorie 2 Projet 3', 'Une description 2');

CREATE TABLE tbl_FeuilleTemps
(
	idFeuille INT IDENTITY(1, 1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCat INT,
	idEmploye INT NOT NULL,
	nbHeure FLOAT(24) NOT NULL,
	commentaire VARCHAR(MAX),
	dateCreation SMALLDATETIME DEFAULT GETDATE(),

	-- FOREIGN KEY
	CONSTRAINT FK_tbl_FeuilleTemps_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_FeuilleTemps_idCat FOREIGN KEY (idCat) REFERENCES tbl_ProjetCat(idCat),
	CONSTRAINT FK_tbl_FeuilleTemps_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye)
)

INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (1, 1, 1, 10, 'Ce fut une belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (2, 3, 2, 8, 'Ce fut une autre belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (3, 5, 3, 15, 'Ce fut une excellente journée', GETDATE());

CREATE TABLE tbl_ProjetCatEmploye
(
	idPCE INT IDENTITY(500,1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCategorie INT NOT NULL,
	idEmploye INT NOT NULL
	
	-- FOREIGN KEY 
	CONSTRAINT FK_tbl_ProjetCatEmploye_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_ProjetCatEmploye_idCat FOREIGN KEY (idCategorie) REFERENCES tbl_ProjetCat(idCat),
	CONSTRAINT FK_tbl_ProjetCatEmploye_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye)
)

INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (1, 1, 1) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (1, 2, 1) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (1, 3, 1) 

INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (2, 4, 2) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (2, 5, 2) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (2, 6, 2) 

INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (3, 7, 3) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (3, 8, 3) 
INSERT INTO tbl_ProjetCatEmploye (idProjet, idCategorie, idEmploye)
VALUES (3, 9, 3) 
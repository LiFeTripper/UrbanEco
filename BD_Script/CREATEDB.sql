

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

INSERT INTO tbl_Employe (prenom, nom, idTypeEmpl, noTel, email, username, password, inactif) 
VALUES ('Administrateur', '', 1 , '123-456-7890', 'monemail@gmail.com', 'admin', 'mobius', 0)

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
INSERT INTO tbl_Projet(titre, description, idStatus, idEmployeResp, tempsAllouer,archiver) 
VALUES ('Vacances et congés', 'Congé, vacances et temps supplémentaires', 1, 1, 40, 0)

CREATE TABLE tbl_ProjetCat
(
	idProjetCat INT IDENTITY(1,1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCatMaitre INT,
	titre VARCHAR(250) NOT NULL,
	description VARCHAR(MAX),

	--FOREIGN KEY
	CONSTRAINT FK_tbl_ProjetCat_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_ProjetCat_idCatMaitre FOREIGN KEY (idCatMaitre) REFERENCES tbl_ProjetCat(idProjetCat)
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

INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (4, NULL, 'Congés fériés', 'Utilise les heures de congés fériés de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (4, NULL, 'Congés vacances', 'Utilise les heures de congés vacances de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (4, NULL, 'Temps supplémentaires', 'Utilise les heures supplémentaires de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (4, NULL, 'Congés maladies', 'Utilise les heures de congés maladies de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (4, NULL, 'Congé personnelle', 'Utilise les heures de congés personnelles de la banque dheures');

CREATE TABLE tbl_FeuilleTemps
(
	idFeuille INT IDENTITY(1, 1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCat INT DEFAULT NULL,
	idEmploye INT NOT NULL,
	nbHeure FLOAT(24) NOT NULL,
	commentaire VARCHAR(MAX),
	dateCreation SMALLDATETIME DEFAULT GETDATE(),
	approuver BIT DEFAULT 0,

	-- FOREIGN KEY
	CONSTRAINT FK_tbl_FeuilleTemps_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_FeuilleTemps_idCat FOREIGN KEY (idCat) REFERENCES tbl_ProjetCat(idProjetCat),
	CONSTRAINT FK_tbl_FeuilleTemps_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye)
)

INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (1, 1, 1, 10, 'Ce fut une belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (2, 3, 2, 8, 'Ce fut une autre belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (3, 5, 3, 15, 'Ce fut une excellente journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (1, 1, 1, 10, 'Ce fut une belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (2, 3, 2, 8, 'Ce fut une autre belle journée', GETDATE());
INSERT INTO tbl_FeuilleTemps(idProjet, idCat, idEmploye, nbHeure, commentaire, dateCreation) 
VALUES (3, 5, 3, 15, 'Ce fut une excellente journée', GETDATE());
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
	CONSTRAINT FK_tbl_ProjetCatEmploye_idCat FOREIGN KEY (idCategorie) REFERENCES tbl_ProjetCat(idProjetCat),
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


CREATE TABLE tbl_TypeHeure
(
	idTypeHeure INT IDENTITY(1,1) PRIMARY KEY,
	nomTypeHeure VARCHAR(250) NOT NULL
)

INSERT INTO tbl_TypeHeure (nomTypeHeure) VALUES ('Heure en banque');
INSERT INTO tbl_TypeHeure (nomTypeHeure) VALUES ('Jour férié');
INSERT INTO tbl_TypeHeure (nomTypeHeure) VALUES ('Congé personnel');
INSERT INTO tbl_TypeHeure (nomTypeHeure) VALUES ('Vacance');
INSERT INTO tbl_TypeHeure (nomTypeHeure) VALUES ('Congé maladie');

CREATE TABLE tbl_BanqueHeure
(
	idBanqueHeure INT IDENTITY(1,1) PRIMARY KEY,
	idEmploye INT NOT NULL,
	idTypeHeure INT NOT NULL,
	nbHeureInitial FLOAT(24),
	nbHeure FLOAT(24)
	--Cancer
	
	--FOREIGN KEY

	CONSTRAINT FK_tbl_BanqueHeure_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye),
	CONSTRAINT FK_tbl_BanqueHeure_idTypeHeure FOREIGN KEY (idTypeHeure) REFERENCES tbl_TypeHeure(idTypeHeure)

)


INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (1,1,5,5);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (1,2,10,10);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (1,3,4,4);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (1,4,3,3);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (1,5,22,2);

INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (2,1,15,15);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (2,2,10,10);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (2,3,14,14);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (2,4,13,13);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (2,5,12,12);

INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (3,1,25,25);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (3,2,21,21);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (3,3,24,24);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (3,4,23,23);
INSERT INTO tbl_BanqueHeure(idEmploye,idTypeHeure,nbHeure, nbHeureInitial) VALUES (3,5,22,22);

CREATE TABLE tbl_TypeDepense
(
	idTypeDepense INT PRIMARY KEY,
	nomDepense VARCHAR(250),
	idTypeEmploye INT,

	CONSTRAINT FK_tbl_TypeDepense_idTypeEmploye FOREIGN KEY (idTypeEmploye) REFERENCES tbl_TypeEmploye(idType)

)

INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (1, 'Déplacement (Voiture)', NULL);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (2, 'Déplacement (Camion)', NULL);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (3, 'Restaurant',1);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (4, 'Restaurant',2);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (5, 'Autre (Bureau)',1);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (6, 'Autre (Terrain)',2);

CREATE TABLE tbl_Depense
(
	idDepense INT IDENTITY(1,1) PRIMARY KEY,
	idEmploye INT NOT NULL,
	typeDepense VARCHAR(250) NOT NULL,

	idProjetCat INT DEFAULT NULL,
	note VARCHAR(MAX),
	dateDepense SMALLDATETIME DEFAULT GETDATE(),
	montant FLOAT(24) DEFAULT 0,
	prixKilometrage FLOAT (24) DEFAULT NULL,
	approuver BIT DEFAULT 0 NOT NULL,
	--FOREIGN KEY

	CONSTRAINT FK_tbl_Depenses_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye),
	--CONSTRAINT FK_tbl_Depenses_idTypeDepense FOREIGN KEY (idTypeDepense) REFERENCES tbl_TypeDepense(idTypeDepense)
	CONSTRAINT FK_tbl_Depenses_idProjetCat FOREIGN KEY (idProjetCat) REFERENCES tbl_ProjetCat(idProjetCat)
)

CREATE TABLE tbl_Kilometrage
(
	idKilometrage INT IDENTITY(1,1) PRIMARY KEY,
	prixKilometrageVoiture FLOAT(24) NOT NULL,
	prixKilometrageCamion FLOAT(24) NOT NULL
)

INSERT INTO tbl_Kilometrage(prixKilometrageVoiture,prixKilometrageCamion) VALUES (0.47,0.67);


CREATE TABLE tbl_PremierDimanche
(
	idPremierDimanche INT IDENTITY(1,1) PRIMARY KEY,
	dateDimanche SMALLDATETIME NOT NULL
)

CREATE TABLE tbl_TempsSupp
(
	idTempsSupp INT IDENTITY(1,1) PRIMARY KEY,
	idEmploye INT NOT NULL,
	noSemaine INT NOT NULL,
	tempsSupp FLOAT(24) DEFAULT 0,

	CONSTRAINT FK_tbl_TempsSupp_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye)
)

--Web User

USE [master]
GO
CREATE LOGIN [WEB_USER] WITH PASSWORD=N'1234', DEFAULT_DATABASE=[BD_Coeco], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [diskadmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [processadmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [serveradmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [setupadmin] ADD MEMBER [WEB_USER]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
CREATE USER [WEB_USER] FOR LOGIN [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_owner] ADD MEMBER [WEB_USER]
GO
USE [BD_Coeco]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [WEB_USER]
GO




USE master
go
DROP DATABASE BD_Coeco_Test
CREATE DATABASE BD_Coeco_Test
go

use BD_Coeco_Test
go

CREATE TABLE tbl_ConfigAdmin(
	idConfigAdmin INT PRIMARY KEY IDENTITY(1,1),
	jourRappel VARCHAR(8) DEFAULT 'Lundi',
    heureRappel TIME NOT NULL DEFAULT '08:00:00',
    emailRappel VARCHAR(80) NOT NULL,
    pwdEmailRappel VARCHAR(256) NOT NULL,
    statutRappelBureau BIT DEFAULT 1,
	statutRappelTerrain BIT DEFAULT 1,
    objetRappel VARCHAR(70) NOT NULL,
    contenuRappel VARCHAR(MAX) NOT NULL,
    smtpServer VARCHAR(100) NOT NULL,
    smtpPort INT NOT NULL,
    smtpSSL BIT DEFAULT 1,
    CONSTRAINT cJourSemaine CHECK (jourRappel IN ('Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi')),
)
INSERT INTO tbl_ConfigAdmin ([jourRappel],[heureRappel],[emailRappel],[pwdEmailRappel],[statutRappelBureau],[statutRappelTerrain],[objetRappel],[contenuRappel],[smtpServer],[smtpPort],[smtpSSL]) VALUES ('Lundi','08:00:00','theverygoodteam@gmail.com','CodeBreaker',1,1,'Voici un objet','Voici un contenu','smtp.gmail.com',587,1)

CREATE TABLE tbl_Status
(
	idStatus INT IDENTITY (1,1) PRIMARY KEY,
	nomStatus VARCHAR(250) NOT NULL
)

INSERT INTO tbl_Status (nomStatus) VALUES ('En cours');
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
	email VARCHAR(250),
	username VARCHAR(250) NOT NULL UNIQUE,
	password VARCHAR(250),
	inactif BIT DEFAULT 0,
	nbHeureSemaine FLOAT(24) DEFAULT 0,

	--FOREIGN KEY
	CONSTRAINT FK_tbl_Employe_idTypeEmpl FOREIGN KEY (idTypeEmpl) REFERENCES tbl_TypeEmploye(idType)
)
INSERT INTO tbl_Employe (prenom, nom, idTypeEmpl, email, username, password, inactif) 
VALUES ('Administrateur', '', 1 , 'monemail@gmail.com', 'admin', 'mobius', 0)

CREATE TABLE tbl_Projet
(
	idProjet INT IDENTITY (1,1) PRIMARY KEY,
	titre VARCHAR(250) NOT NULL,
	description VARCHAR(MAX),
	idStatus INT NOT NULL,
	idEmployeResp INT,
	approbation BIT DEFAULT 0,
	tempsAllouer FLOAT(24),
	dateDebut SMALLDATETIME DEFAULT GETDATE(),
	dateFin SMALLDATETIME DEFAULT GETDATE(),
	archiver BIT DEFAULT 0,

	--FOREIGN KEY
	CONSTRAINT FK_tbl_Projet_idEmployeResp FOREIGN KEY (idEmployeResp) REFERENCES tbl_Employe(idEmploye),
	CONSTRAINT FK_tbl_Projet_idStatus FOREIGN KEY (idStatus) REFERENCES tbl_Status(idstatus)
)

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
VALUES (1, NULL, 'Général', '');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Congés fériés', 'Utilise les heures de congés fériés de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Congés vacances', 'Utilise les heures de congés vacances de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Temps supplémentaires', 'Utilise les heures supplémentaires de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Congés maladies', 'Utilise les heures de congés maladies de la banque dheures');
INSERT INTO tbl_ProjetCat(idProjet,idCatMaitre, titre,description) 
VALUES (1, 1, 'Congé personnelle', 'Utilise les heures de congés personnelles de la banque dheures');


CREATE TABLE tbl_FeuilleTemps
(
	idFeuille INT IDENTITY(1, 1) PRIMARY KEY,
	idProjet INT NOT NULL,
	idCat INT DEFAULT NULL,
	idEmploye INT NOT NULL,
	nbHeure FLOAT(24) NOT NULL,
	commentaire VARCHAR(MAX),
	noSemaine INT DEFAULT 0,
	dateCreation SMALLDATETIME DEFAULT GETDATE(),
	approuver BIT DEFAULT 0,

	-- FOREIGN KEY
	CONSTRAINT FK_tbl_FeuilleTemps_idProjet FOREIGN KEY (idProjet) REFERENCES tbl_Projet(idProjet),
	CONSTRAINT FK_tbl_FeuilleTemps_idCat FOREIGN KEY (idCat) REFERENCES tbl_ProjetCat(idProjetCat),
	CONSTRAINT FK_tbl_FeuilleTemps_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye)
)


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
	
	--FOREIGN KEY

	CONSTRAINT FK_tbl_BanqueHeure_idEmploye FOREIGN KEY (idEmploye) REFERENCES tbl_Employe(idEmploye),
	CONSTRAINT FK_tbl_BanqueHeure_idTypeHeure FOREIGN KEY (idTypeHeure) REFERENCES tbl_TypeHeure(idTypeHeure)

)


CREATE TABLE tbl_TypeDepense
(
	idTypeDepense INT PRIMARY KEY,
	nomDepense VARCHAR(250),
	idTypeEmploye INT,

	CONSTRAINT FK_tbl_TypeDepense_idTypeEmploye FOREIGN KEY (idTypeEmploye) REFERENCES tbl_TypeEmploye(idType)

)

INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (1, 'Déplacement (Voiture)', NULL);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (2, 'Déplacement (Camion)', NULL);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (3, 'Autre (Bureau)',1);
INSERT INTO tbl_TypeDepense (idTypeDepense, nomDepense, idTypeEmploye) VALUES (4, 'Autre (Terrain)',2);

CREATE TABLE tbl_Depense
(
	idDepense INT IDENTITY(1,1) PRIMARY KEY,
	idEmploye INT NOT NULL,
	typeDepense VARCHAR(250) NOT NULL,
	facturePath VARCHAR(MAX) DEFAULT NULL,
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
	idPremierDimanche INT DEFAULT 1 PRIMARY KEY,
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

USE BD_Coeco_Test
GO

Set Identity_Insert tbl_Employe ON
GO


 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username, password)
 VALUES (36, 'Employe', 'Supprimer', '', 2, 1, '@#!@', '#!@@#$$')

INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username, password)
 VALUES (64, 'Employe', 'Supprimer', '', 2, 1, '@!#$', '$#@@#$')

 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username, password)
 VALUES (69, 'Employe', 'Supprimer', '', 2, 1, '#@!@', '%?%#@$$')

-- IMPORTER LES EMPLOY�S AVEC LEURS USER
 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username, password)
	SELECT emp.id, emp.prenom, emp.nom, emp.email, 2 as idTypeEmpl, 
	(CASE WHEN us.sttus = 0 THEN 1 else 0 END) as Inactif , us.usr AS username, ('') AS emptyPassword
	FROM coeco.dbo.tblemploye AS emp
	JOIN coeco.dbo.tbluser AS us ON us.idperso = emp.id
	WHERE 1=1
	AND us.tpe = 'emp'
	ORDER BY emp.id

Set Identity_Insert tbl_Employe OFF
GO

--Finalement on prend pas la contrainte unique
--ALTER TABLE tbl_Employe
--ADD CONSTRAINT UC_tbl_Employe_Unique UNIQUE(prenom, nom) 
--GO



Set Identity_Insert tbl_Projet ON
GO

-- Admin ID = 8
 INSERT INTO tbl_Projet (idProjet, titre, description, approbation, idStatus, idEmployeResp, tempsAllouer, dateDebut, dateFin, archiver)
VALUES (13, 'Projet supprime', '', 0, 2, 1, 0, '1900-01-01','1900-01-01', 1)


-- IMPORTER LES PROJETS
 INSERT INTO tbl_Projet (idProjet, titre, description, approbation, idStatus, idEmployeResp, tempsAllouer, dateDebut, dateFin, archiver)
	SELECT proj.id, proj.titre, proj.description, 0 AS approbation,(CASE WHEN proj.status = 1 THEN 1 else 2 END) AS idStatus, 
	1 AS AdminID, proj.temps, 
	(CASE WHEN proj.datedebut IS NULL THEN proj.dateInsc else proj.datedebut END) AS dateDebut, 
	proj.datefin, (CASE WHEN proj.status = 0 THEN 1 else 0 END) as archiver 
	FROM coeco.dbo.tblprojet AS proj

Set Identity_Insert tbl_Projet OFF
GO



Set Identity_Insert tbl_ProjetCat ON
GO

-- IMPORTER LES CAT�GORIES DE PROJETS
 INSERT INTO tbl_ProjetCat (idProjetCat, idProjet, idCatMaitre, titre, description)
	SELECT projCat.id, projCat.idprojet, (CASE WHEN projCat.idcatmaitre = 0 THEN NULL else projCat.idcatmaitre END) AS idCatMaitre,
	 projCat.titre, projCat.description 
	FROM coeco.dbo.tblprojetcat AS projCat

Set Identity_Insert tbl_ProjetCat OFF
GO

Set Identity_Insert tbl_ProjetCatEmploye ON
GO

-- IMPORTER LES CAT�GORIES DE PROJETS
 INSERT INTO tbl_ProjetCatEmploye (idPCE, idProjet, idCategorie, idEmploye)
	SELECT catPerso.id, catPerso.idprojet, catPerso.idcat, catPerso.idperso 
	FROM coeco.dbo.tblprojetcatperso AS catPerso
	WHERE catPerso.tbl = 'tblemploye'
	ORDER BY catPerso.idperso
	

Set Identity_Insert tbl_ProjetCatEmploye OFF
GO

--SORTIR LES ID DES EMPLOY�S QUI NE SONT PAS PR�SENT DANS LES CAT�GORIES
--SELECT * FROM coeco.dbo.tblprojetcatperso AS c
--WHERE 1=1
--AND c.tbl = 'tblemploye'
--AND idperso NOT IN (SELECT id FROM coeco.dbo.tblemploye)

Set Identity_Insert tbl_FeuilleTemps ON
GO

DELETE FROM coeco.dbo.tblheure
WHERE idCat IN (56, 58, 378)

-- IMPORTER LES CAT�GORIES DE PROJETS
 INSERT INTO tbl_FeuilleTemps (idFeuille, idProjet, idCat, idEmploye, nbHeure, commentaire, noSemaine, dateCreation, approuver)
	SELECT id, idprojet, idcat, idperso, temps, c.note, 0 AS noSemaine, (CASE WHEN c.dateEffect IS NULL THEN c.dateInsc else c.dateEffect END)AS dateCreation, 1 AS approuver 
	FROM coeco.dbo.tblheure AS c
	

Set Identity_Insert tbl_FeuilleTemps OFF
GO

--ID FT PROJET NOT IN PROJET
--SELECT idProjet FROM coeco.dbo.tblheure
--WHERE idProjet NOT IN (SELECT id FROM coeco.dbo.tblprojet)

----ID CAT NOT IN PROJET CAT
--SELECT DISTINCT idcat FROM coeco.dbo.tblheure
--WHERE idcat NOT IN (SELECT id FROM coeco.dbo.tblprojetcat)


--SELECT TOP 300 * FROM tbl_FeuilleTemps
--ORDER BY idFeuille DESC, dateCreation

--Creer procedure stocker

IF OBJECT_ID ( 'PS_ChangeCatMaster', 'P' ) IS NOT NULL 
    DROP PROCEDURE PS_ChangeCatMaster 
GO
CREATE PROC PS_ChangeCatMaster
	@idCat INT
AS
	--Créé une nouvelle catégorie N1
	INSERT INTO tbl_ProjetCat (idProjet, idCatMaitre, titre, description)(
		SELECT idProjet, NULL, 'Général', description FROM tbl_ProjetCat
		WHERE idProjetCat = @idCat
	)
	--Transfert de la catégorie N1 vers N2 et l'attaché à la nouvelle catégorie
	UPDATE tbl_ProjetCat
	SET idCatMaitre = (SELECT MAX(idProjetCat) FROM tbl_ProjetCat)
	WHERE idProjetCat = @idCat

	--Garder les catégories existantes
	UPDATE tbl_ProjetCat
	SET idCatMaitre = (SELECT MAX(idProjetCat) FROM tbl_ProjetCat)
	WHERE idCatMaitre = @idCat

GO






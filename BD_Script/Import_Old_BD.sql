USE BD_Coeco
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





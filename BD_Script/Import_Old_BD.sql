USE BD_Coeco_Test
GO

Set Identity_Insert tbl_Employe ON
GO


 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username)
 VALUES (36, 'Employé', 'Supprimer', '', 2, 1, 'suppr')

INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username)
 VALUES (64, 'Employé', 'Supprimer', '', 2, 1, '@!#$')

 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username)
 VALUES (69, 'Employé', 'Supprimer', '', 2, 1, '#@!@')

-- IMPORTER LES EMPLOYÉS AVEC LEURS USER
 INSERT INTO tbl_Employe (idEmploye, prenom, nom, email, idTypeEmpl, inactif, username)
	SELECT emp.id, emp.prenom, emp.nom, emp.email, 2 as idTypeEmpl, 
	(CASE WHEN us.sttus = 0 THEN 1 else 0 END) as Inactif , us.usr AS username
	FROM coeco.dbo.tblemploye AS emp
	JOIN coeco.dbo.tbluser AS us ON us.idperso = emp.id
	WHERE 1=1
	AND us.tpe = 'emp'
	ORDER BY emp.id

Set Identity_Insert tbl_Employe OFF
GO



Set Identity_Insert tbl_Projet ON
GO

-- Admin ID = 8
 INSERT INTO tbl_Projet (idProjet, titre, description, approbation, idStatus, idEmployeResp, tempsAllouer, dateDebut, dateFin, archiver)
VALUES (13, 'Projet supprimé', '', 0, 2, 8, 0, '1900-01-01','1900-01-01', 1)


-- IMPORTER LES PROJETS
 INSERT INTO tbl_Projet (idProjet, titre, description, approbation, idStatus, idEmployeResp, tempsAllouer, dateDebut, dateFin, archiver)
	SELECT proj.id, proj.titre, proj.description, 0 AS approbation,(CASE WHEN proj.status = 1 THEN 1 else 2 END) AS idStatus, 
	8 AS AdminID, proj.temps, 
	(CASE WHEN proj.datedebut IS NULL THEN proj.dateInsc else proj.datedebut END) AS dateDebut, 
	proj.datefin, (CASE WHEN proj.status = 0 THEN 1 else 0 END) as archiver 
	FROM coeco.dbo.tblprojet AS proj

Set Identity_Insert tbl_Projet OFF
GO



Set Identity_Insert tbl_ProjetCat ON
GO

-- IMPORTER LES CATÉGORIES DE PROJETS
 INSERT INTO tbl_ProjetCat (idProjetCat, idProjet, idCatMaitre, titre, description)
	SELECT projCat.id, projCat.idprojet, (CASE WHEN projCat.idcatmaitre = 0 THEN NULL else projCat.idcatmaitre END) AS idCatMaitre,
	 projCat.titre, projCat.description 
	FROM coeco.dbo.tblprojetcat AS projCat

Set Identity_Insert tbl_ProjetCat OFF
GO

Set Identity_Insert tbl_ProjetCatEmploye ON
GO

-- IMPORTER LES CATÉGORIES DE PROJETS
 INSERT INTO tbl_ProjetCatEmploye (idPCE, idProjet, idCategorie, idEmploye)
	SELECT catPerso.id, catPerso.idprojet, catPerso.idcat, catPerso.idperso 
	FROM coeco.dbo.tblprojetcatperso AS catPerso
	WHERE catPerso.tbl = 'tblemploye'
	ORDER BY catPerso.idperso
	

Set Identity_Insert tbl_ProjetCatEmploye OFF
GO

--SORTIR LES ID DES EMPLOYÉS QUI NE SONT PAS PRÉSENT DANS LES CATÉGORIES
--SELECT * FROM coeco.dbo.tblprojetcatperso AS c
--WHERE 1=1
--AND c.tbl = 'tblemploye'
--AND idperso NOT IN (SELECT id FROM coeco.dbo.tblemploye)

Set Identity_Insert tbl_FeuilleTemps ON
GO

DELETE FROM coeco.dbo.tblheure
WHERE idCat IN (56, 58, 378)

-- IMPORTER LES CATÉGORIES DE PROJETS
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

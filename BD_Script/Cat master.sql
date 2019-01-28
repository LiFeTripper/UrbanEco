USE BD_Coeco_Test
GO

IF OBJECT_ID ( 'PS_ChangeCatMaster', 'P' ) IS NOT NULL 
    DROP PROCEDURE PS_ChangeCatMaster 
GO
CREATE PROC PS_ChangeCatMaster
	@idCat INT
AS
	--Cr�� une nouvelle cat�gorie N1
	INSERT INTO tbl_ProjetCat (idProjet, idCatMaitre, titre, description)(
		SELECT idProjet, NULL, titre, description FROM tbl_ProjetCat
		WHERE idProjetCat = @idCat
	)
	--Transfert de la cat�gorie N1 vers N2 et l'attach� � la nouvelle cat�gorie
	UPDATE tbl_ProjetCat
	SET idCatMaitre = (SELECT MAX(idProjetCat) FROM tbl_ProjetCat)
	WHERE idProjetCat = @idCat

	--Garder les cat�gories existantes
	UPDATE tbl_ProjetCat
	SET idCatMaitre = (SELECT MAX(idProjetCat) FROM tbl_ProjetCat)
	WHERE idCatMaitre = @idCat

GO


SELECT * FROM tbl_ProjetCat WHERE titre = 'FCM - TI'
SELECT * FROM tbl_ProjetCat WHERE titre = 'Regroupement des collectes'



EXEC PS_ChangeCatMaster 73
SELECT idProjetCat FROM tbl_ProjetCat WHERE idCatMaitre IS NULL




DECLARE @i INT = 0

WHILE @i < (SELECT COUNT(*) FROM tbl_ProjetCat WHERE idCatMaitre IS NULL)
BEGIN
	--Liste des chiffres qu'on veut effectu�
	SELECT idProjetCat FROM tbl_ProjetCat WHERE idCatMaitre IS NULL

	EXEC PS_ChangeCatMaster
END
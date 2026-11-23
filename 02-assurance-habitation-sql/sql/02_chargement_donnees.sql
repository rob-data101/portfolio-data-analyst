-- =====================================================================
-- Projet Assurance Habitation : chargement des fichiers CSV
-- Ordre imposé par la clé étrangère : Region d'abord, Contrat ensuite
-- =====================================================================

USE assurance;

LOAD DATA LOCAL INFILE 'data/Region.csv'
INTO TABLE Region
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/Contrat.csv'
INTO TABLE Contrat
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Contrôle : le nombre de lignes doit correspondre aux fichiers CSV
SELECT COUNT(*) FROM Region;    -- attendu : 38 916
SELECT COUNT(*) FROM Contrat;   -- attendu : 30 335

-- Note : 9 contrats référencent des codes commune absents du référentiel
-- (ex. 97434, 97460, 97470). Ils ont été importés avec FOREIGN_KEY_CHECKS = 0
-- le temps de l'import, pour conserver toutes les lignes du fichier.
-- Ils n'apparaissent pas dans les jointures Contrat / Region.

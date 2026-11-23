-- =====================================================================
-- Projet Assurance Habitation : création des tables
-- Script généré depuis SQL Power Architect, exécuté sur MySQL
-- =====================================================================

CREATE DATABASE IF NOT EXISTS assurance;
USE assurance;

-- Référentiel géographique (data.gouv.fr) : 1 ligne par commune
CREATE TABLE Region (
  Code_dep_code_commune VARCHAR(6)  NOT NULL,   -- code département + code commune (clé unique)
  Reg_code              VARCHAR(2)  NOT NULL,
  Reg_nom               VARCHAR(30) NOT NULL,
  Aca_nom               VARCHAR(31) NOT NULL,
  Dep_nom               VARCHAR(50) NOT NULL,
  Com_nom_maj_court     VARCHAR(40) NOT NULL,
  Dep_code              VARCHAR(3)  NOT NULL,   -- VARCHAR : garde le zéro de '01' et gère '2A' / '2B'
  Dep_nom_num           VARCHAR(55) NOT NULL,
  PRIMARY KEY (Code_dep_code_commune)
);

-- Contrats d'assurance habitation : 1 ligne par contrat
CREATE TABLE Contrat (
  Contrat_ID              INT         NOT NULL,
  No_voie                 INT,
  B_T_Q                   VARCHAR(1),            -- bis, ter, quater…
  Type_de_voie            VARCHAR(4),
  Voie                    VARCHAR(30) NOT NULL,
  Code_dep_code_commune   VARCHAR(6)  NOT NULL,
  Code_postal             VARCHAR(5)  NOT NULL,  -- VARCHAR : en INT, '01370' deviendrait 1370
  Surface                 INT         NOT NULL,
  Type_local              VARCHAR(15) NOT NULL,
  Occupation              VARCHAR(17) NOT NULL,
  Type_contrat            VARCHAR(21) NOT NULL,
  Formule                 VARCHAR(10) NOT NULL,
  Valeur_declaree_biens   VARCHAR(12) NOT NULL,  -- 4 tranches : 0-25000, 25000-50000…
  Prix_cotisation_mensuel INT         NOT NULL,
  PRIMARY KEY (Contrat_ID)
);

-- Relation : 1 commune (Region) peut avoir N contrats
ALTER TABLE Contrat ADD CONSTRAINT region_contrat_fk
  FOREIGN KEY (Code_dep_code_commune)
  REFERENCES Region (Code_dep_code_commune)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

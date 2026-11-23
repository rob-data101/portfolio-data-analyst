-- =====================================================================
-- Projet Assurance Habitation : les 12 requêtes d'analyse (MySQL)
-- Résultats en commentaire. Captures complètes : livrables/requetes_et_resultats.pdf
-- =====================================================================

USE assurance;

-- Q1. Numéros de contrats et surfaces pour le code postal 92100
SELECT Contrat_ID, Surface
FROM Contrat
WHERE Code_postal = '92100';

-- Q2. Nom des régions de France
SELECT DISTINCT Reg_nom
FROM Region;
-- → 19 régions

-- Q3. Nombre de contrats sur les résidences principales
SELECT COUNT(*) AS nb_residences_principales
FROM Contrat
WHERE Type_contrat = 'Residence principale';
-- → 25 620 (84 % des contrats)

-- Q4. Les 5 contrats aux surfaces les plus élevées
SELECT *
FROM Contrat
ORDER BY Surface DESC
LIMIT 5;

-- Q5. Prix moyen de la cotisation mensuelle
SELECT ROUND(AVG(Prix_cotisation_mensuel), 2) AS cotisation_moyenne
FROM Contrat;
-- → 19,33 €

-- Q6. Nombre de contrats par tranche de valeur déclarée des biens
SELECT Valeur_declaree_biens, COUNT(*) AS nb_contrats
FROM Contrat
GROUP BY Valeur_declaree_biens
ORDER BY nb_contrats DESC;
-- → 0-25000 : 22 720 · 25000-50000 : 6 815 · 50000-100000 : 696 · 100000+ : 104

-- Q7. Nombre de formules "Integral" en Pays de la Loire
SELECT COUNT(*) AS nb_formules_integral
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE r.Reg_nom = 'Pays de la Loire'
  AND c.Formule = 'Integral';
-- → 589

-- Q8. Contrats des maisons du département 71 : type de contrat et formule
SELECT c.Contrat_ID, c.Type_contrat, c.Formule
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE c.Type_local = 'Maison'
  AND r.Dep_code = '71';
-- → 4 contrats

-- Q9. Surface moyenne des contrats à Paris
SELECT ROUND(AVG(c.Surface), 1) AS surface_moyenne
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE r.Dep_nom = 'Paris';
-- → 51,8 m²

-- Q10. Top 10 des départements par cotisation moyenne
SELECT r.Dep_code, r.Dep_nom, ROUND(AVG(c.Prix_cotisation_mensuel), 2) AS cotisation_moyenne
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.Dep_code, r.Dep_nom
ORDER BY cotisation_moyenne DESC
LIMIT 10;
-- → Paris (36,40 €) en tête, devant les Hauts-de-Seine (26,27 €) et le Val-de-Marne (19,82 €)

-- Q11. Communes ayant eu au moins 150 contrats
--      Regroupement par code commune : deux communes peuvent porter le même nom
SELECT r.Code_dep_code_commune, r.Com_nom_maj_court, COUNT(*) AS nb_contrats
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.Code_dep_code_commune, r.Com_nom_maj_court
HAVING COUNT(*) >= 150
ORDER BY nb_contrats DESC;
-- → Résultat de ma requête initiale (> 150) : 20 communes, dont 12 arrondissements de Paris

-- Q12. Nombre de contrats par région
SELECT r.Reg_nom, COUNT(*) AS nb_contrats
FROM Contrat c
JOIN Region r ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.Reg_nom
ORDER BY nb_contrats DESC;
-- → Île-de-France : 14 177 contrats (47 % du total), loin devant PACA (3 279)

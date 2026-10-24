--=========================================================================================================
											--SQL QUERIES--
--=========================================================================================================

-- Query 1: Rank energy storage technologies by installation cost in 2025.
SELECT T.Name, E.InstallationCost
FROM Technologies T JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
WHERE E.Year = 2025
ORDER BY E.InstallationCost ASC;

-- Query 2: Calculate the average installation cost for each energy storage technology across all years.
SELECT  T.Name, AVG(E.InstallationCost) AS "Average Installation Cost"
FROM Technologies T JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
GROUP BY T.Name;

-- Query 3: Find energy storage technologies with an average installation cost below 200
SELECT  T.Name, AVG(E.InstallationCost) AS "Average Installation Cost"
FROM Technologies T JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
GROUP BY T.Name
HAVING AVG (E.InstallationCost) < 200;

-- Query 4: Compare installation costs between 2021 and 2025
SELECT T.Name, E.InstallationCost, E.Year
FROM Technologies T JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
WHERE E.Year = 2021 OR E.Year = 2025;

-- Query 5: Find energy storage technologies with installation costs between 100 and 300 in 2025
SELECT T.Name, E.InstallationCost, E.Year
FROM Technologies T JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
WHERE E.InstallationCost BETWEEN 100 AND 300 AND E.Year = 2025;

-- Query 6: Identify technologies with the highest power-to-capacity ratio using View
SELECT Technology, Year, [Capacity (MWh)], [Power (MW)], [Power (MW)] / NULLIF([Capacity (MWh)], 0) AS [Power-to-Capacity Ratio (h^(-1))]
FROM vw_EnergyStorageFullAnalysis
WHERE Year = 2025
ORDER BY [Power-to-Capacity Ratio (h^(-1))] DESC;

-- Query 7: Identify energy storage technologies with high capacity and low installation cost in 2025
SELECT T.Name, TD.CapacityMWh, InstallationCost, TD.PowerMW
FROM Technologies T JOIN TechnicalData TD ON T.TechnologyID = TD.TechnologyID
JOIN EconomicData E ON T.TechnologyID = E.TechnologyID
AND TD.Year = E.Year
WHERE TD.CapacityMWh > 500 AND E.InstallationCost < 300 AND E.Year = 2025
ORDER BY TD.CapacityMWh DESC;

-- Query 8: Find technologies whose installation cost decreased from 2021 to 2025
SELECT
    T.Name AS Technology,
    E1.InstallationCost AS [Installation Cost 2021],
    E2.InstallationCost AS [Installation Cost 2025],
    E1.InstallationCost - E2.InstallationCost AS [Cost Reduction]
FROM Technologies T JOIN EconomicData E1 ON T.TechnologyID = E1.TechnologyID
JOIN EconomicData E2 ON T.TechnologyID = E2.TechnologyID
WHERE E1.Year = 2021 AND E2.Year = 2025
AND E2.InstallationCost < E1.InstallationCost
ORDER BY [Cost Reduction] DESC;

-- Query 9: Find Technologies with Technical Data Available in 2025
SELECT   C.Name AS Category, T.Name AS Technology
FROM Categories C JOIN Technologies T ON C.CategoryID = T.CategoryID
WHERE EXISTS (SELECT 1 FROM  TechnicalData TD  WHERE TD.TechnologyID = T.TechnologyID AND TD.Year = 2025);

-- Query 10: Find Categories with Technologies Having a Lifetime of More Than 20 Years
SELECT DISTINCT C.Name AS Category
FROM Categories C JOIN Technologies T ON C.CategoryID = T.CategoryID
JOIN TechnicalData TD ON T.TechnologyID = TD.TechnologyID
WHERE TD.LifetimeYears > 20;
--===================================================================                                      
                        --CREATE VIEW
 --===================================================================  

 -- View 1: Combine Economic and Technical Data for Comprehensive Energy Storage Analysis
CREATE VIEW vw_EnergyStorageFullAnalysis AS
SELECT 
    c.Name AS [Category],
    t.Name AS [Technology],
    e.Year,
    
    e.InstallationCost AS [Installation Cost],
    e.AnnualOperatingMaintenanceCost AS [O&M Cost],
    e.LevelizedStorageCost AS [LCOS],
    
    td.CapacityMWh AS [Capacity (MWh)],
    td.PowerMW AS [Power (MW)],
    td.DurationHours AS [Duration (Hours)],
    td.LifetimeYears AS [Lifetime (Years)]

FROM Technologies t
JOIN Categories c
    ON t.CategoryID = c.CategoryID
JOIN EconomicData e
    ON t.TechnologyID = e.TechnologyID
JOIN TechnicalData td
    ON t.TechnologyID = td.TechnologyID
    AND e.Year = td.Year;

  
--===================================================================                                      
                        --CREATE INDEXES
--===================================================================  

-- Index 1: Optimize Economic Data Queries by Year and Installation Cost
    CREATE INDEX Economic_year_InstCost
    ON EconomicDATA (Year, InstallationCost);

    -- Index 2: Optimize Technical Data Queries by Year, Power and Lifetime
    CREATE INDEX Technical_year_power_Lifetime
    ON TechnicalData (Year, PowerMW,LifetimeYears);

--===================================================================                                      
                        --CREATE PROCEDURES
--===================================================================  

-- Stored Procedure 1: Retrieve economic data for a specific year
    CREATE PROCEDURE Economics_Per_Year
    @Year INT 
    AS
    BEGIN
    SELECT * FROM EconomicData WHERE @YEAR = YEAR 
    END
    
   

   -- Stored Procedure 2: Check whether economic data exists for a specific year
    CREATE PROCEDURE Economics_Exists_Per_Year
    @Year INT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM EconomicData
        WHERE Year = @Year
    )
    BEGIN
        SELECT *
        FROM EconomicData
        WHERE Year = @Year;
    END
    ELSE
    BEGIN
        PRINT 'No data found for this year';
    END
END




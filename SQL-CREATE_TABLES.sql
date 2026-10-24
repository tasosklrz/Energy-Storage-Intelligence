-- =========================================================================
-- ENERGY STORAGE INTELLIGENCE PROJECT
-- Database Schema Creation & Indexing
-- =========================================================================

-- 1. Categories Table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 2. Technologies Table
CREATE TABLE Technologies (
    TechnologyID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID)
);

-- 3. Economic Data Table (Time-series 2021-2025)
CREATE TABLE EconomicData (
    EconomicDataID INT IDENTITY(1,1) PRIMARY KEY,
    TechnologyID INT FOREIGN KEY REFERENCES Technologies(TechnologyID),
    InstallationCost DECIMAL(10,3),
    AnnualOperatingMaintenanceCost DECIMAL(10,3),
    Year INT NOT NULL,
    LevelizedStorageCost DECIMAL(10,3)
);

-- 4. Technical Data Table (Time-series 2021-2025)
CREATE TABLE TechnicalData (
    TechnicalDataID INT IDENTITY(1,1) PRIMARY KEY,
    TechnologyID INT FOREIGN KEY REFERENCES Technologies(TechnologyID),
    Year INT NOT NULL,
    CapacityMWh DECIMAL(12,3),
    PowerMW DECIMAL(10,3),
    LifetimeYears INT,
    DurationHours DECIMAL(10,3)
);




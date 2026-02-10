/*
====================================================================================================
Create database and schema
====================================================================================================
Script Prupose:
    The script created the new database: DataWarehouse after check the database already existing.
    If the database exists, it is dropped and re-created. Additionally, the script sets up tree
    schemas within the database : 'bronza', 'silver', 'gold'
Warining :
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in this databsae will be permanantly deleted/ Preceed with caution and 
    ensure you have proper backups before running this script.  
*/

-- Start with master database 
USE master;
GO

-- Drop and Re-create the 'DataWarehouse' databse
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create DataWarehouse database
CREATE DATABASE DataWarehouse;
Go

-- Using DataWarehouse database
USE DataWarehouse;
GO

-- Create DataWarehouse schema for Medallion architecture
CREATE SCHEMA bronze;   -- Schema for bronza layer
GO

CREATE SCHEMA silver;   -- Schema for silver layer
GO

CREATE SCHEMA gold; -- Schema for gold layer
GO









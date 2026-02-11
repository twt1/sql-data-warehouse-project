/*
====================================================================================================
Create and Bulk Insert Table of ERP system
====================================================================================================
Script Prupose:
    The script will create and bulk insert the table of ERP system for bronze layer.
    If the table exists, it is dropped and re-created and bulk insert the table as followed.
        - bronze.erp_cust_az21
        - bronze.erp_loc_a101
        - bronze.erp_px_cat_giv2

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

-- Use DataWarehouse database
USE DataWarehouse
GO

-- Drop and re-created bronze.erp_cust_az21 table
IF OBJECT_ID('bronze.erp_cust_az21', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az21;
-- Create table bronze.erp_cust_az21 for bronze layer
CREATE TABLE bronze.erp_cust_az21(
    CID VARCHAR(20),
    BDATE DATE,
    GEN VARCHAR(20)
)
-- Bulk insert data to bronze.erp_cust_az21 table from .csv file in local for bronze layer 
BULK INSERT bronze.erp_cust_az21
FROM '/var/opt/mssql/import/source_erp/CUST_AZ12.csv'
WITH(
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',',
    TABLOCK
);


-- Drop and re-created bronze.erp_loc_a101 table
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
-- Create table bronze.loc_a101 for bronze layer
CREATE TABLE bronze.erp_loc_a101(
    CID VARCHAR(20),
    CNTRY VARCHAR(20)
)
-- Bulk insert data to bronze.erp_loc_a101 table from .csv file in local for bronze layer 
BULK INSERT bronze.erp_loc_a101
FROM '/var/opt/mssql/import/source_erp/LOC_A101.csv'
WITH(
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',',
    TABLOCK
);


-- Drop and re-created bronze.erp_px_cat_giv2 table
IF OBJECT_ID('bronze.erp_px_cat_giv2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_giv2;
-- Create table bronze.erp_px_cat_giv2 for bronze layer
CREATE TABLE bronze.erp_px_cat_giv2(
    ID VARCHAR(20),
    CAT VARCHAR(50),
    SUBCAT VARCHAR(20),
    MAINTENANCE VARCHAR(20)
)
-- Bulk insert data to bronze.erp_px_cat_giv2 table from .csv file in local for bronze layer 
BULK INSERT bronze.erp_px_cat_giv2
FROM '/var/opt/mssql/import/source_erp/PX_CAT_G1V2.csv'
WITH(
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',',
    TABLOCK
);




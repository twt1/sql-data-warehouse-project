/*
====================================================================================================
Create Table of ERP system
====================================================================================================
Script Prupose:
    The script will create the table of ERP system for silver layer.
    If the table exists, it is dropped and re-created the table as followed.
        - silver.erp_cust_az21
        - silver.erp_loc_a101
        - silver.erp_px_cat_giv2

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

-- Use DataWarehouse database
USE DataWarehouse
GO

-- Drop and re-created silver.erp_cust_az21 table
IF OBJECT_ID('silver.erp_cust_az21', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az21;
-- Create table silver.erp_cust_az21 for silver layer
CREATE TABLE silver.erp_cust_az21(
    CID VARCHAR(20),
    BDATE DATE,
    GEN VARCHAR(20)
)

-- Drop and re-created silver.erp_loc_a101 table
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
-- Create table silver.loc_a101 for silver layer
CREATE TABLE silver.erp_loc_a101(
    CID VARCHAR(20),
    CNTRY VARCHAR(20)
)

-- Drop and re-created silver.erp_px_cat_giv2 table
IF OBJECT_ID('silver.erp_px_cat_giv2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_giv2;
-- Create table silver.erp_px_cat_giv2 for silver layer
CREATE TABLE silver.erp_px_cat_giv2(
    ID VARCHAR(20),
    CAT VARCHAR(50),
    SUBCAT VARCHAR(20),
    MAINTENANCE VARCHAR(20)
)



/*
====================================================================================================
Create Table of CRM system
====================================================================================================
Script Prupose:
    The script will create the table of CRM system for silver layer.
    If the table exists, it is dropped and re-created the table as followed.
        - silver.crm_cust_info
        - silver.crm_prd_info
        - silver.crm_sales_details

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

-- Using DataWarehouse database
USE DataWarehouse;
GO

-- Drop table 'silver.crm_cust_info' if already existed
IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
-- Create cust_info for silver layer
CREATE TABLE silver.crm_cust_info(
    cst_id INT,
    cst_key VARCHAR(20),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(10),
    cst_gndr VARCHAR(10),
    cst_create_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop table 'silver.crm_prd_info' if already existed
IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
-- Create prd_info for silver layer
CREATE TABLE silver.crm_prd_info(
    prd_id INT,
    cat_id VARCHAR(10),
    prd_key VARCHAR(30),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(20),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop table 'silver.crm_sales_details' if already existed
IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
-- Create sales_details for bronza layer
CREATE TABLE silver.crm_sales_details(
    sls_ord_num VARCHAR(20),
    sls_prd_key VARCHAR(20),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

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
    cid VARCHAR(20),
    bdate DATE,
    gen VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
)

-- Drop and re-created silver.erp_loc_a101 table
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
-- Create table silver.loc_a101 for silver layer
CREATE TABLE silver.erp_loc_a101(
    cid VARCHAR(20),
    cntry VARCHAR(20),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
)

-- Drop and re-created silver.erp_px_cat_giv2 table
IF OBJECT_ID('silver.erp_px_cat_giv2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_giv2;
-- Create table silver.erp_px_cat_giv2 for silver layer
CREATE TABLE silver.erp_px_cat_giv2(
    id VARCHAR(20),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
)




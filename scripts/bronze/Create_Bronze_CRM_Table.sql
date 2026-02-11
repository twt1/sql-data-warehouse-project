/*
====================================================================================================
Create Table of CRM system
====================================================================================================
Script Prupose:
    The script will create the table of CRM system for bronze layer.
    If the table exists, it is dropped and re-created the table as followed.
        - bronze.crm_cust_info
        - bronze.crm_prd_info
        - bronze.crm_sales_details

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

-- Using DataWarehouse database
USE DataWarehouse;
GO

-- Drop table 'bronze.crm_cust_info' if already existed
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
-- Create cust_info for bronze layer
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key VARCHAR(20),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(10),
    cst_gndr VARCHAR(10),
    cst_create_date DATE
);

-- Drop table 'bronze.crm_prd_info' if already existed
IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
-- Create prd_info for bronze layer
CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key VARCHAR(30),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(20),
    prd_start_dt DATE,
    prd_end_dt DATE
);


-- Drop table 'bronze.crm_sales_details' if already existed
IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
-- Create sales_details for bronza layer
CREATE TABLE bronze.crm_sales_details(
    sls_ord_num VARCHAR(20),
    sls_prd_key VARCHAR(20),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

/*
====================================================================================================
Create Table of ERP system
====================================================================================================
Script Prupose:
    The script will create the table of ERP system for bronze layer.
    If the table exists, it is dropped and re-created the table as followed.
        - bronze.erp_cust_az21
        - bronze.erp_loc_a101
        - bronze.erp_px_cat_giv2

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

-- Drop and re-created bronze.erp_cust_az21 table
IF OBJECT_ID('bronze.erp_cust_az21', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az21;
-- Create table bronze.erp_cust_az21 for bronze layer
CREATE TABLE bronze.erp_cust_az21(
    CID VARCHAR(20),
    BDATE DATE,
    GEN VARCHAR(20)
)

-- Drop and re-created bronze.erp_loc_a101 table
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
-- Create table bronze.loc_a101 for bronze layer
CREATE TABLE bronze.erp_loc_a101(
    CID VARCHAR(20),
    CNTRY VARCHAR(20)
)

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






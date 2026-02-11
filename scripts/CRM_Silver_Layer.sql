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
    cst_create_date DATE
);

-- Drop table 'silver.crm_prd_info' if already existed
IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
-- Create prd_info for silver layer
CREATE TABLE silver.crm_prd_info(
    prd_id INT,
    prd_key VARCHAR(30),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(20),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- Drop table 'silver.crm_sales_details' if already existed
IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
-- Create sales_details for bronza layer
CREATE TABLE silver.crm_sales_details(
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

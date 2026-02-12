/*
=================================================================================================
Quility Checks of silver.crm_sales_details Table
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Null of order and product
    - Negative of integer value
    - Invalid date range and order

Usage Note :
    - Run the checks script after loading the silver data from procedure : silver.load_silver 
=================================================================================================
*/
-- ============================================================================
-- Refference table result 
-- Expectation : Top 10 record
-- ============================================================================
select top(10) * from silver.crm_sales_details

-- ============================================================================
-- Check null values from order number
-- Expectation : No result
-- ============================================================================
select 
    sls_ord_num
from silver.crm_sales_details
where sls_ord_num is null;

-- ============================================================================
-- Check null of prd_key
-- Expectation : No result
-- ============================================================================
select 
    sls_prd_key
from silver.crm_sales_details
where sls_prd_key is null;

-- ============================================================================
-- Check consistency of related filed
-- Expectation : No result
-- ============================================================================
select 
    sls_prd_key
from silver.crm_sales_details
where sls_prd_key not in (select prd_key from silver.crm_prd_info)

-- ============================================================================
-- Check null nagative value(<0) of cust_id
-- Expectation : No result
-- ============================================================================
select 
    sls_cust_id
from silver.crm_sales_details
where sls_cust_id is null 
or sls_cust_id <= 0

-- ============================================================================
-- Check consistency of related filed
-- Expectation : No result
-- ============================================================================
select 
    sls_cust_id
from silver.crm_sales_details
where sls_cust_id not in (select cst_id from silver.crm_cust_info)

-- ============================================================================
-- Check invalid date range and order
-- Expectation : No result
-- ============================================================================
-- >> sls_order_dt
select 
    sls_order_dt
from silver.crm_sales_details
where cast(sls_order_dt as varchar) <= '0'
or len(replace(cast(sls_order_dt as varchar), '-', '')) != 8
or replace(cast(sls_order_dt as varchar), '-', '') < '19990101'
or sls_order_dt  > getdate()
-- >> sls_ship_dt
select 
    sls_ship_dt
from silver.crm_sales_details
where cast(sls_ship_dt as varchar) <= '0'
or len(replace(cast(sls_ship_dt as varchar), '-', '')) != 8
or replace(cast(sls_ship_dt as varchar), '-', '') < '19990101'
or sls_ship_dt  > getdate()
-- >> sls_due_dt
select 
    sls_due_dt
from silver.crm_sales_details
where cast(sls_due_dt as varchar) <= '0'
or len(replace(cast(sls_due_dt as varchar), '-', '')) != 8
or replace(cast(sls_due_dt as varchar), '-', '') < '19990101'
or sls_due_dt  > getdate()

-- ============================================================================
-- Check invalid date range and order
-- Expectation : No result
-- ============================================================================
-- >> sls_order_dt > sls_ship_dt
select 
    sls_order_dt,
    sls_ship_dt
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt
-- >>sls_ship_dt > sls_due_dt
select 
    sls_ship_dt,
    sls_due_dt
from silver.crm_sales_details
where sls_ship_dt > sls_due_dt

-- ============================================================================
-- Check null values of integer and nagative value(<0)
-- Expectation : No result
-- ============================================================================
select 
    sls_sales,
    sls_quantity,
    sls_price
from silver.crm_sales_details
where sls_sales is null or sls_sales < 0
or sls_quantity is null or sls_quantity < 0
or sls_price is null or sls_price < 0





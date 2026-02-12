/*
=================================================================================================
Quility Checks of silver.crm_cust_info Table
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Null or Duplicated primary keys.  
    - Unwanted spaces of stting fields.
    - Data standardization and consistency

Usage Note :
    - Run the checks script after loading the silver data from procedure : silver.load_silver 
=================================================================================================
*/

-- ============================================================================
-- Refference table result 
-- Expectation : Top 10 record
-- ============================================================================
select top(10) * from silver.crm_cust_info

-- ============================================================================
-- Check for Null and Duplicated in primary key
-- Expectation : No results
-- ============================================================================
select 
    cst_id,
    count(*)
from silver.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null

-- ============================================================================
-- Check unwanted spaces from cst_firstname, cst_lastname
-- Expectation : No result
-- ============================================================================
-- >> First name column
select
    cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)
-- >> Last name column
select
    cst_lastname
from silver.crm_cust_info
where cst_lastname != TRIM(cst_lastname)

-- ============================================================================
-- Data Standardization & consistency for marital_status
-- Expectation : Display result only Single, Married
-- ============================================================================
select distinct 
    cst_marital_status
from silver.crm_cust_info

-- ============================================================================
-- Data Standardization & consistency for gender
-- Expectation : Display result only Male, Female and n/a
-- ============================================================================
select distinct 
    cst_gndr
from silver.crm_cust_info

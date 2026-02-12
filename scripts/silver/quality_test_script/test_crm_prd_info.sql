/*
=================================================================================================
Quility Checks of silver.crm_prd_info Table
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Null or Duplicated primary keys.  
    - Unwanted spaces of stting fields.
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
select top(10) * from silver.crm_prd_info;

-- ============================================================================
-- Check null and duplicate primary key
-- Expectation : No result
-- ============================================================================
select 
    prd_id,
    count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 and prd_id is null;

-- ============================================================================
-- Check unwanted space of prd_key, prd_name
-- Expectation : No result
-- ============================================================================
-- >> prd_key
select 
    prd_key
from silver.crm_prd_info
where prd_key != TRIM(prd_key) or prd_key is null
-- >> prd_name
select 
    prd_nm
from silver.crm_prd_info
where prd_nm != TRIM(prd_nm) or prd_nm is null

-- ============================================================================
-- Check null and negative valus(<0) of prd_cost
-- Expectation : No result
-- ============================================================================
select
    prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

-- ============================================================================
-- Standardized & Consistancy the data of prd_line
-- Expectation : Display result Mountain, Road, Other Sales, Touring, n/a
-- ============================================================================
select distinct 
    prd_line
from silver.crm_prd_info

-- ============================================================================
-- Check invalid date order
-- Expextation : start date higher then end date
-- ============================================================================
select 
    prd_key,
    prd_start_dt,
    prd_end_dt
from silver.crm_prd_info
where prd_start_dt > prd_end_dt





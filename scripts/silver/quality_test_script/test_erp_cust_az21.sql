/*
=================================================================================================
Quility Checks of silver.erp_cust_az21 Table
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Null and duplicated of primary key
    - Invalid date range and order
    - Data standardization and consistency
    - Consistency of related filed

Usage Note :
    - Run the checks script after loading the silver data from procedure : silver.load_silver 
=================================================================================================
*/
-- ============================================================================
-- Refference table result 
-- Expectation : Top 10 record
-- ============================================================================
select top(10) * from silver.erp_cust_az21;

-- ============================================================================
-- Check null and duplicated of primary key
-- Expectation : No result
-- ============================================================================
select 
    cid,
    count(*)
from silver.erp_cust_az21
group by cid
having count(*) > 1 or cid is null

-- ============================================================================
-- Check difference value with crm_cust_info table
-- Expectation : No result
-- ============================================================================
select 
    case    
        when cid like 'NAS%' then SUBSTRING(TRIM(cid), 4, LEN(cid))
        else cid
    end cid
from silver.erp_cust_az21
where case    
        when cid like 'NAS%' then SUBSTRING(TRIM(cid), 4, LEN(cid))
        else cid 
      end  
    not in (select cst_key from silver.crm_cust_info)

-- ============================================================================
-- Check invalid date range and order
-- Expectation : No result
-- ============================================================================
select 
    bdate
from silver.erp_cust_az21
where bdate > GETDATE()

-- ============================================================================
-- Data Standardization & consistency for marital_status
-- Expectation : Display result only Female, Male and n/a
-- ============================================================================
select distinct 
    gen
from silver.erp_cust_az21

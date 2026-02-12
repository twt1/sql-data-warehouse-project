/*
=================================================================================================
Quility Checks of silver.erp_loc_a101 Table
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Null and duplicated of primary key
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
select top(10) * from silver.erp_loc_a101 

-- ============================================================================
-- Check null and duplicated of primary key
-- Expectation : No result
-- ============================================================================
select 
    cid,
    count(*)
from silver.erp_loc_a101
group by cid 
having count(*) > 1 or cid is null 

-- ============================================================================
-- Standardization and consistency related table 
-- Expectation : No result
-- ============================================================================
select 
    replace(cid, '-','') 
from silver.erp_loc_a101
where replace(cid, '-','') not in (select cst_key from silver.crm_cust_info)

-- ============================================================================
-- Standardization country 
-- Expectation : United States, United Kingdom, Germany, Canada, France, Australia n/a
-- ============================================================================
select distinct 
    cntry 
from silver.erp_loc_a101

-- ============================================================================
-- Check format and stardard of the country
-- Expectation : No result (Last Unicode digit should not in char(13))
-- ============================================================================
select 
  cntry,
  LEN(cntry) AS len_,
  LEN(REPLACE(UPPER(TRIM(cntry)), CHAR(13), '')),
  DATALENGTH(cntry) AS bytes_,
  UNICODE(RIGHT(cntry, 1)) AS last_char_code ,
  DATALENGTH(REPLACE(UPPER(TRIM(cntry)), CHAR(13), '')) -- Check last charecter unicode
from silver.erp_loc_a101
where LEN(cntry)  != LEN(REPLACE(UPPER(TRIM(cntry)), CHAR(13), ''))
or  DATALENGTH(cntry) != DATALENGTH(REPLACE(UPPER(TRIM(cntry)), CHAR(13), ''))

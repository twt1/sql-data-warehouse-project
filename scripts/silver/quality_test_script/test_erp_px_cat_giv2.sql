/*
=================================================================================================
Quility Checks of silver.erp_px_cat_giv2 Table
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
select top(10) * from silver.erp_px_cat_giv2;

-- ============================================================================
-- Check null and duplidated of primary key
-- Expectation : no result
-- ============================================================================
select 
    id,
    count(*)
from silver.erp_px_cat_giv2
group by id
having count(*) > 1 or id is null;

-- ============================================================================
-- Check null of catgory
-- Expectation : No result
-- ============================================================================
select 
    cat 
from silver.erp_px_cat_giv2
where cat is null;

-- ============================================================================
-- Standardized cat 
-- Expectatin : Display Accessories, Bikes, Clothing, Components
-- ============================================================================
select distinct  
    cat 
from silver.erp_px_cat_giv2;

-- ============================================================================
-- Check null subcat
-- Expectation : No result
-- ============================================================================
select 
    subcat 
from silver.erp_px_cat_giv2
where subcat is null;

-- ============================================================================
-- Standardized and consistency for catagory 
-- Expectation : Bib-Shorts, Bike Racks, Bike Stands, Bottles and Cages, Bottom Brackets
--               Brakes, Caps, Chains, Cleaners, Cranksets, Derailleurs, Fenders, Forks
--               Gloves, Handlebars, Headsets, Helmets, Hydration Packs, Jerseys, Lights
--               Locks, Mountain Bikes, Mountain Frames,Panniers, Pedals, Pumps, Road Bikes
--               Road Frames, Saddles, Shorts, Socks, Tights, Tires and Tubes, Touring Bikes
--               Touring Frames, Vests, Wheels
-- ============================================================================
select distinct  
    subcat 
from silver.erp_px_cat_giv2;

-- ============================================================================
-- Check Null subcat
-- Expectation : no result
-- ============================================================================
select 
    maintenance 
from silver.erp_px_cat_giv2
where maintenance is null;

-- ============================================================================
-- Standardization data
-- Expectation : Display Yes and No
-- ============================================================================
select distinct
    maintenance 
from silver.erp_px_cat_giv2;


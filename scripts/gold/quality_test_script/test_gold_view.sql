/*
=================================================================================================
Quility Checks of gold.fact_sales View
=================================================================================================
Script Purpose : 
    This script performs various quality checks for the data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for following. 
    - Data integration of related view
    - Null of primary key in related view 
=================================================================================================
*/
-- ==========================================================
-- Check integration of sales and customer view
-- Expectation : Found result
-- ==========================================================
select 
    *
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key

-- ==========================================================
-- Check integration of sales and product view
-- Expectation :  Found result
-- ==========================================================
select 
    *
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key

-- ==========================================================
-- Check null of integration of related data
-- Expectation :  No result
-- ==========================================================
select 
    *
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
left join gold.dim_products p
on p.product_key = f.product_key
where c.customer_key is null
or p.product_key is null

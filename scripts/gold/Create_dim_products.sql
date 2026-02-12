/*
====================================================================================================
Create View of Gold Layer
====================================================================================================
Script Prupose:
    The script will create the view gold layer.
    If the view exists, it is dropped and re-created the view as followed.
        - gold.dim_customers
        - gold.dim_products
        - gold.fact_sales

Warining :
    Running this script will drop the entire table above if it exists.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/
CREATE OR ALTER VIEW  gold.dim_products AS (
    SELECT 
        ROW_NUMBER() OVER(ORDER BY pi.prd_key, pi.prd_start_dt) product_key,
        pi.prd_id AS procuct_id,
        pg.maintenance,
        pi.cat_id AS category_id,
        pi.prd_key AS product_number,
        pi.prd_nm AS product_name,
        pi.prd_line AS product_line,
        pg.cat AS category,
        pg.subcat AS sub_category,
        pi.prd_cost AS product_cost,
        pi.prd_start_dt AS start_date
    FROM silver.crm_prd_info pi
    LEFT JOIN silver.erp_px_cat_giv2 pg
    ON pi.cat_id = pg.id
WHERE pi.prd_end_dt IS NULL -- filter out all historical date
)

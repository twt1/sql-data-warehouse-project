/*
====================================================================================================
Create fact_sales View of Gold Layer
====================================================================================================
Script Prupose:
    The script will create the view of gold layer. 
    If the view exists, it is alter information in the view as followed.
        - gold.dim_products

Warining :
    Running this script will alter the information of the entire view above if it exists.
    All data in this view will be updated. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

CREATE OR ALTER VIEW  gold.dim_products AS (
    SELECT 
        ROW_NUMBER() OVER(ORDER BY pi.prd_key, pi.prd_start_dt) product_key,
        pi.prd_id AS procuct_id,
        pg.maintenance,
        pi.prd_key AS product_number,
        pi.prd_nm AS product_name,
        pi.prd_line AS product_line,
        pi.cat_id AS category_id,
        pg.cat AS category,
        pg.subcat AS sub_category,
        pi.prd_cost AS product_cost,
        pi.prd_start_dt AS start_date
    FROM silver.crm_prd_info pi
    LEFT JOIN silver.erp_px_cat_giv2 pg
    ON pi.cat_id = pg.id
WHERE pi.prd_end_dt IS NULL -- filter out all historical date
)


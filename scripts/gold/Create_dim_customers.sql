/*
====================================================================================================
Create dim_customers View of Gold Layer
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
  
CREATE OR ALTER VIEW gold.dim_customers AS(
    SELECT
        ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
        ci.cst_id AS customer_id,
        ci.cst_key AS customer_number,
        ci.cst_firstname AS first_name,
        ci.cst_lastname AS last_name,
        CASE
            WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is master of gender info
            ELSE COALESCE(ca.gen, 'n/a')
        END AS gender,
        ci.cst_marital_status AS marital_status,
        la.cntry AS country,
        ca.bdate AS birthdate,
        ci.cst_create_date AS create_date
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az21 ca
    ON ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid
)



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



CREATE OR ALTER VIEW  gold.fact_sales AS(
    SELECT
        sd.sls_ord_num AS order_number,
        dp.product_key,
        dc.customer_key,
        sd.sls_order_dt AS order_date,
        sd.sls_ship_dt AS ship_date,
        sd.sls_due_dt AS delivery_date,
        sd.sls_sales AS sales,
        sd.sls_price AS price
    FROM silver.crm_sales_details sd
    LEFT JOIN gold.dim_products dp
    ON sd.sls_prd_key = dp.product_number
    LEFT JOIN gold.dim_customers dc
    ON sd.sls_cust_id = dc.customer_id
)

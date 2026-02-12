/*
====================================================================================================
Create fact_sales View of Gold Layer
====================================================================================================
Script Prupose:
    The script will create the view of gold layer. 
    If the view exists, it is alter information in the view as followed.
        - gold.fact_sales

Warining :
    Running this script will alter the information of the entire view above if it exists.
    All data in this view will be updated. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

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

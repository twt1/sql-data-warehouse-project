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

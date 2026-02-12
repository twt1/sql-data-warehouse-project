/*
===========================================================================================================================
Procedure for Insert Data to Silver from Bronze Layer Table
===========================================================================================================================
Script Prupose:
    The script will delete(truncate) and insert the data of CRM and ERP to Silver from Bronze Layer 
    after clean up all data as following table.
        - bronze.crm_cust_info          -->     silver.crm_cust_info
        - bronze.crm_prd_info           -->     silver.crm_prd_info
        - bronze.crm_sales_details      -->     silver.crm_sales_details  
        - bronze.erp_cust_az21          -->     silver.erp_cust_az21
        - bronze.erp_loc_a101           -->     silver.erp_loc_a101
        - bronze.erp_px_cat_giv2        -->     silver.erp_px_cat_giv2

Warining :
    Running this script will delete the data in above table.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN -- silver.load_silver 
    /*
    ========================================================
    Declaration parameter
    ========================================================
    */
    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @load_start_time DATETIME,
        @load_end_time DATETIME
     /*
    ========================================================
    Load process
    ========================================================
    */
    BEGIN TRY -- load_silver
        PRINT '======================================================'
        PRINT 'Start Load Silver Layer Process'
        PRINT '======================================================'
        PRINT '>>'
        PRINT '>>>'
        PRINT '>>>>'
        SET @load_start_time = GETDATE()

        PRINT '======================================================'
        PRINT 'Start Loading crm_cust_info Table'
        PRINT '======================================================'
        -- Set start time crm_cust_info
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table crm_cust_info
        TRUNCATE TABLE silver.crm_cust_info;
        -- Insert table crm_cust_info
        INSERT INTO silver.crm_cust_info(
            cst_id,
            cst_key,
            cst_firstname,
            cst_lastname,
            cst_marital_status,
            cst_gndr,
            cst_create_date
        )
        SELECT
            cst_id,
            cst_key,
            TRIM(cst_firstname),
            TRIM(cst_lastname),
            CASE UPPER(TRIM(cst_marital_status))
                WHEN 'S' THEN 'Single'
                WHEN 'M' THEN 'Married'
                ELSE 'n/a'
            END cst_marital_status,
            CASE UPPER(TRIM(cst_gndr))
                WHEN 'F' THEN 'Female'
                WHEN 'M' THEN 'Male'
                ELSE 'n/a'
            END cst_gndr,
            cst_create_date
        FROM (
            SELECT
                *,
                ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_lasted
            FROM bronze.crm_cust_info
        )r
        WHERE flag_lasted = 1
        AND cst_id IS NOT NULL;
        -- Set end time of crm_cust_info
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'

        PRINT '>>'
        PRINT '>>'
        PRINT '======================================================'
        PRINT 'Start Loading crm_prd_info Table'
        PRINT '======================================================'
        -- Set start time crm_prd_info
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table crm_prd_info
        TRUNCATE TABLE silver.crm_prd_info;
        -- Insert table crm_prd_info
        INSERT INTO silver.crm_prd_info(
            prd_id,
            cat_id,
            prd_key,
            prd_nm,
            prd_cost,
            prd_line,
            prd_start_dt,
            prd_end_dt
        )
        SELECT
            prd_id,
            REPLACE(SUBSTRING(TRIM(prd_key),1, 5), '-','_') as cat_id,
            SUBSTRING(TRIM(prd_key),7, LEN(prd_key)) prd_key,
            TRIM(prd_nm) AS prd_nm,
            ISNULL(prd_cost, 0) AS prd_cost,
            CASE UPPER(TRIM(prd_line))
                WHEN 'M' THEN 'Mountain'
                WHEN 'R' THEN 'Road'
                WHEN 'S' THEN 'Other Sales'
                WHEN 'T' THEN 'Touring'
                ELSE 'n/a'
            END prd_line,
            prd_start_dt,
            DATEADD(DAY, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
        FROM bronze.crm_prd_info;
        -- set end time of crm_prd_info
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'

        PRINT '>>'
        PRINT '>>'
        PRINT '======================================================'
        PRINT 'Start Loading crm_sales_details Table'
        PRINT '======================================================'
        -- Set start time crm_sales_details
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table rm_sales_details
        TRUNCATE TABLE silver.crm_sales_details;
        -- Insert data 
        INSERT INTO silver.crm_sales_details(
            sls_ord_num,
            sls_prd_key,
            sls_cust_id,
            sls_order_dt,
            sls_ship_dt,
            sls_due_dt,
            sls_sales,
            sls_quantity,
            sls_price
        )
        SELECT
            sls_ord_num,
            sls_prd_key,
            sls_cust_id,
            CASE    
                WHEN sls_order_dt <= 0 
                    OR LEN(sls_order_dt) != 8 
                    OR sls_order_dt < 19990101  -- Min boundary of time 
                    OR sls_order_dt > 20300101  -- Max boundary of time 
                THEN NULL
                ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
            END sls_order_dt,
            CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) AS sls_ship_dt,
            CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) AS sls_due_dt,
            CASE 
                WHEN sls_sales IS NULL 
                    OR sls_sales <= 0 
                    OR sls_sales != sls_quantity * ABS(sls_price)
                    THEN sls_quantity * ABS(sls_price)
                ELSE sls_sales
            END sls_sales,
            sls_quantity,
            CASE    
                WHEN sls_price IS NULL OR sls_price <= 0 
                THEN sls_sales / NULLIF(sls_quantity, 0)
                ELSE sls_price
            END sls_price
        FROM bronze.crm_sales_details;
        -- Set end time of crm_sales_details
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'


        PRINT '>>'
        PRINT '>>'
        PRINT '======================================================'
        PRINT 'Start Loading erp_cust_az21 Table'
        PRINT '======================================================'
        -- Set start time erp_cust_az21
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table erp_cust_az21
        TRUNCATE TABLE silver.erp_cust_az21;
        -- Insert table erp_cust_az21
        INSERT INTO silver.erp_cust_az21(
            cid,
            bdate,
            gen
        )
        SELECT
            CASE    
                WHEN cid LIKE 'NAS%' THEN SUBSTRING(TRIM(cid), 4, LEN(cid))
                ELSE cid
            END cid,
            CASE    
                WHEN bdate > GETDATE() THEN NULL
                ELSE bdate
            END bdate,
            CASE 
                WHEN UPPER(TRIM(REPLACE(gen, CHAR(13), ''))) IN ('F','FEMALE') THEN 'Female'
                WHEN UPPER(TRIM(REPLACE(gen, CHAR(13), ''))) IN ('M','MALE') THEN 'Male'
                WHEN TRIM(REPLACE(gen, CHAR(13), '')) = gen THEN gen
                ELSE 'n/a'
            END as gen
        FROM bronze.erp_cust_az21;
        -- Set end time of erp_cust_az21
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'


        PRINT '>>'
        PRINT '>>'
        PRINT '======================================================'
        PRINT 'Start Loading erp_loc_a101 Table'
        PRINT '======================================================'
        -- Set start time erp_loc_a101
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table erp_loc_a101
        TRUNCATE TABLE silver.erp_loc_a101;
        -- Insert table erp_loc_a101
        INSERT INTO silver.erp_loc_a101 (
            cid,
            cntry
        )
        SELECT 
            REPLACE(cid, '-','') cid, 
            CASE
                WHEN UPPER(TRIM(REPLACE(cntry, CHAR(13),''))) in ('USA', 'US') THEN 'United States'
                WHEN UPPER(TRIM(REPLACE(cntry, CHAR(13),''))) = 'DE' THEN 'Germany'
                WHEN TRIM(REPLACE(cntry, CHAR(13),'')) = 'CANADA' THEN 'Canada'
                WHEN UPPER(TRIM(REPLACE(cntry, CHAR(13),''))) = 'FRANCE' THEN 'France'
                WHEN UPPER(TRIM(REPLACE(cntry, CHAR(13),''))) = 'AUSTRALIA' THEN 'Australia'
                WHEN UPPER(TRIM(REPLACE(cntry, CHAR(13),''))) = 'UNITED KINGDOM' THEN 'United Kingdom'
                ELSE 'n/a'
            END cntry 
        FROM bronze.erp_loc_a101
        -- Set end time of erp_loc_a101
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'


        PRINT '>>'
        PRINT '>>'
        PRINT '======================================================'
        PRINT 'Start Loading erp_loc_aerp_px_cat_giv2101 Table'
        PRINT '======================================================'
        -- Set start time erp_px_cat_giv2
        SET @start_time = GETDATE();
        PRINT 'Staring time : ' + CAST(@start_time AS VARCHAR);
        -- Delete table erp_px_cat_giv2
        TRUNCATE TABLE silver.erp_px_cat_giv2;
        -- Insert table erp_px_cat_giv2
        INSERT INTO silver.erp_px_cat_giv2 (
            id,
            cat,
            subcat,
            maintenance
        )
        SELECT  
            id,
            cat,
            subcat,
            TRIM(REPLACE(maintenance, CHAR(13), '')) maintenance
        FROM bronze.erp_px_cat_giv2
        -- Set end time of erp_loc_a101
        SET @end_time = GETDATE();
        PRINT 'End time : ' + CAST(@end_time AS VARCHAR);
        PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) +' Second'
        PRINT '------------------------------------------------------'

        -- Loading time calculation 
        SET @load_end_time = GETDATE()
        PRINT 'Completed Loading All Data : '+ CAST(DATEDIFF(SECOND,@load_start_time, @load_end_time) AS NVARCHAR) + ' Second'

    END TRY
    /*
    ========================================================
    Error Handling Silver Layer Process
    ========================================================
    */
    BEGIN CATCH -- load_silver
        PRINT '======================================================'
        PRINT 'Error Occured During Loading Bronze Layer'; 
        PRINT 'Error Message ' + ERROR_MESSAGE();
        PRINT 'Error Message ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '======================================================'
    END  CATCH
END

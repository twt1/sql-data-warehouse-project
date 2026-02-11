/*
===========================================================================================================================
Procedure for Bulk Insert(Load) Data to Bronze Layer Table
===========================================================================================================================
Script Prupose:
    The script will delete(truncate) and re-bulk insert(load) the data of CRM and ERP for bronze layer as following table.
        - bronze.crm_cust_info
        - bronze.crm_prd_info
        - bronze.crm_sales_details
        - bronze.erp_cust_az21
        - bronze.erp_loc_a101
        - bronze.erp_px_cat_giv2

Warining :
    Running this script will delete the data in above table.
    All data in this table will be permanantly deleted. Preceed it with caution and 
    ensure you have proper backups before running this script.  
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -----------------------------------------
    -- Procedure Paramter
    -----------------------------------------
    DECLARE @start_time DATETIME, 
            @end_time DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time DATETIME;
    ------------------------------------------------------------------------------------------------
    -- Bronze Layer Loading Try Process
    ------------------------------------------------------------------------------------------------
    BEGIN TRY 
        SET @batch_start_time = GETDATE();
        PRINT '==================================================================';
        PRINT 'Start Loading Bronze Layer';
        PRINT '==================================================================';

        PRINT '------------------------------------------------------------------';
        PRINT 'Loading CRM Table';
        PRINT '------------------------------------------------------------------';
        PRINT '>> Delete data table : bronze.crm_cust_info';
        -- Delete(Truncate) data from bronze.crm_cust_info table
        TRUNCATE TABLE bronze.crm_cust_info;

        SET @start_time = GETDATE();
        PRINT '>> Insert data table : bronze.crm_cust_info';
        -- Bulk insert data to bronze.crm_cust_info table from .csv file in local for bronze layer 
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/import/source_crm/cust_info.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'

       
        PRINT '>>'
        SET @start_time = GETDATE();
        PRINT '>> Delete data table : bronze.crm_prd_info';
        -- Delete(Truncate) data from bronze.crm_prd_info table
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Insert data table : bronze.crm_prd_info';
        -- Bulk insert data to bronze.crm_prd_info table from .csv file in local for bronze layer 
        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/import/source_crm/prd_info.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'


        
        PRINT '>>'
        SET @start_time = GETDATE();
        PRINT '>> Delete data table : bronze.crm_sales_details';
        -- Delete(Truncate) data from bronze.crm_sales_details table
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Insert data table : bronze.crm_sales_details';
        -- Bulk insert data to bronze.crm_sales_details table from .csv file in local for bronze layer 
        BULK INSERT bronze.crm_sales_details
        FROM '/var/opt/mssql/import/source_crm/sales_details.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'


        PRINT '>>'
        PRINT '>>'
        PRINT '------------------------------------------------------------------';
        PRINT 'Loading ERP Table';
        PRINT '------------------------------------------------------------------';
        SET @start_time = GETDATE();
        PRINT '>> Delete data table : bronze.erp_cust_az21';
        -- Delete(Truncate) data from bronze.erp_cust_az21 table
        TRUNCATE TABLE bronze.erp_cust_az21;
        -- Bulk insert data to bronze.erp_cust_az21 table from .csv file in local for bronze layer 
        PRINT '>> Insert data table : bronze.erp_cust_az21';
        BULK INSERT bronze.erp_cust_az21
        FROM '/var/opt/mssql/import/source_erp/CUST_AZ12.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'


        PRINT '>>'
        SET @start_time = GETDATE();
        PRINT '>> Delete data table : bronze.erp_loc_a101';
        -- Delete(Truncate) data from bronze.erp_loc_a101 table
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Insert data table : bronze.erp_loc_a101';
        -- Bulk insert data to bronze.erp_loc_a101 table from .csv file in local for bronze layer 
        BULK INSERT bronze.erp_loc_a101
        FROM '/var/opt/mssql/import/source_erp/LOC_A101.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'


        PRINT '>>'
        SET @start_time = GETDATE();
        PRINT '>> Delete data table : bronze.erp_px_cat_giv2';
        -- Delete(Truncate) data from bronze.erp_px_cat_giv2 table
        TRUNCATE TABLE bronze.erp_px_cat_giv2;
        PRINT '>> Insert data table : bronze.erp_px_cat_giv2';
        -- Bulk insert data to bronze.erp_px_cat_giv2 table from .csv file in local for bronze layer 
        BULK INSERT bronze.erp_px_cat_giv2
        FROM '/var/opt/mssql/import/source_erp/PX_CAT_G1V2.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' Second'
        PRINT '-------------------------------'

        PRINT '>>'
        PRINT '>>'
        SET @batch_end_time = GETDATE();
        PRINT '=========================================================';   
        PRINT 'Bronze Layer Loading Completed'; 
        PRINT 'Total Bronze Layer Loading Time : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) as NVARCHAR) + ' Second'
        PRINT '=========================================================';  

    END TRY -- Try Loading Bronze Layer
    ------------------------------------------------------------------------------------------------
    -- Bronze Layer Loading Catch Process
    ------------------------------------------------------------------------------------------------
    BEGIN CATCH
        PRINT '=========================================================';   
        PRINT 'Error Occured During Loading Bronze Layer'; 
        PRINT 'Error Message ' + ERROR_MESSAGE();
        PRINT 'Error Message ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================================';   
    END CATCH -- Catch Loading Bronze Layer
END

# Data Warehouse Project
Building a model data warehouse using SQL Server, including ELT processes, data modeling.

**Into : **
This project is my practial for process of data warehousing, using 'Medallion' design to perform the ELT process.
It work with information of ERP and CRM system as following details. 
1. Sale order
2. Production infromation
3. Customer information

**Project details:**
0. Create work process instruction with Notion
   To overview with the project, the work process is created as following details
     1. Understand the requirement
     2. Select the data architecture : Medallion architecture
     3. Design the high level of data architecture
     4. Create data relation and data object relation of source 
     4. Convention the naming rule of project
     5. Process of Bronze Layer
     6. Process of Silver Layer
     7. Process of Gold Leyer
     8. Create data catelogs
     9. Update github repository

1. Understand the requirement
   - This project need relation between customer, product and sales order from ERP and CRM system to analyst.
  
2. Select the data architecture : Medallion architecture
   - The Medallion architecture is provide a clear and straightforward to understand the ELT process.
     
3. Desinge the high level of data architecture
   - To understand the overview of data flow, the high level of data architecture is created.
     Source      |      Bronze Layer     |      Silver Leyer     |      Gold Leyer
     --------    |    ---------------    |    ---------------    |   ---------------
     ERP        -->     Bronze Leyer    -->     Silver Leyer    -->     Gold Leyer
     CRM         |        Database       |        Database       |       Database
     
4. Create data relation and data object relation of source 
   - Find the relation of each table and draw primary key in entity diagram.
   - Draw the data object relation to tag the table label
   
5. Process Bronze Layer
   - Extract date from source and Load to bronze layer database 
   - Create procedure to preform bulk insert the data to bronze layer as following table
     1. bronze.crm_cust_info
     2. bronze.crm_prd_info
     3. bronze.crm_sales_details
     4. bronze.erp_cust_az21
     5. bronze.erp_loc_a101
     6. bronze.erp_px_cat_giv2
   - Create data flow diagram between source and bronze layer
   - Update source to github
        
6. Process of Silver Layer
   - Transform the messive data from bronze layer as following method
     1. Check null or duplicated data from primary key
     2. Check unwanted spaces of string
     3. Check null or negative value of int
     4. Verify the date such as date range or date comparision
     5. Standardization and consistency the data of abbreviation string such as gender or country
     6. Check non relation with related talbe
   - Load to silver layer database
   - Create procedure to insert the transform data to silver layer table
     1. silver.crm_cust_info
     2. silver.crm_prd_info
     3. silver.crm_sales_details
     4. silver.erp_cust_az21
     5. silver.erp_loc_a101
     6. silver.erp_px_cat_giv2
   - Verify the completed load data of silver layer by quality check script refference to transform data
   - Create data flow diagram between bronze layer and silver layer
   - Update source code to github
     
7. Process of Gold layer
     
     
**Summary: **




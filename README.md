Data Warehouse Project

Building a model data warehouse using SQL Server, including ELT processes and data modeling.

Intro:

This project is my practical work for the data warehousing process, using the ‘Medallion’ design to perform the ELT process.
It works with information from ERP and CRM systems as follows:
	1.	Sales order
	2.	Production information
	3.	Customer information

⸻

Project details:

0. Create work process instruction with Notion

To provide an overview of the project, the work process is created as follows:
	1.	Understand the requirement
	2.	Select the data architecture: Medallion architecture
	3.	Design the high-level data architecture
	4.	Create data relations and data object relations of the source
	5.	Define the naming convention of the project
	6.	Process of Bronze Layer
	7.	Process of Silver Layer
	8.	Process of Gold Layer
	9.	Create data catalogs
	10. Update GitHub repository

⸻

1. Understand the requirement
	•	This project requires relationships between customers, products, and sales orders from ERP and CRM systems for analysis.

⸻

2. Select the data architecture: Medallion architecture
	•	The Medallion architecture provides a clear and straightforward way to understand the ELT process.

⸻

3. Design the high-level data architecture
	•	To understand the overview of the data flow, the high-level data architecture is created.
      Source      |   Bronze Layer   |   Silver Layer   |   Gold Layer
      --------    | ---------------  | ---------------  | ---------------
      ERP         --> Bronze Layer   --> Silver Layer   --> Gold Layer
      CRM         |   Database       |    Database      |    Database
4. Create data relations and data object relations of the source
	•	Identify the relationships of each table and define primary keys in the entity diagram.
	•	Draw the data object relationships to tag table labels.

⸻

5. Process of Bronze Layer
	•	Extract data from the source and load it into the bronze layer database.
	•	Create procedures to perform bulk insert of the data into the bronze layer tables as follows:
	1.	bronze.crm_cust_info
	2.	bronze.crm_prd_info
	3.	bronze.crm_sales_details
	4.	bronze.erp_cust_az21
	5.	bronze.erp_loc_a101
	6.	bronze.erp_px_cat_giv2
	•	Draw a data flow diagram between the source and bronze layer.
	•	Update the source code to GitHub.

⸻

6. Process of Silver Layer
	•	Transform the massive data from the bronze layer using the following methods:
	1.	Check null or duplicate data in primary keys
	2.	Remove unwanted spaces in strings
	3.	Check null or negative integer values
	4.	Verify dates such as date range or date comparison
	5.	Standardize and ensure consistency of abbreviated strings such as gender or country
	6.	Check missing relationships with related tables
	•	Load data into the silver layer database.
	•	Create procedures to insert the transformed data into silver layer tables:
	1.	silver.crm_cust_info
	2.	silver.crm_prd_info
	3.	silver.crm_sales_details
	4.	silver.erp_cust_az21
	5.	silver.erp_loc_a101
	6.	silver.erp_px_cat_giv2
	•	Verify the completed load of the silver layer using quality check scripts referenced from the transformation rules.
	•	Draw a data flow diagram between the bronze and silver layers.
	•	Update source code to GitHub.

⸻

7. Process of Gold Layer
	•	Analyze the data object relationships to create views.
	•	Create scripts to generate views:
	1.	gold.dim_customers
	2.	gold.dim_products
	3.	gold.fact_sales
	•	Validate the views using integration checks.
	•	Draw a data flow diagram between the silver and gold layers.
	•	Update source code to GitHub.

⸻

8. Create data catalog
	•	Create documentation for views in the gold layer, describing the meaning of each column for business users.

⸻

9. Update GitHub repository
	•	Update and verify that everything created in the project is uploaded to GitHub, including data sources, design, code, etc.

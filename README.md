📊 Data Warehouse Project – SQL Server (Medallion Architecture)

🔎 Project Overview

This project demonstrates the end-to-end implementation of a Data Warehouse solution using SQL Server, applying the Medallion Architecture (Bronze–Silver–Gold) to perform ELT processes.

The objective is to integrate and transform data from ERP and CRM systems to support business analytics, focusing on:<br>
	•	Customer information<br>
	•	Product information<br>
	•	Sales orders

Notion plan : https://dolomite-rainbow-3b8.notion.site/SQL-Data-Warehouse-Project-302d2a5320c680c99a5ed1b232526286?source=copy_link


⸻

🏗 Architecture Design – Medallion Framework

The project follows the Medallion Architecture, which provides a clear and structured ELT workflow:<br>

Source Systems (ERP, CRM)<br>
        ↓<br>
Bronze Layer (Raw Data)<br>
        ↓<br>
Silver Layer (Cleaned & Transformed Data)<br>
        ↓<br>
Gold Layer (Analytics-Ready Data)<br>

Why Medallion?<br>
	•	Clear separation of concerns<br>
	•	Improved data quality control<br>
	•	Easier debugging and auditing<br>
	•	Scalable and maintainable structure

⸻

🥉 Bronze Layer – Raw Data Ingestion

Purpose: Store raw extracted data from source systems.

Key Activities:<br>
	•	Extract data from ERP & CRM<br>
	•	Load raw data into Bronze database<br>
	•	Create stored procedures for bulk insert<br>
	•	Maintain original structure (minimal transformation)

Tables:<br>
	•	bronze.crm_cust_info<br>
	•	bronze.crm_prd_info<br>
	•	bronze.crm_sales_details<br>
	•	bronze.erp_cust_az21<br>
	•	bronze.erp_loc_a101<br>
	•	bronze.erp_px_cat_giv2<br>

⸻

🥈 Silver Layer – Data Cleansing & Transformation

Purpose: Clean, validate, and standardize data.

Data Quality & Transformation Rules:<br>
	•	Remove duplicate primary keys<br>
	•	Handle NULL values<br>
	•	Remove unwanted spaces<br>
	•	Validate date ranges<br>
	•	Check negative or invalid numeric values<br>
	•	Standardize abbreviations (e.g., gender, country)<br>
	•	Validate relationships between related tables

Tables:<br>
	•	silver.crm_cust_info<br>
	•	silver.crm_prd_info<br>
	•	silver.crm_sales_details<br>
	•	silver.erp_cust_az21<br>
	•	silver.erp_loc_a101<br>
	•	silver.erp_px_cat_giv2<br>

Quality validation scripts were implemented to ensure transformation accuracy before promotion to Gold.

⸻

🥇 Gold Layer – Business Analytics Model

Purpose: Provide analytics-ready datasets using dimensional modeling.

Data Modeling:<br>
	•	Star Schema design<br>
	•	Fact and Dimension tables<br>

Views Created:<br>
	•	gold.dim_customers<br>
	•	gold.dim_products<br>
	•	gold.fact_sales

Validation:<br>
	•	Integration testing between fact and dimensions<br>
	•	Referential integrity checks<br>
	•	Aggregation validation

⸻

📐 Data Modeling & Documentation<br>
	•	Entity Relationship Diagram (ERD)<br>
	•	Data Flow Diagrams between layers<br>
	•	Primary key and relationship definition<br>
	•	Naming conventions defined<br>
	•	Data catalog created for business users (column descriptions & business meaning)

⸻

⚙️ Technical Stack<br>
	•	SQL Server<br>
	•	Stored Procedures<br>
	•	ELT Processing<br>
	•	Medallion Architecture<br>
	•	Dimensional Modeling (Star Schema)<br>
	•	Data Quality Validation Scripts<br>
	•	GitHub Version Control<br>
	•	Notion (Process Documentation)

⸻

📌 Key Learning Outcomes<br>
	•	Implemented layered data architecture<br>
	•	Designed and validated dimensional models<br>
	•	Applied real-world data quality controls<br>
	•	Structured a production-style data warehouse project<br>

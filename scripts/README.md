📊 Data Warehouse Project – SQL Server (Medallion Architecture)

🔎 Project Overview

This project demonstrates the end-to-end implementation of a Data Warehouse solution using SQL Server, applying the Medallion Architecture (Bronze–Silver–Gold) to perform ELT processes.

The objective is to integrate and transform data from ERP and CRM systems to support business analytics, focusing on:
	•	Customer information
	•	Product information
	•	Sales orders

⸻

🏗 Architecture Design – Medallion Framework

The project follows the Medallion Architecture, which provides a clear and structured ELT workflow:

Source Systems (ERP, CRM)
        ↓
Bronze Layer (Raw Data)
        ↓
Silver Layer (Cleaned & Transformed Data)
        ↓
Gold Layer (Analytics-Ready Data)

Why Medallion?
	•	Clear separation of concerns
	•	Improved data quality control
	•	Easier debugging and auditing
	•	Scalable and maintainable structure

⸻

🥉 Bronze Layer – Raw Data Ingestion

Purpose: Store raw extracted data from source systems.

Key Activities:
	•	Extract data from ERP & CRM
	•	Load raw data into Bronze database
	•	Create stored procedures for bulk insert
	•	Maintain original structure (minimal transformation)

Tables:
	•	bronze.crm_cust_info
	•	bronze.crm_prd_info
	•	bronze.crm_sales_details
	•	bronze.erp_cust_az21
	•	bronze.erp_loc_a101
	•	bronze.erp_px_cat_giv2

⸻

🥈 Silver Layer – Data Cleansing & Transformation

Purpose: Clean, validate, and standardize data.

Data Quality & Transformation Rules:
	•	Remove duplicate primary keys
	•	Handle NULL values
	•	Remove unwanted spaces
	•	Validate date ranges
	•	Check negative or invalid numeric values
	•	Standardize abbreviations (e.g., gender, country)
	•	Validate relationships between related tables

Tables:
	•	silver.crm_cust_info
	•	silver.crm_prd_info
	•	silver.crm_sales_details
	•	silver.erp_cust_az21
	•	silver.erp_loc_a101
	•	silver.erp_px_cat_giv2

Quality validation scripts were implemented to ensure transformation accuracy before promotion to Gold.

⸻

🥇 Gold Layer – Business Analytics Model

Purpose: Provide analytics-ready datasets using dimensional modeling.

Data Modeling:
	•	Star Schema design
	•	Fact and Dimension tables

Views Created:
	•	gold.dim_customers
	•	gold.dim_products
	•	gold.fact_sales

Validation:
	•	Integration testing between fact and dimensions
	•	Referential integrity checks
	•	Aggregation validation

⸻

📐 Data Modeling & Documentation
	•	Entity Relationship Diagram (ERD)
	•	Data Flow Diagrams between layers
	•	Primary key and relationship definition
	•	Naming conventions defined
	•	Data catalog created for business users (column descriptions & business meaning)

⸻

⚙️ Technical Stack
	•	SQL Server
	•	Stored Procedures
	•	ELT Processing
	•	Medallion Architecture
	•	Dimensional Modeling (Star Schema)
	•	Data Quality Validation Scripts
	•	GitHub Version Control
	•	Notion (Process Documentation)

⸻

📌 Key Learning Outcomes
	•	Implemented layered data architecture
	•	Designed and validated dimensional models
	•	Applied real-world data quality controls
	•	Structured a production-style data warehouse project

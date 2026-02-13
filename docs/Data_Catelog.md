📊 Data Catalog – Gold Layer

Data Dictionary

Overview

This data dictionary provides detailed metadata definitions for the analytical views in the Gold layer. These views are designed to support business reporting, dashboard development, and advanced analytics.

The following views are included:
	•	gold.dim_customers
	•	gold.dim_products
	•	gold.fact_sales

⸻

1️⃣ gold.dim_customers

Purpose:
Stores consolidated customer master data enriched with demographic and geographic attributes. This dimension supports customer-level analytics and segmentation.

Column :
---------------------------------------------------------------------------------------------------------------
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
customer_key        |   bigint      |   Surrogate key uniquely identifying each customer record.
---------------------------------------------------------------------------------------------------------------
customer_id         |   int         |   Business key representing the original customer identifier from source systems.
---------------------------------------------------------------------------------------------------------------
customer_number     |   varchar(20) |   Uniqe aphabet to identify each customer.
---------------------------------------------------------------------------------------------------------------
first_name          |   varchar(50) |   The customer first name as record in system.
---------------------------------------------------------------------------------------------------------------
last_name           |   varchar(50) |   The customer last name or family name as record.
---------------------------------------------------------------------------------------------------------------
gender              |   varchar(50) |   The infromation to identify customer gender(Female, Male). 
---------------------------------------------------------------------------------------------------------------
marital_status      |   varchar(10) |   The marital status of customer(Single, Married). 
---------------------------------------------------------------------------------------------------------------
country             |   varchar(20) |   The country of resident of customer. Ex: Germany, United States
---------------------------------------------------------------------------------------------------------------
birthdate           |   date        |   The customer date of birth.
---------------------------------------------------------------------------------------------------------------
create_date         |   date        |   The date to indentify created record. 
---------------------------------------------------------------------------------------------------------------

2️⃣ gold.dim_products

Purpose:
Stores product master data including categorical and operational attributes to support product performance analysis and sales reporting.

Column :
---------------------------------------------------------------------------------------------------------------
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
product_key         |   bigint      |   Surrogate key uniqe to iditify each product record.
---------------------------------------------------------------------------------------------------------------
procuct_id          |   int         |   Uniqe number to identify each product.
---------------------------------------------------------------------------------------------------------------
maintenance         |   varchar(50) |   Infrormation to identity maintenance type of each product(Yes,No).
---------------------------------------------------------------------------------------------------------------
product_number      |   varchar(30) |   Uniqe alphabet to identity each product.
---------------------------------------------------------------------------------------------------------------
product_name        |   varchar(50) |   The name to descripe the product.
---------------------------------------------------------------------------------------------------------------
product_line        |   varchar(20) |   Information to identity production line of product.
---------------------------------------------------------------------------------------------------------------
category_id         |   varchar(10) |   Alphabet to identify category of each product.
---------------------------------------------------------------------------------------------------------------
category            |   varchar(50) |   The name to descripe each category of product.
---------------------------------------------------------------------------------------------------------------
sub_category        |   varchar(50) |   The name to descripe each sub category of product.
---------------------------------------------------------------------------------------------------------------
product_cost        |   int         |   The cost of each product.
---------------------------------------------------------------------------------------------------------------
start_date          |   date        |   The date to indentify production starting of each product.
---------------------------------------------------------------------------------------------------------------

3️⃣ gold.fact_sales

Purpose:
Stores transactional sales data at the order line level. This fact table supports revenue analysis, trend reporting, and performance measurement.

Column :
---------------------------------------------------------------------------------------------------------------
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
order_number        |   varchar(50) |   Sales order number of each transaction.
---------------------------------------------------------------------------------------------------------------
procuct_key         |   bigint      |   Surrogate key uniqe to related with each product.
---------------------------------------------------------------------------------------------------------------
customer_key        |   bigint      |   Surrogate key uniqe to related with each customer.
---------------------------------------------------------------------------------------------------------------
order_date          |   date        |   Date to identify the order of customer.
---------------------------------------------------------------------------------------------------------------
ship_date           |   date        |   Date to identify the shipping of order.
---------------------------------------------------------------------------------------------------------------
delivery_date       |   date        |   Date to identify the order arrivved to customer.
---------------------------------------------------------------------------------------------------------------
sales               |   int         |   Total amount of each transaction(quantity*price).
---------------------------------------------------------------------------------------------------------------
quantity            |   int         |   Quantity of each product order.
---------------------------------------------------------------------------------------------------------------
price               |   int         |   Price of each product.
---------------------------------------------------------------------------------------------------------------




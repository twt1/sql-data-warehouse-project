📊 Data Catalog – Gold Layer

Data Dictionary

Overview

This data dictionary provides detailed metadata definitions for the analytical views in the Gold layer. These views are designed to support business reporting, dashboard development, and advanced analytics.

The following views are included:<br>
	•	gold.dim_customers<br>
	•	gold.dim_products<br>
	•	gold.fact_sales

⸻

1️⃣ gold.dim_customers

Purpose:
Stores consolidated customer master data enriched with demographic and geographic attributes. This dimension supports customer-level analytics and segmentation.

Column :
culume_name         |   data type   |   Descriptions
|:------------------|:-------------:|:---------------------------------------------------------------------------------
customer_key        |   bigint      |   Surrogate key uniquely identifying each customer record.
customer_id         |   int         |   Business key representing the original customer identifier from source systems.
customer_number     |   varchar(20) |   Unique alphanumeric customer code used for operational reference.
first_name          |   varchar(50) |   Customer’s first name as recorded in the source system.
last_name           |   varchar(50) |   Customer’s last name or family name as recorded in the source system.
gender              |   varchar(50) |   Standardized gender classification (e.g., Male, Female).
marital_status      |   varchar(10) |   Standardized marital status classification (e.g., Single, Married).
country             |   varchar(20) |   Country of residence for geographic analysis and segmentation.
birthdate           |   date        |   Customer’s date of birth for age-based analytics.
create_date         |   date        |   Record creation date in the source system.

<br>
2️⃣ gold.dim_products

Purpose:
Stores product master data including categorical and operational attributes to support product performance analysis and sales reporting.

Column :
culume_name         |   data type   |   Descriptions
|:------------------|:-------------:|:---------------------------------------------------------------------------------
product_key         |   bigint      |   Surrogate key uniquely identifying each product record within the data warehouse.
procuct_id          |   int         |   Business key representing the original product identifier from source systems.
maintenance         |   varchar(50) |   Indicates whether the product requires maintenance (Yes/No).
product_number      |   varchar(30) |   Unique alphanumeric product code used for operational tracking.
product_name        |   varchar(50) |   Official product name as defined in the source system.
product_line        |   varchar(20) |   Product line classification used for grouping and reporting.
category_id         |   varchar(10) |   Category identifier code representing the product grouping.
category            |   varchar(50) |   Product category name for high-level classification.
sub_category        |   varchar(50) |   Sub-category name for detailed product segmentation.
product_cost        |   int         |   Standard cost of the product used for margin and profitability analysis.
start_date          |   date        |   Product availability or production start date.

<br>
3️⃣ gold.fact_sales

Purpose:
Stores transactional sales data at the order line level. This fact table supports revenue analysis, trend reporting, and performance measurement.

Column :
culume_name         |   data type   |   Descriptions
|:------------------|:-------------:|:---------------------------------------------------------------------------------
order_number        |   varchar(50) |   Unique sales order number representing a customer transaction.
procuct_key         |   bigint      |   Surrogate key uniqe to related with each product.
customer_key        |   bigint      |   Surrogate key uniqe to related with each customer.
order_date          |   date        |   Date when the customer placed the order.
ship_date           |   date        |   Date when the order was shipped to the customer.
delivery_date       |   date        |   Date when the order was delivered to the customer.
sales               |   int         |   Total sales amount calculated as quantity × price.
quantity            |   int         |   Number of units sold per transaction line.
price               |   int         |   Unit selling price of the product.




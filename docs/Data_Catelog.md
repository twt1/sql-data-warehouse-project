
Data Dictionary for Gold Layer.

Overview
-- The data dictionary information is to descript the information of each view in gold layer as follow. 
-- 1. gold.dim_customers
-- 2. gold.dim_products
-- 3. gold.fact_sales

1. gold.dim_customers view 
Prupose : Store customer details with personal information and geographic

Column :
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
customer_key        |   bigint      |   Surrogate key uniqe to iditify each customer record.
customer_id         |   int         |   Uniqe number to identify each customer.
customer_number     |   varchar(20) |   Uniqe aphabet to identify each customer.
first_name          |   varchar(50) |   The customer first name as record in system.
last_name           |   varchar(50) |   The customer last name or family name as record.
gender              |   varchar(50) |   The infromation to identify customer gender(Female, Male). 
marital_status      |   varchar(10) |   The marital status of customer(Single, Married). 
country             |   varchar(20) |   The country of resident of customer. Ex: Germany, United States
birthdate           |   date        |   The customer date of birth.
create_date         |   date        |   The date to indentify created record. 


2. gold.dim_products view 
Prupose : Store products details with category, maintenance type and cost.

Column :
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
product_key         |   bigint      |   Surrogate key uniqe to iditify each product record.
procuct_id          |   int         |   Uniqe number to identify each product.
maintenance         |   varchar(50) |   Infrormation to identity maintenance type of each product(Yes,No).
product_number      |   varchar(30) |   Uniqe alphabet to identity each product.
product_name        |   varchar(50) |   The name to descripe the product.
product_line        |   varchar(20) |   Information to identity production line of product.
category_id         |   varchar(10) |   Alphabet to identify category of each product.
category            |   varchar(50) |   The name to descripe each category of product.
sub_category        |   varchar(50) |   The name to descripe each sub category of product.
product_cost        |   int         |   The cost of each product.
start_date          |   date        |   The date to indentify production starting of each product.


3. gold.fact_sales view
Prupose : Store sales transaction with order, shipping and delivery date, sales, quantity and price

Column :
culume_name         |   data type   |   Descriptions
---------------------------------------------------------------------------------------------------------------
order_number        |   varchar(50) |   Sales order number of each transaction.
procuct_key         |   bigint      |   Surrogate key uniqe to related with each product.
customer_key        |   bigint      |   Surrogate key uniqe to related with each customer.
order_date          |   date        |   Date to identify the order of customer.
ship_date           |   date        |   Date to identify the shipping of order.
delivery_date       |   date        |   Date to identify the order arrivved to customer.
sales               |   int         |   Total amount of each transaction(quantity*price).
quantity            |   int         |   Quantity of each product order.
price               |   int         |   Price of each product.


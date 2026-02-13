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
     4. Process of Bronze Leyer
     5. Process of Silver Leyer
     6. Process of Gold Leyer
     7. Create data catelogs
     8. Update github repository

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

     
**Summary: **




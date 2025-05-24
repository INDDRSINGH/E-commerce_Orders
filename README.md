# E-commerce Orders Data Analysis

![DatabaseSchema](https://github.com/INDDRSINGH/E-commerce_Orders/blob/main/e-commerce%20logo.png)

## This project demonstrates an end-to-end ETL (Extract, Transform, Load) pipeline for e-commerce order data. Raw order data is cleaned and preprocessed using Python, then loaded into a MySQL database for further analysis and reporting. The workflow showcases best practices in data engineering and analytics for e-commerce businesses.


## Project Workflow
  * Extract: Load raw e-commerce order data (CSV/Excel). [here](https://github.com/INDDRSINGH/restaurant_orders_MySQL/blob/main/restaurant_orders.csv)
  * Transform: Clean, preprocess, and validate data using Python (pandas, numpy) [here](https://github.com/INDDRSINGH/E-commerce_Orders/blob/main/Orders_cleaning.ipynb)
  * Load: Insert the cleaned data into a MySQL database from Python. 
  * Analyze: Run SQL queries for business insights. [here](https://github.com/INDDRSINGH/E-commerce_Orders/blob/main/SQL_Queries.md)


## Dataset
  * Source : Kaggle
  * Content : ['Order Id', 'Order Date', 'Ship Mode', 'Segment', 'Country', 'City',
       'State', 'Postal Code', 'Region', 'Category', 'Sub Category',
       'Product Id', 'cost price', 'List Price', 'Quantity',
       'Discount Percent']
  * Size : (9994, 16)


## Programming Language
  * Python (Pandas, numpy, SQLAlchemy)  

   
## DataBase
  * MySQL

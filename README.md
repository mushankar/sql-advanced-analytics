# SQL Advanced Analytics Project

This repository contains an **advanced SQL analytics project** inspired by [SQL Exploratory Data Analysis Project](https://github.com/mushankar/SQL-Exploratory_DataAnalysis_Project).  
It demonstrates how to work with structured datasets, design analytical queries, and build business-focused insights using SQL.

---

## 📂 Repository Structure

| Folder/File | Description |
|-------------|-------------|
| `datasets/analysis.bacpac` | Database backup file (SQL Server import) |
| `datasets/csv-files/gold.dim_customers.csv` | Customer dimension table |
| `datasets/csv-files/gold.dim_products.csv` | Product dimension table |
| `datasets/csv-files/gold.fact_sales.csv` | Sales fact table |
| `SQL scripts/1_change_over_time.sql` | Trend analysis over time |
| `SQL scripts/2_cumulative_analysis.sql` | Cumulative growth/rolling totals |
| `SQL scripts/3_performance_analysis.sql` | Performance metrics |
| `SQL scripts/4_proportional_analysis.sql` | Proportional comparisons |
| `SQL scripts/5_data_segmentation.sql` | Customer/product segmentation |
| `SQL scripts/6_business_report.sql` | Final business report |
| `SQL scripts/6_business_report_view.sql` | SQL view for recurring reports |


---

## 📊 Datasets
The project uses structured **dimensional data**:
- **Customers** → Demographics and attributes of customers  
- **Products** → Product hierarchy and metadata  
- **Sales Facts** → Transactions, revenue, and performance metrics  

The `.bacpac` file is provided for direct import into SQL Server, while `.csv` files allow exploration in other database systems.

---

## 🗄️ SQL Scripts
Scripts are organized in order of analysis complexity:
1. **Change Over Time** → Trends and time-based analysis  
2. **Cumulative Analysis** → Rolling totals and growth rates  
3. **Performance Analysis** → Key performance metrics  
4. **Proportional Analysis** → Ratios and percentage breakdowns  
5. **Data Segmentation** → Grouping entities for deeper insight  
6. **Business Reports** → Consolidated outputs for stakeholders  

---

## 🚀 Getting Started
1. Import the `analysis.bacpac` into **SQL Server** (or load CSV files into another RDBMS).  
2. Run the SQL scripts in numerical order for a progressive analysis workflow.  
3. Use the final business reports to generate insights.

---

## 🙌 Acknowledgement
This project follows the approach from [mushankar/SQL-Exploratory_DataAnalysis_Project](https://github.com/mushankar/SQL-Exploratory_DataAnalysis_Project), extending it with additional datasets and business-focused reports.  


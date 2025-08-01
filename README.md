# 🦠 COVID-19 Data Analysis with SQL

This project focuses on analyzing global COVID-19 data using structured SQL queries to extract insights about the pandemic's spread, death toll, and recovery trends. It demonstrates proficiency in querying relational datasets, computing aggregates, and identifying patterns over time.

## 📊 Project Objectives

- Analyze global COVID-19 data including cases, deaths, and recoveries.
- Calculate monthly averages and percentage trends.
- Derive insights such as:
  - Highest and lowest affected countries.
  - Death rate vs recovery rate comparisons.
  - Month-wise and region-wise spikes in cases.

## 🛠️ Tools & Technologies

- **SQL** (MySQL / PostgreSQL / SQLite)
- **Relational Database** (CSV imported into DB)
- **Data Source**: COVID-19 dataset from [Kaggle](https://www.kaggle.com) or [OWID](https://ourworldindata.org)

## 📁 Key Features

- ✅ Cleaned and structured pandemic data for querying.
- ✅ Used `GROUP BY`, `JOIN`, `ORDER BY`, `CASE`, and `AGGREGATE FUNCTIONS`.
- ✅ Calculated monthly averages of cases, deaths, and recoveries.
- ✅ Identified peak months and high-risk countries.

## 💻 Sample Queries

```sql
-- Monthly average of confirmed cases
SELECT MONTH(date) AS month, 
       AVG(confirmed) AS avg_cases
FROM covid_data
GROUP BY MONTH(date);

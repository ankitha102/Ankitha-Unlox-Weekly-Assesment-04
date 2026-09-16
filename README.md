# 📚 BookMart SQL Analysis — Week 4

> 🔍 Exploring Joins, Subqueries, Window Functions & CTEs using MySQL

## 📌 Project Overview

This project is part of the **Unlox Academy Week 4 Weekly Assessment** for the DA / DS Track.

The project uses a fictional online bookstore dataset called **BookMart**, containing three related tables:

- 👩‍💼 `authors` — 10 rows
- 📚 `books` — 25 rows
- 🛒 `sales` — 40 rows

The assessment focuses on applying SQL concepts to analyse relationships between authors, books, and sales data. :contentReference[oaicite:0]{index=0}

## 🎯 Objectives

- 🔗 Work with different types of SQL joins
- 🧩 Apply subqueries for filtering and comparison
- 📊 Use window functions for analytical calculations
- 🏗️ Build readable queries using CTEs
- 🔍 Analyse sales, pricing, authors, and book performance

## 🛠️ Tools & Technologies

- 🗄️ **MySQL**
- 💻 **MySQL Workbench**
- 📝 **SQL**

## 📂 Dataset Structure

### 👩‍💼 Authors
Contains author information including:

`author_id` • `name` • `country` • `born_year` • `mentor_id`

### 📚 Books
Contains book details including:

`book_id` • `title` • `author_id` • `genre` • `price` • `published_year` • `avg_rating`

### 🛒 Sales
Contains sales information including:

`sale_id` • `book_id` • `quantity` • `sale_date` • `city` • `customer_type`

## 🔗 SQL Topics Covered

### 🔹 C1–C4 → Basic Joins
- INNER JOIN
- LEFT JOIN
- Aggregate functions with joins
- Revenue analysis

### 🔹 C5–C7 → Extended Joins
- RIGHT JOIN
- FULL OUTER JOIN using the UNION technique
- SELF JOIN

### 🔹 C8–C10 → Set Operations
- CROSS JOIN
- UNION
- Anti-Join using LEFT JOIN + IS NULL

### 🔹 C11–C14 → Subqueries
- Scalar subqueries
- `IN` with subqueries
- `> ALL`
- Correlated subqueries

### 🔹 C15–C17 → EXISTS / NOT EXISTS
- EXISTS
- NOT EXISTS
- Subquery-based filtering

### 🔹 C18–C21 → Window Functions
- `AVG() OVER(PARTITION BY ...)`
- `ROW_NUMBER()`
- `LAG()`
- Running totals using `SUM() OVER()`

### 🔹 C22–C24 → CTEs & Synthesis
- CTEs using `WITH`
- Multi-CTE queries
- Ranking with `RANK()`
- Combining CTEs, joins, and window functions

## 🧠 Key SQL Concepts

`INNER JOIN` • `LEFT JOIN` • `RIGHT JOIN` • `SELF JOIN` • `CROSS JOIN` • `UNION` • `EXISTS` • `NOT EXISTS` • `GROUP BY` • `HAVING` • `CASE` • `AVG()` • `SUM()` • `RANK()` • `ROW_NUMBER()` • `LAG()` • `OVER()` • `PARTITION BY` • `WITH`

## 🚀 How to Run

1. 💻 Open **MySQL Workbench**
2. 📥 Run `bookmart_setup.sql`
3. 🗄️ Select the `bookmart` database
4. 📄 Open `Week4_Assessment_Ankitha.sql`
5. ▶️ Execute the queries
6. 📊 Review the generated results

The assessment instructions specify running `bookmart_setup.sql` in MySQL Workbench before starting the assessment. :contentReference[oaicite:1]{index=1}

## 📁 Project Structure

```text
BookMart-SQL-Week4/
│
├── 📄 bookmart_setup.sql
├── 📄 Week4_Assessment_Ankitha.sql
└── 📘 README.md

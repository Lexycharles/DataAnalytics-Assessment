# 📊 SQL Proficiency Assessment

This project demonstrates the ability to write practical, business-relevant SQL by solving real-world challenges across customer and transaction data. The focus areas include data aggregation, joins, subqueries, filtering, and customer behaviour analysis.
<br>
## Table of Contents
- [Database Structure](#database-structure)
- [Business Use & Query Solutions](#business-use-&-query-solutions)
- [My Challenges & Conclusion](#My-Challenges-&-Conclusion)

<br>
<br>
  

## 🗂️ Database Structure

The database is composed of four relational tables:

| Table Name               | Description                                                           |
| ------------------------ | --------------------------------------------------------------------- |
| `users_customuser`       | Contains customer profile, demographics, and registration dates       |
| `savings_savingsaccount` | Records deposit transactions for customer savings accounts            |
| `plans_plan`             | Tracks investment plans, including whether it is a fund and its value |
| `withdrawals_withdrawal` | Records withdrawal transactions                                       |

Each query addresses a specific business objective using structured SQL logic.

<br>

## 🎯 Business Use & Query Solutions

<br>

### 1️⃣ High-Value Customers with Multiple Products

**🧠 Objective:**
Identify customers who are actively engaging with both savings and investment products. These customers are more loyal, have higher trust, and offer better cross-selling opportunities.

**🔍 Approach & Query Logic:**

* Performed **INNER JOINs** between `users_customuser`, `savings_savingsaccount`, and `plans_plan`.
* Applied **filters** to select:

  * Funded savings accounts (`confirmed_amount > 0`)
  * Funded investment plans (`is_a_fund = 1 AND amount > 0`)
* Used **aggregate functions** (`COUNT`, `SUM`) to:

  * Count the number of qualifying accounts per customer
  * Sum all their deposits across savings and investment plans
* Implemented **COALESCE** to handle any `NULL` values in deposit fields, ensuring total deposits are calculated accurately.
* Ordered the final result by total deposits (descending) to prioritise the most valuable customers.

📁 [View Query – Assessment\_Q1.sql](./Assessment_Q1.sql)

<br>

### 2️⃣ Transaction Frequency Analysis

**🧠 Objective:**
Segment customers based on how frequently they transact. This helps personalise experiences and optimise marketing for high- and low-engagement users.

**🔍 Approach & Query Logic:**

* Used **Common Table Expressions (CTEs)** for modularity and clarity:

  1. `monthly_transactions`: Aggregates the number of transactions per customer per month using `DATE_FORMAT` and `COUNT`.
  2. `customer_avg`: Calculates the average number of monthly transactions per customer using `AVG`.
* Categorised users into frequency bands:

  * 🟢 High (≥10/month)
  * 🟡 Medium (3–9/month)
  * 🔴 Low (≤2/month)
* Final query **counts the number of users** in each category and provides their **average frequency**.

📁 [View Query – Assessment\_Q2.sql](./Assessment_Q2.sql)

<br>

### 3️⃣ Account Inactivity Alert

**🧠  Objective:**
Detect funded accounts that have been inactive for one year OR less (<366 days). This will help to enable re-engagement efforts or account closure risk assessments.

**🔍 Approach & Query Logic:**

* Constructed **two subqueries**—one for savings and one for investment accounts.
* For each:

  * Filtered funded accounts:

    * Savings: `confirmed_amount > 0`
    * Investments: `is_a_fund = 1 AND amount > 0`
  * Used `MAX(created_on)` to get the **most recent transaction date** per account.
  * Calculated **inactivity duration** using `CURRENT_DATE - last_transaction_date`.
  * Applied a filter for `inactivity_days < 366`.
* **UNION ALL** was used to combine savings and investment results.
* Included account ID, owner ID, account type, last transaction date, and inactivity duration in output.

📁 [View Query – Assessment\_Q3.sql](./Assessment_Q3.sql)

<br>

### 4️⃣ Customer Lifetime Value (CLV) Estimation

**🧠 Objective:**
Estimate each customer's potential long-term value based on their activity and tenure, to support retention and upselling strategies.

**🔍 Approach & Query Logic:**

* Calculated **account tenure in months** by subtracting `date_joined` (from `users_customuser`) from the current date and converting to months.
* Counted **total transactions** for each customer using the `savings_savingsaccount` table.
* Estimated **average profit per transaction** as `0.1%` of the transaction value.
* Applied the Customer Lifetime Value (CLV) formula:

    * CLV = (total_transactions / tenure) * 12 * `avg_profit_per_transaction`
  
* Excluded customers with `0` tenure months to avoid division errors.
* Output includes customer ID, name, tenure, transaction volume, and estimated CLV.

📁 [View Query – Assessment\_Q4.sql](./Assessment_Q4.sql)

<br>


## ✅ My Challenges & Conclusion

This SQL Proficiency Assessment provided an enriching opportunity to apply theoretical knowledge in a practical, business-oriented context. While completing the tasks, I encountered a few challenges that ultimately enhanced my understanding of SQL and database interactions.

Initially, the absence of a specified SQL tool required me to explore and select a suitable environment for executing queries against simulated relational data. This experience improved my adaptability and familiarity with working across different database platforms.

Navigating complex datasets with multiple tables and relationships further tested my ability to accurately interpret and implement primary and foreign key connections. By carefully planning and structuring my `INNER JOIN` operations, I ensured precise data retrieval without redundancy.

Moreover, I deepened my proficiency with critical SQL functions such as `COALESCE` for managing `NULL` values and Common Table Expressions (CTEs) for breaking down multi-step analyses into readable, modular parts.

Overall, this project strengthened my practical SQL skills—particularly in areas such as customer segmentation, transaction analysis, and value estimation—while also reinforcing the importance of clean, scalable query design in real-world data scenarios.

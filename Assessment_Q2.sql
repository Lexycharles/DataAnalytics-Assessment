-- Assessment_Q2: Transaction Frequency Analysis

WITH monthly_transactions AS (
    -- Calculate monthly transaction counts per customer
    SELECT 
        owner_id,
        DATE_FORMAT(created_on, '%Y-%m') AS month,  -- Standardize date format
        COUNT(*) AS transactions  -- Monthly transaction count
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_FORMAT(created_on, '%Y-%m')  -- Group by customer-month
),
customer_avg AS (
    -- Calculate average monthly transactions per customer
    SELECT 
        owner_id,
        AVG(transactions) AS avg_transactions  -- Monthly average
    FROM monthly_transactions
    GROUP BY owner_id
)
-- Categorize customers based on transaction frequency
SELECT 
    CASE 
        WHEN avg_transactions >= 10 THEN 'High Frequency'
        WHEN avg_transactions >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,  -- Business-defined segments
    COUNT(owner_id) AS customer_count,  -- Customers per category
    ROUND(AVG(avg_transactions), 1) AS avg_transactions_per_month  -- Category average
FROM customer_avg  -- Original typo preserved (likely should be customer_avg)
GROUP BY frequency_category;
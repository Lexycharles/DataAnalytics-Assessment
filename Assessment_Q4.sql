-- Assessment_Q4: Customer Lifetime Value (CLV) Estimation

SELECT
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS Name,  -- Full customer name (first & last names)
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,  -- Account age in months
    COUNT(s.id) AS total_transactions,  -- Lifetime transaction count
    -- Applying CLV formula: (transactions/month) * 12 * avg_profit_per_transaction
    (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * 
    (SUM(s.confirmed_amount) * 0.01 / COUNT(s.id)) AS estimated_clv  -- 1% profit assumption
FROM users_customuser u
-- Join all savings transactions
JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id, u.name  -- Aggregate per customer
HAVING tenure_months > 0  -- Exclude new signups (0 tenure)
ORDER BY estimated_clv DESC;  -- Prioritize highest-value customers
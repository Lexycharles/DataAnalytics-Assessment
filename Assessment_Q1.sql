-- Assessment_Q1: High-Value Customers with Multiple Products

SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS Name,  -- Combine first & last names
    COUNT(s.id) AS savings_count,  -- Count of valid savings plans
    COUNT(p.id) AS investment_count,  -- Count of valid investment plans
    (COALESCE(SUM(s.confirmed_amount), 0) + COALESCE(SUM(p.amount), 0)) AS total_deposits  -- Sum deposits from both products
FROM users_customuser u
-- Join funded savings accounts (confirmed_amount > 0)
INNER JOIN savings_savingsaccount s ON u.id = s.owner_id
    AND s.confirmed_amount > 0
-- Join active investment funds (is_a_fund = 1 with deposits)
INNER JOIN plans_plan p ON u.id = p.owner_id
    AND p.is_a_fund = 1
    AND p.amount > 0
GROUP BY u.id, u.name  -- Aggregating per customer
ORDER BY total_deposits DESC;  -- Prioritizing highest deposit customers
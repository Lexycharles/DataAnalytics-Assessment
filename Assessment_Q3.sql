-- Assessment_Q3

SELECT 
    id AS plan_id,
    owner_id,
    'Savings' AS type,  -- Explicitly label account type
    MAX(created_on) AS last_transaction_date,  -- Most recent activity date
    DATEDIFF(CURDATE(), MAX(created_on)) AS inactivity_days  -- Days since last transaction
FROM savings_savingsaccount
WHERE confirmed_amount > 0  -- Filter funded savings accounts
GROUP BY id, owner_id  -- Group by individual savings plans
HAVING DATEDIFF(CURDATE(), MAX(created_on)) < 366  -- Flag accounts with activity in last year
UNION ALL
SELECT 
    id AS plan_id,
    owner_id,
    'Investment' AS type,  -- Explicitly label account type
    MAX(created_on) AS last_transaction_date,  -- Most recent activity date
    DATEDIFF(CURDATE(), MAX(created_on)) AS inactivity_days  -- Days since last transaction
FROM plans_plan
WHERE 
    amount > 0  -- Filter funded plans
    AND is_a_fund = 1  -- Restrict to investment-type plans
GROUP BY id, owner_id  -- Group by individual investment plans
HAVING DATEDIFF(CURDATE(), MAX(created_on)) < 366;  -- Flag accounts with activity in last year
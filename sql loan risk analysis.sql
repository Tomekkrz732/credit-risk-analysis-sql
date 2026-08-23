-- 1. Default Rate Segmentation by Credit Grade
-- Evaluating how probability of default correlates with the initial risk scoring
SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate_percentage
FROM 
    loan_data
GROUP BY 
    grade
ORDER BY 
    grade;

-- 2. Housing Status Impact on Default Risk
-- Assessing whether property ownership influences borrower discipline
SELECT 
    home_ownership,
    COUNT(*) AS total_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate_percentage
FROM 
    loan_data
GROUP BY 
    home_ownership
ORDER BY 
    total_loans DESC;

-- 3. Behavioral Risk Segmentation by Loan Purpose
-- Identifying which loan purposes generate the highest rate of capital loss
SELECT 
    purpose,
    COUNT(*) AS total_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate_percentage
FROM 
    loan_data
GROUP BY 
    purpose
ORDER BY 
    default_rate_percentage DESC;
CREATE OR REPLACE TABLE `lab025-p003.new_data.loans_outstanding_features` AS
WITH base AS (
  SELECT
    user_id,
    -- Normaliza loan_type
    CASE 
      WHEN UPPER(TRIM(loan_type)) IN ('REAL ESTATE') THEN 'REAL ESTATE'
      WHEN UPPER(TRIM(loan_type)) IN ('OTHER', 'OTHERS') THEN 'OTHERS'
      ELSE 'UNKNOWN'
    END AS loan_type,
    loan_id
  FROM `lab025-p003.dataset.loans_outstanding`
)
SELECT
  user_id,
  COUNT(DISTINCT loan_id) AS total_emprestimos,
  COUNTIF(loan_type = 'REAL ESTATE') AS qtd_real_estate,
  COUNTIF(loan_type = 'OTHERS') AS qtd_others,
  COUNTIF(loan_type = 'REAL ESTATE') / CAST(COUNT(DISTINCT loan_id) AS FLOAT64) AS perc_real_estate,
  COUNTIF(loan_type = 'OTHERS') / CAST(COUNT(DISTINCT loan_id) AS FLOAT64) AS perc_others
FROM base
GROUP BY user_id;

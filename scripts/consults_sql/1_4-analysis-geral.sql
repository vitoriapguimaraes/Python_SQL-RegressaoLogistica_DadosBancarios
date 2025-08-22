WITH estatisticas AS (
  SELECT 'more_90_days_overdue' AS coluna, more_90_days_overdue AS valor FROM `lab025-p003.dataset.loans_detail`
  UNION ALL SELECT 'using_lines_not_secured_personal_assets', using_lines_not_secured_personal_assets FROM `lab025-p003.dataset.loans_detail`
  UNION ALL SELECT 'number_times_delayed_payment_loan_30_59_days', number_times_delayed_payment_loan_30_59_days FROM `lab025-p003.dataset.loans_detail`
  UNION ALL SELECT 'debt_ratio', debt_ratio FROM `lab025-p003.dataset.loans_detail`
  UNION ALL SELECT 'number_times_delayed_payment_loan_60_89_days', number_times_delayed_payment_loan_60_89_days FROM `lab025-p003.dataset.loans_detail`
  UNION ALL SELECT 'age', age FROM `lab025-p003.dataset.user_info`
  UNION ALL SELECT 'last_month_salary', last_month_salary FROM `lab025-p003.dataset.user_info`
  UNION ALL SELECT 'number_dependents', number_dependents FROM `lab025-p003.dataset.user_info`
),

quartis AS (
  SELECT
    coluna,
    MIN(valor) AS min,
    MAX(valor) AS max,
    AVG(valor) AS media,
    APPROX_QUANTILES(valor, 4)[OFFSET(1)] AS q1,
    APPROX_QUANTILES(valor, 4)[OFFSET(3)] AS q3,
    APPROX_QUANTILES(valor, 4)[OFFSET(3)] - APPROX_QUANTILES(valor, 4)[OFFSET(1)] AS iqr
  FROM estatisticas
  GROUP BY coluna
),

outliers AS (
  SELECT
    e.coluna,
    COUNT(*) AS total_outliers
  FROM estatisticas e
  JOIN quartis q ON e.coluna = q.coluna
  WHERE e.valor < (q.q1 - 1.5 * q.iqr)
     OR e.valor > (q.q3 + 1.5 * q.iqr)
  GROUP BY e.coluna
)

SELECT
  q.coluna,
  IFNULL(o.total_outliers, 0) AS total_outliers,
  ROUND(q.min, 2) AS min,
  ROUND(q.max, 2) AS max,
  ROUND(q.media, 2) AS media,
  ROUND(q.q1, 2) AS q1,
  ROUND(q.q3, 2) AS q3,
  ROUND(q.iqr, 2) AS iqr,
  ROUND(q.q1 - 1.5 * q.iqr, 2) AS limite_inferior,
  ROUND(q.q3 + 1.5 * q.iqr, 2) AS limite_superior
FROM quartis q
LEFT JOIN outliers o ON q.coluna = o.coluna
ORDER BY total_outliers DESC;
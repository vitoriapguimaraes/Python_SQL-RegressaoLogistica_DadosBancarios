WITH limites AS (
  SELECT
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(1)] AS q1_last_month_salary,
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(3)] AS q3_last_month_salary
  FROM `lab025-p003.new_data.dt_complete_ok`
),
outliers AS (
  SELECT
    A.*,
    CASE 
      WHEN A.last_month_salary < q1_last_month_salary - 1.5 * (q3_last_month_salary - q1_last_month_salary) 
        OR A.last_month_salary > q3_last_month_salary + 1.5 * (q3_last_month_salary - q1_last_month_salary) 
      THEN TRUE ELSE FALSE 
    END AS last_month_salary_outlier

  FROM `lab025-p003.new_data.dt_complete_ok` A
  CROSS JOIN limites
)
SELECT *
FROM outliers
WHERE
   last_month_salary_outlier;
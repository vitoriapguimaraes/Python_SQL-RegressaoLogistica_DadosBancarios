WITH limites AS (
  SELECT
    APPROX_QUANTILES(age, 4)[OFFSET(1)] AS q1_age,
    APPROX_QUANTILES(age, 4)[OFFSET(3)] AS q3_age,
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(1)] AS q1_last_month_salary,
    APPROX_QUANTILES(last_month_salary, 4)[OFFSET(3)] AS q3_last_month_salary,
    APPROX_QUANTILES(number_dependents, 4)[OFFSET(1)] AS q1_number_dependents,
    APPROX_QUANTILES(number_dependents, 4)[OFFSET(3)] AS q3_number_dependents
  FROM `lab025-p003.dataset.user_info`
),
outliers AS (
  SELECT
    A.user_id,
    
    A.age,
    CASE 
      WHEN A.age < q1_age - 1.5 * (q3_age - q1_age) 
        OR A.age > q3_age + 1.5 * (q3_age - q1_age) 
      THEN TRUE ELSE FALSE 
    END AS age_outlier,

    A.last_month_salary,
    CASE 
      WHEN A.last_month_salary < q1_last_month_salary - 1.5 * (q3_last_month_salary - q1_last_month_salary) 
        OR A.last_month_salary > q3_last_month_salary + 1.5 * (q3_last_month_salary - q1_last_month_salary) 
      THEN TRUE ELSE FALSE 
    END AS last_month_salary_outlier,

    A.number_dependents,
    CASE 
      WHEN A.number_dependents < q1_number_dependents - 1.5 * (q3_number_dependents - q1_number_dependents) 
        OR A.number_dependents > q3_number_dependents + 1.5 * (q3_number_dependents - q1_number_dependents) 
      THEN TRUE ELSE FALSE 
    END AS number_dependents_outlier,

  FROM `lab025-p003.dataset.user_info` A
  CROSS JOIN limites
)
SELECT *
FROM outliers
WHERE age_outlier
   OR last_month_salary_outlier
   OR number_dependents_outlier;
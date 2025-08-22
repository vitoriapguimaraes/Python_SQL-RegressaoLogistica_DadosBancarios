WITH base AS (
  SELECT
    age,
    CASE WHEN sex = 'F' THEN 1 WHEN sex = 'M' THEN 0 END AS sex_num,
    last_month_salary,
    number_dependents
  FROM `lab025-p003.dataset.user_info`
)

SELECT 'age' AS variavel,
  CORR(age, age) AS age,
  CORR(age, sex_num) AS sex,
  CORR(age, last_month_salary) AS last_month_salary,
  CORR(age, number_dependents) AS number_dependents
FROM base

UNION ALL

SELECT 'sex' AS variavel,
  CORR(sex_num, age) AS age,
  CORR(sex_num, sex_num) AS sex,
  CORR(sex_num, last_month_salary) AS last_month_salary,
  CORR(sex_num, number_dependents) AS number_dependents
FROM base

UNION ALL

SELECT 'last_month_salary' AS variavel,
  CORR(last_month_salary, age) AS age,
  CORR(last_month_salary, sex_num) AS sex,
  CORR(last_month_salary, last_month_salary) AS last_month_salary,
  CORR(last_month_salary, number_dependents) AS number_dependents
FROM base

UNION ALL

SELECT 'number_dependents' AS variavel,
  CORR(number_dependents, age) AS age,
  CORR(number_dependents, sex_num) AS sex,
  CORR(number_dependents, last_month_salary) AS last_month_salary,
  CORR(number_dependents, number_dependents) AS number_dependents
FROM base;

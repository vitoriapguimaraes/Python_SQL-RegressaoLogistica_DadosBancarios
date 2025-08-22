SELECT 
  COUNT(*) AS linhas_totais,
  COUNTIF(user_id IS NULL) AS user_id_NULL,
  COUNTIF(age IS NULL) AS age_NULL,
  COUNTIF(sex IS NULL) AS sex_NULL,
  COUNTIF(last_month_salary IS NULL) AS last_month_salary_NULL,
  COUNTIF(number_dependents IS NULL) AS number_dependents_NULL
FROM `lab025-p003.dataset.user_info`
SELECT 
  user_id, age, sex, last_month_salary, number_dependents,
  COUNT(*) AS quant_freq
FROM `lab025-p003.dataset.user_info`
GROUP BY
  user_id, age, sex, last_month_salary, number_dependents
HAVING COUNT(*) > 1;
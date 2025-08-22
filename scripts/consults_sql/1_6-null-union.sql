SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(user_id IS NULL) AS user_id_NULL,
  COUNTIF(age IS NULL) AS age_NULL,
  COUNTIF(sex_num IS NULL) AS sex_num_NULL,
  COUNTIF(last_month_salary IS NULL) AS last_month_salary_NULL,
  COUNTIF(number_dependents IS NULL) AS number_dependents_NULL,
  COUNTIF(total_emprestimos IS NULL) AS total_emprestimos_NULL,
  COUNTIF(qtd_real_estate IS NULL) AS qtd_real_estate_NULL,
  COUNTIF(qtd_others IS NULL) AS qtd_others_NULL,
  COUNTIF(perc_real_estate IS NULL) AS perc_real_estate_NULL,
  COUNTIF(perc_others IS NULL) AS perc_others_NULL,
  COUNTIF(more_90_days_overdue IS NULL) as more_90_days_overdue_NULL,
  COUNTIF(using_lines_not_secured_personal_assets IS NULL) AS using_lines_not_secured_personal_assets_NULL,
  COUNTIF(number_times_delayed_payment_loan_30_59_days IS NULL) AS number_times_delayed_payment_loan_30_59_days_NULL,
  COUNTIF(debt_ratio IS NULL) AS debt_ratio_NULL,
  COUNTIF(number_times_delayed_payment_loan_60_89_days IS NULL) AS number_times_delayed_payment_loan_60_89_days_NULL,
  COUNTIF(default_flag IS NULL) AS default_flag_NULL
FROM `lab025-p003.new_data.dataset_complete`
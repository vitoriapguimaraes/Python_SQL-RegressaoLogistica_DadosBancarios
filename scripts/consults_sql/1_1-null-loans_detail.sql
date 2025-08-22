SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(user_id IS NULL) AS user_id_NULL,
  COUNTIF(more_90_days_overdue IS NULL) as more_90_days_overdue_NULL,
  COUNTIF(using_lines_not_secured_personal_assets IS NULL) AS using_lines_not_secured_personal_assets_NULL,
  COUNTIF(number_times_delayed_payment_loan_30_59_days IS NULL) AS number_times_delayed_payment_loan_30_59_days_NULL,
  COUNTIF(debt_ratio IS NULL) AS debt_ratio_NULL,
  COUNTIF(number_times_delayed_payment_loan_60_89_days IS NULL) AS number_times_delayed_payment_loan_60_89_days_NULL
FROM `lab025-p003.dataset.loans_detail`
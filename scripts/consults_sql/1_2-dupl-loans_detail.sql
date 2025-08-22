SELECT
  user_id,
  more_90_days_overdue,
  using_lines_not_secured_personal_assets,
  number_times_delayed_payment_loan_30_59_days,
  debt_ratio,
  number_times_delayed_payment_loan_60_89_days,
  COUNT(*) AS quant_null
FROM `lab025-p003.dataset.loans_detail`
GROUP BY
  user_id,
  more_90_days_overdue,
  using_lines_not_secured_personal_assets,
  number_times_delayed_payment_loan_30_59_days,
  debt_ratio,
  number_times_delayed_payment_loan_60_89_days
HAVING COUNT(*) > 1;
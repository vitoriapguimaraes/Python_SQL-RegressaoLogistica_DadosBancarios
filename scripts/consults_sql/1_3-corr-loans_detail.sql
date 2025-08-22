SELECT 'more_90_days_overdue' AS variavel,
  CORR(more_90_days_overdue, more_90_days_overdue) AS more_90_days_overdue,
  CORR(more_90_days_overdue, using_lines_not_secured_personal_assets) AS using_lines_not_secured_personal_assets,
  CORR(more_90_days_overdue, number_times_delayed_payment_loan_30_59_days) AS number_times_delayed_payment_loan_30_59_days,
  CORR(more_90_days_overdue, debt_ratio) AS debt_ratio,
  CORR(more_90_days_overdue, number_times_delayed_payment_loan_60_89_days) AS number_times_delayed_payment_loan_60_89_days
FROM `lab025-p003.dataset.loans_detail`

UNION ALL

SELECT 'using_lines_not_secured_personal_assets' AS variavel,
  CORR(using_lines_not_secured_personal_assets, more_90_days_overdue) AS more_90_days_overdue,
  CORR(using_lines_not_secured_personal_assets, using_lines_not_secured_personal_assets) AS using_lines_not_secured_personal_assets,
  CORR(using_lines_not_secured_personal_assets, number_times_delayed_payment_loan_30_59_days) AS number_times_delayed_payment_loan_30_59_days,
  CORR(using_lines_not_secured_personal_assets, debt_ratio) AS debt_ratio,
  CORR(using_lines_not_secured_personal_assets, number_times_delayed_payment_loan_60_89_days) AS number_times_delayed_payment_loan_60_89_days
FROM `lab025-p003.dataset.loans_detail`

UNION ALL

SELECT 'number_times_delayed_payment_loan_30_59_days' AS variavel,
  CORR(number_times_delayed_payment_loan_30_59_days, more_90_days_overdue) AS more_90_days_overdue,
  CORR(number_times_delayed_payment_loan_30_59_days, using_lines_not_secured_personal_assets) AS using_lines_not_secured_personal_assets,
  CORR(number_times_delayed_payment_loan_30_59_days, number_times_delayed_payment_loan_30_59_days) AS number_times_delayed_payment_loan_30_59_days,
  CORR(number_times_delayed_payment_loan_30_59_days, debt_ratio) AS debt_ratio,
  CORR(number_times_delayed_payment_loan_30_59_days, number_times_delayed_payment_loan_60_89_days) AS number_times_delayed_payment_loan_60_89_days
FROM `lab025-p003.dataset.loans_detail`

UNION ALL

SELECT 'debt_ratio' AS variavel,
  CORR(debt_ratio, more_90_days_overdue) AS more_90_days_overdue,
  CORR(debt_ratio, using_lines_not_secured_personal_assets) AS using_lines_not_secured_personal_assets,
  CORR(debt_ratio, number_times_delayed_payment_loan_30_59_days) AS number_times_delayed_payment_loan_30_59_days,
  CORR(debt_ratio, debt_ratio) AS debt_ratio,
  CORR(debt_ratio, number_times_delayed_payment_loan_60_89_days) AS number_times_delayed_payment_loan_60_89_days
FROM `lab025-p003.dataset.loans_detail`

UNION ALL

SELECT 'number_times_delayed_payment_loan_60_89_days' AS variavel,
  CORR(number_times_delayed_payment_loan_60_89_days, more_90_days_overdue) AS more_90_days_overdue,
  CORR(number_times_delayed_payment_loan_60_89_days, using_lines_not_secured_personal_assets) AS using_lines_not_secured_personal_assets,
  CORR(number_times_delayed_payment_loan_60_89_days, number_times_delayed_payment_loan_30_59_days) AS number_times_delayed_payment_loan_30_59_days,
  CORR(number_times_delayed_payment_loan_60_89_days, debt_ratio) AS debt_ratio,
  CORR(number_times_delayed_payment_loan_60_89_days, number_times_delayed_payment_loan_60_89_days) AS number_times_delayed_payment_loan_60_89_days
FROM `lab025-p003.dataset.loans_detail`;

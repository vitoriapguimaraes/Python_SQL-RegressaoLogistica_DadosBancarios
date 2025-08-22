WITH limites AS (
  SELECT
    APPROX_QUANTILES(more_90_days_overdue, 4)[OFFSET(1)] AS q1_more_90_days_overdue,
    APPROX_QUANTILES(more_90_days_overdue, 4)[OFFSET(3)] AS q3_more_90_days_overdue,
    APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(1)] AS q1_using_lines_not_secured_personal_assets,
    APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(3)] AS q3_using_lines_not_secured_personal_assets,
    APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(1)] AS q1_number_times_delayed_payment_loan_30_59_days,
    APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(3)] AS q3_number_times_delayed_payment_loan_30_59_days,
    APPROX_QUANTILES(debt_ratio, 4)[OFFSET(1)] AS q1_debt_ratio,
    APPROX_QUANTILES(debt_ratio, 4)[OFFSET(3)] AS q3_debt_ratio,
    APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(1)] AS q1_number_times_delayed_payment_loan_60_89_days,
    APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(3)] AS q3_number_times_delayed_payment_loan_60_89_days
  FROM `lab025-p003.dataset.loans_detail`
),
outliers AS (
  SELECT

    A.user_id,
    
    A.more_90_days_overdue,
    CASE 
      WHEN A.more_90_days_overdue < q1_more_90_days_overdue - 1.5 * (q3_more_90_days_overdue - q1_more_90_days_overdue) 
        OR A.more_90_days_overdue > q3_more_90_days_overdue + 1.5 * (q3_more_90_days_overdue - q1_more_90_days_overdue) 
      THEN TRUE ELSE FALSE 
    END AS more_90_days_overdue_outlier,

    A.using_lines_not_secured_personal_assets,
    CASE 
      WHEN A.using_lines_not_secured_personal_assets < q1_using_lines_not_secured_personal_assets - 1.5 * (q3_using_lines_not_secured_personal_assets - q1_using_lines_not_secured_personal_assets) 
        OR A.using_lines_not_secured_personal_assets > q3_using_lines_not_secured_personal_assets + 1.5 * (q3_using_lines_not_secured_personal_assets - q1_using_lines_not_secured_personal_assets) 
      THEN TRUE ELSE FALSE 
    END AS using_lines_not_secured_personal_assets_outlier,

    A.number_times_delayed_payment_loan_30_59_days,
    CASE 
      WHEN A.number_times_delayed_payment_loan_30_59_days < q1_number_times_delayed_payment_loan_30_59_days - 1.5 * (q3_number_times_delayed_payment_loan_30_59_days - q1_number_times_delayed_payment_loan_30_59_days) 
        OR A.number_times_delayed_payment_loan_30_59_days > q3_number_times_delayed_payment_loan_30_59_days + 1.5 * (q3_number_times_delayed_payment_loan_30_59_days - q1_number_times_delayed_payment_loan_30_59_days) 
      THEN TRUE ELSE FALSE 
    END AS number_times_delayed_payment_loan_30_59_days_outlier,

    A.debt_ratio,
    CASE 
      WHEN A.debt_ratio < q1_debt_ratio - 1.5 * (q3_debt_ratio - q1_debt_ratio) 
        OR A.debt_ratio > q3_debt_ratio + 1.5 * (q3_debt_ratio - q1_debt_ratio) 
      THEN TRUE ELSE FALSE 
    END AS debt_ratio_outlier,

    A.number_times_delayed_payment_loan_60_89_days,
    CASE 
      WHEN A.number_times_delayed_payment_loan_60_89_days < q1_number_times_delayed_payment_loan_60_89_days - 1.5 * (q3_number_times_delayed_payment_loan_60_89_days - q1_number_times_delayed_payment_loan_60_89_days) 
        OR A.number_times_delayed_payment_loan_60_89_days > q3_number_times_delayed_payment_loan_60_89_days + 1.5 * (q3_number_times_delayed_payment_loan_60_89_days - q1_number_times_delayed_payment_loan_60_89_days) 
      THEN TRUE ELSE FALSE 
    END AS number_times_delayed_payment_loan_60_89_days_outlier

  FROM `lab025-p003.dataset.loans_detail` A
  CROSS JOIN limites
)
SELECT *
FROM outliers
WHERE
   more_90_days_overdue_outlier
   OR using_lines_not_secured_personal_assets_outlier
   OR number_times_delayed_payment_loan_30_59_days_outlier
   OR debt_ratio_outlier
   OR number_times_delayed_payment_loan_60_89_days_outlier;
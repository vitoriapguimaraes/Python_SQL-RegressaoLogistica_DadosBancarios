DECLARE cols ARRAY<STRING>;
DECLARE sql STRING;

SET cols = [
  'more_90_days_overdue','using_lines_not_secured_personal_assets',
  'number_times_delayed_payment_loan_30_59_days','debt_ratio',
  'number_times_delayed_payment_loan_60_89_days','total_emprestimos',
  'qtd_real_estate','qtd_others','perc_real_estate','perc_others',
  'age','sex_num','last_month_salary','number_dependents'
];

SET sql = (
  SELECT STRING_AGG(FORMAT("""
    SELECT '%s' AS var1, '%s' AS var2,
           CORR(%s, %s) AS correlacao
    FROM base
  """, c1, c2, c1, c2), " UNION ALL ")
  FROM UNNEST(cols) c1, UNNEST(cols) c2
);

EXECUTE IMMEDIATE """
WITH base AS (
  SELECT
    d.user_id,
    d.more_90_days_overdue,
    d.using_lines_not_secured_personal_assets,
    d.number_times_delayed_payment_loan_30_59_days,
    d.debt_ratio,
    d.number_times_delayed_payment_loan_60_89_days,
    f.total_emprestimos,
    f.qtd_real_estate,
    f.qtd_others,
    f.perc_real_estate,
    f.perc_others,
    u.age,
    CASE WHEN u.sex = 'F' THEN 1 WHEN u.sex = 'M' THEN 0 END AS sex_num,
    u.last_month_salary,
    u.number_dependents
  FROM `lab025-p003.dataset.loans_detail` d
  JOIN `lab025-p003.new_data.loans_outstanding_features` f
    ON d.user_id = f.user_id
  JOIN `lab025-p003.dataset.user_info` u
    ON d.user_id = u.user_id
)
""" || sql;
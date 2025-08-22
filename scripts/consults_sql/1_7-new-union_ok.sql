-- Cria uma versão ajustada da tabela com imputação da mediana
CREATE OR REPLACE TABLE `lab025-p003.new_data.dt_complete_ok` AS

WITH faixa_etaria AS (
  SELECT
    user_id,
    CASE 
      WHEN age < 30 THEN 'faixa_1_menos30'
      WHEN age BETWEEN 30 AND 50 THEN 'faixa_2_30a50'
      ELSE 'faixa_3_mais50'
    END AS faixa,
    age,
    sex_num,
    last_month_salary,
    number_dependents,
    total_emprestimos,
    qtd_real_estate,
    qtd_others,
    perc_real_estate,
    perc_others,
    more_90_days_overdue,
    using_lines_not_secured_personal_assets,
    number_times_delayed_payment_loan_30_59_days,
    debt_ratio,
    number_times_delayed_payment_loan_60_89_days,
    default_flag
  FROM `lab025-p003.new_data.dataset_complete`
),

medianas AS (
  SELECT
    faixa,
    default_flag,
    APPROX_QUANTILES(last_month_salary, 2)[OFFSET(1)] AS mediana_salario
  FROM faixa_etaria
  WHERE last_month_salary IS NOT NULL
  GROUP BY faixa, default_flag
)

SELECT
  f.user_id,
  f.age,
  f.sex_num,
  COALESCE(f.last_month_salary, m.mediana_salario) AS last_month_salary, -- imputação
  f.number_dependents,
  f.total_emprestimos,
  f.qtd_real_estate,
  f.qtd_others,
  f.perc_real_estate,
  f.perc_others,
  f.more_90_days_overdue,
  f.using_lines_not_secured_personal_assets,
  f.number_times_delayed_payment_loan_30_59_days,
  f.debt_ratio,
  f.number_times_delayed_payment_loan_60_89_days,
  f.default_flag
FROM faixa_etaria f
LEFT JOIN medianas m
  ON f.faixa = m.faixa
 AND f.default_flag = m.default_flag;

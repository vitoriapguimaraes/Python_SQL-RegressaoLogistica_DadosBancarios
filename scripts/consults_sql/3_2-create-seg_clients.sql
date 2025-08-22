CREATE OR REPLACE TABLE `lab025-p003.new_data.clientes_score` AS
WITH quartis AS (
  SELECT var_name, q1, q2, q3
  FROM `lab025-p003.new_data.stats_summary`
  WHERE var_name IN ('age','last_month_salary','total_emprestimos','qtd_real_estate','qtd_others',
                     'number_times_delayed_payment_loan_30_59_days',
                     'number_times_delayed_payment_loan_60_89_days',
                     'more_90_days_overdue')
),

base AS (
  SELECT
    user_id,
    default_flag,
    age,
    last_month_salary,
    total_emprestimos,
    qtd_real_estate,
    qtd_others,
    number_times_delayed_payment_loan_30_59_days AS atraso_30_59,
    number_times_delayed_payment_loan_60_89_days AS atraso_60_89,
    more_90_days_overdue AS atraso_90_plus
  FROM `lab025-p003.new_data.dt_complete_ok`
),

-- aplica os quartis e gera score
categorizado AS (
  SELECT
    b.user_id,
    b.default_flag,

    -- idade
    CASE
      WHEN age <= (SELECT q1 FROM quartis WHERE var_name='age') THEN 1
      WHEN age <= (SELECT q2 FROM quartis WHERE var_name='age') THEN 2
      WHEN age <= (SELECT q3 FROM quartis WHERE var_name='age') THEN 3
      ELSE 4 END AS score_age,

    -- salário
    CASE
      WHEN last_month_salary <= (SELECT q1 FROM quartis WHERE var_name='last_month_salary') THEN 1
      WHEN last_month_salary <= (SELECT q2 FROM quartis WHERE var_name='last_month_salary') THEN 2
      WHEN last_month_salary <= (SELECT q3 FROM quartis WHERE var_name='last_month_salary') THEN 3
      ELSE 4 END AS score_salary,

    -- empréstimos
    CASE
      WHEN total_emprestimos <= (SELECT q1 FROM quartis WHERE var_name='total_emprestimos') THEN 1
      WHEN total_emprestimos <= (SELECT q2 FROM quartis WHERE var_name='total_emprestimos') THEN 2
      WHEN total_emprestimos <= (SELECT q3 FROM quartis WHERE var_name='total_emprestimos') THEN 3
      ELSE 4 END AS score_emprestimos,

    -- atrasos 30-59
    CASE
      WHEN atraso_30_59 <= (SELECT q1 FROM quartis WHERE var_name='number_times_delayed_payment_loan_30_59_days') THEN 1
      WHEN atraso_30_59 <= (SELECT q2 FROM quartis WHERE var_name='number_times_delayed_payment_loan_30_59_days') THEN 2
      WHEN atraso_30_59 <= (SELECT q3 FROM quartis WHERE var_name='number_times_delayed_payment_loan_30_59_days') THEN 3
      ELSE 4 END AS score_atraso_30_59,

    -- atrasos 60-89
    CASE
      WHEN atraso_60_89 <= (SELECT q1 FROM quartis WHERE var_name='number_times_delayed_payment_loan_60_89_days') THEN 1
      WHEN atraso_60_89 <= (SELECT q2 FROM quartis WHERE var_name='number_times_delayed_payment_loan_60_89_days') THEN 2
      WHEN atraso_60_89 <= (SELECT q3 FROM quartis WHERE var_name='number_times_delayed_payment_loan_60_89_days') THEN 3
      ELSE 4 END AS score_atraso_60_89,

    -- atrasos 90+
    CASE
      WHEN atraso_90_plus <= (SELECT q1 FROM quartis WHERE var_name='more_90_days_overdue') THEN 1
      WHEN atraso_90_plus <= (SELECT q2 FROM quartis WHERE var_name='more_90_days_overdue') THEN 2
      WHEN atraso_90_plus <= (SELECT q3 FROM quartis WHERE var_name='more_90_days_overdue') THEN 3
      ELSE 4 END AS score_atraso_90_plus

  FROM base b
)

SELECT
  user_id,
  default_flag,
  score_age,
  score_salary,
  score_emprestimos,
  score_atraso_30_59,
  score_atraso_60_89,
  score_atraso_90_plus,
  (score_age + score_salary + score_emprestimos +
   score_atraso_30_59 + score_atraso_60_89 + score_atraso_90_plus) AS score_risco
FROM categorizado;

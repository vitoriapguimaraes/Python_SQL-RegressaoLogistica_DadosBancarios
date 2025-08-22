CREATE OR REPLACE TABLE `lab025-p003.new_data.dt_bins_auto` AS
WITH stats AS (
  SELECT
    -- calcula min e max de cada variável
    MIN(age) AS min_age, MAX(age) AS max_age,
    MIN(last_month_salary) AS min_salary, MAX(last_month_salary) AS max_salary,
    MIN(debt_ratio) AS min_debt_ratio, MAX(debt_ratio) AS max_debt_ratio,
    MIN(more_90_days_overdue) AS min_overdue90, MAX(more_90_days_overdue) AS max_overdue90,
    MIN(number_times_delayed_payment_loan_30_59_days) AS min_delay30_59, MAX(number_times_delayed_payment_loan_30_59_days) AS max_delay30_59,
    MIN(number_times_delayed_payment_loan_60_89_days) AS min_delay60_89, MAX(number_times_delayed_payment_loan_60_89_days) AS max_delay60_89,
    MIN(total_emprestimos) AS min_total, MAX(total_emprestimos) AS max_total,
    MIN(qtd_real_estate) AS min_real, MAX(qtd_real_estate) AS max_real,
    MIN(qtd_others) AS min_others, MAX(qtd_others) AS max_others
  FROM `lab025-p003.new_data.dt_complete_ok`
),

base AS (
  SELECT a.*, s.*
  FROM `lab025-p003.new_data.dt_complete_ok` a
  CROSS JOIN stats s
)

SELECT
  user_id,

  -- Idade
  CONCAT(
    CAST(FLOOR((age - min_age) / ((max_age - min_age) / 15)) * ((max_age - min_age) / 15) + min_age AS INT64),
    ' - ',
    CAST(FLOOR((age - min_age) / ((max_age - min_age) / 15)) * ((max_age - min_age) / 15) + min_age + ((max_age - min_age) / 15) - 1 AS INT64)
  ) AS age_bin,

  -- Salário
  CONCAT(
    CAST(FLOOR((last_month_salary - min_salary) / ((max_salary - min_salary) / 15)) * ((max_salary - min_salary) / 15) + min_salary AS INT64),
    ' - ',
    CAST(FLOOR((last_month_salary - min_salary) / ((max_salary - min_salary) / 15)) * ((max_salary - min_salary) / 15) + min_salary + ((max_salary - min_salary) / 15) - 1 AS INT64)
  ) AS salary_bin,

  -- Debt Ratio
  CONCAT(
    CAST(FLOOR((debt_ratio - min_debt_ratio) / ((max_debt_ratio - min_debt_ratio) / 15)) * ((max_debt_ratio - min_debt_ratio) / 15) + min_debt_ratio AS FLOAT64),
    ' - ',
    CAST(FLOOR((debt_ratio - min_debt_ratio) / ((max_debt_ratio - min_debt_ratio) / 15)) * ((max_debt_ratio - min_debt_ratio) / 15) + min_debt_ratio + ((max_debt_ratio - min_debt_ratio) / 15) AS FLOAT64)
  ) AS debt_ratio_bin,

  -- Overdue 90
  CONCAT(
    CAST(FLOOR((more_90_days_overdue - min_overdue90) / ((max_overdue90 - min_overdue90) / 15)) * ((max_overdue90 - min_overdue90) / 15) + min_overdue90 AS INT64),
    ' - ',
    CAST(FLOOR((more_90_days_overdue - min_overdue90) / ((max_overdue90 - min_overdue90) / 15)) * ((max_overdue90 - min_overdue90) / 15) + min_overdue90 + ((max_overdue90 - min_overdue90) / 15) - 1 AS INT64)
  ) AS overdue90_bin,

  -- Delay 30-59
  CONCAT(
    CAST(FLOOR((number_times_delayed_payment_loan_30_59_days - min_delay30_59) / ((max_delay30_59 - min_delay30_59) / 15)) * ((max_delay30_59 - min_delay30_59) / 15) + min_delay30_59 AS INT64),
    ' - ',
    CAST(FLOOR((number_times_delayed_payment_loan_30_59_days - min_delay30_59) / ((max_delay30_59 - min_delay30_59) / 15)) * ((max_delay30_59 - min_delay30_59) / 15) + min_delay30_59 + ((max_delay30_59 - min_delay30_59) / 15) - 1 AS INT64)
  ) AS delay30_59_bin,

  -- Delay 60-89
  CONCAT(
    CAST(FLOOR((number_times_delayed_payment_loan_60_89_days - min_delay60_89) / ((max_delay60_89 - min_delay60_89) / 15)) * ((max_delay60_89 - min_delay60_89) / 15) + min_delay60_89 AS INT64),
    ' - ',
    CAST(FLOOR((number_times_delayed_payment_loan_60_89_days - min_delay60_89) / ((max_delay60_89 - min_delay60_89) / 15)) * ((max_delay60_89 - min_delay60_89) / 15) + min_delay60_89 + ((max_delay60_89 - min_delay60_89) / 15) - 1 AS INT64)
  ) AS delay60_89_bin,

  -- Total empréstimos
  CONCAT(
    CAST(FLOOR((total_emprestimos - min_total) / ((max_total - min_total) / 15)) * ((max_total - min_total) / 15) + min_total AS INT64),
    ' - ',
    CAST(FLOOR((total_emprestimos - min_total) / ((max_total - min_total) / 15)) * ((max_total - min_total) / 15) + min_total + ((max_total - min_total) / 15) - 1 AS INT64)
  ) AS total_loans_bin,

  -- Empréstimos Real Estate
  CONCAT(
    CAST(FLOOR((qtd_real_estate - min_real) / ((max_real - min_real) / 15)) * ((max_real - min_real) / 15) + min_real AS INT64),
    ' - ',
    CAST(FLOOR((qtd_real_estate - min_real) / ((max_real - min_real) / 15)) * ((max_real - min_real) / 15) + min_real + ((max_real - min_real) / 15) - 1 AS INT64)
  ) AS real_estate_bin,

  -- Empréstimos Others
  CONCAT(
    CAST(FLOOR((qtd_others - min_others) / ((max_others - min_others) / 15)) * ((max_others - min_others) / 15) + min_others AS INT64),
    ' - ',
    CAST(FLOOR((qtd_others - min_others) / ((max_others - min_others) / 15)) * ((max_others - min_others) / 15) + min_others + ((max_others - min_others) / 15) - 1 AS INT64)
  ) AS others_bin

FROM base;

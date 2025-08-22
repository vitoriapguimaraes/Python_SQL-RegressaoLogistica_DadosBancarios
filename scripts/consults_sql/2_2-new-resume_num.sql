CREATE OR REPLACE TABLE `lab025-p003.new_data.stats_summary` AS
WITH base AS (
  SELECT
    user_id,
    CAST(more_90_days_overdue AS FLOAT64) AS more_90_days_overdue,
    CAST(using_lines_not_secured_personal_assets AS FLOAT64) AS using_lines_not_secured_personal_assets,
    CAST(number_times_delayed_payment_loan_30_59_days AS FLOAT64) AS number_times_delayed_payment_loan_30_59_days,
    CAST(debt_ratio AS FLOAT64) AS debt_ratio,
    CAST(number_times_delayed_payment_loan_60_89_days AS FLOAT64) AS number_times_delayed_payment_loan_60_89_days,
    CAST(total_emprestimos AS FLOAT64) AS total_emprestimos,
    CAST(qtd_real_estate AS FLOAT64) AS qtd_real_estate,
    CAST(qtd_others AS FLOAT64) AS qtd_others,
    CAST(perc_real_estate AS FLOAT64) AS perc_real_estate,
    CAST(perc_others AS FLOAT64) AS perc_others,
    CAST(age AS FLOAT64) AS age,
    CAST(sex_num AS FLOAT64) AS sex_num,
    CAST(last_month_salary AS FLOAT64) AS last_month_salary,
    CAST(number_dependents AS FLOAT64) AS number_dependents
  FROM `lab025-p003.new_data.dt_complete_ok`
),

-- 🔹 Transformar todas em colunas chave-valor
unpivoted AS (
  SELECT var_name, var_value
  FROM base
  UNPIVOT(var_value FOR var_name IN (
    more_90_days_overdue,
    using_lines_not_secured_personal_assets,
    number_times_delayed_payment_loan_30_59_days,
    debt_ratio,
    number_times_delayed_payment_loan_60_89_days,
    total_emprestimos,
    qtd_real_estate,
    qtd_others,
    perc_real_estate,
    perc_others,
    age,
    sex_num,
    last_month_salary,
    number_dependents
  ))
),

-- 🔹 Moda (valor mais frequente)
modes AS (
  SELECT
    var_name,
    var_value AS moda,
    ROW_NUMBER() OVER (PARTITION BY var_name ORDER BY COUNT(*) DESC) AS rk
  FROM unpivoted
  GROUP BY var_name, var_value
)

-- 🔹 Estatísticas finais
SELECT
  var_name,
  MIN(var_value) AS min_val,
  MAX(var_value) AS max_val,
  AVG(var_value) AS media,
  STDDEV(var_value) AS desvio_padrao,
  VARIANCE(var_value) AS variancia,

  -- Quartis com APPROX_QUANTILES
  APPROX_QUANTILES(var_value, 4)[OFFSET(1)] AS q1,       -- 25%
  APPROX_QUANTILES(var_value, 4)[OFFSET(2)] AS q2,       -- 50% (mediana)
  APPROX_QUANTILES(var_value, 4)[OFFSET(3)] AS q3,       -- 75%

  APPROX_QUANTILES(var_value, 100)[OFFSET(50)] AS mediana,  -- mantemos também a versão detalhada
  (SELECT moda FROM modes m WHERE m.var_name = u.var_name AND rk = 1) AS moda

FROM unpivoted u
GROUP BY var_name
ORDER BY var_name;

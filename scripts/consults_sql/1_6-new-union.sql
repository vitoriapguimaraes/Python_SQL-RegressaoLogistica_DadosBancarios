CREATE OR REPLACE TABLE `lab025-p003.new_data.dataset_complete` AS

WITH base AS (
  SELECT
    u.user_id,

    -- user_info
    CASE 
      WHEN u.age > 90 THEN NULL   -- marcamos para filtrar depois
      ELSE u.age 
    END AS age,
    CASE WHEN u.sex = 'F' THEN 1 WHEN u.sex = 'M' THEN 0 END AS sex_num,
    u.last_month_salary,
    IFNULL(u.number_dependents, 0) AS number_dependents,   -- dependentes nulos => 0

    -- loans_outstanding_features (tratando nulos como 0)
    IFNULL(f.total_emprestimos, 0) AS total_emprestimos,
    IFNULL(f.qtd_real_estate, 0) AS qtd_real_estate,
    IFNULL(f.qtd_others, 0) AS qtd_others,
    IFNULL(f.perc_real_estate, 0) AS perc_real_estate,
    IFNULL(f.perc_others, 0) AS perc_others,

    -- loans_detail
    d.more_90_days_overdue,
    d.using_lines_not_secured_personal_assets,
    d.number_times_delayed_payment_loan_30_59_days,
    d.debt_ratio,
    d.number_times_delayed_payment_loan_60_89_days,

    -- default
    df.default_flag

  FROM `lab025-p003.dataset.user_info` u
  LEFT JOIN `lab025-p003.new_data.loans_outstanding_features` f
    ON u.user_id = f.user_id
  LEFT JOIN `lab025-p003.dataset.loans_detail` d
    ON u.user_id = d.user_id
  LEFT JOIN `lab025-p003.dataset.defaut` df
    ON u.user_id = df.user_id
)

-- remove linhas com idade inválida e o user_id indesejado
SELECT *
FROM base
WHERE age IS NOT NULL
  AND user_id != 21096;
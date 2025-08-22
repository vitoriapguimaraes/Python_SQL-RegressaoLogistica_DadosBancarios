DECLARE cols ARRAY<STRING>;
DECLARE sql STRING;

-- lista de variáveis numéricas em dt_complete_ok
SET cols = [
  'more_90_days_overdue','using_lines_not_secured_personal_assets',
  'number_times_delayed_payment_loan_30_59_days','debt_ratio',
  'number_times_delayed_payment_loan_60_89_days','total_emprestimos',
  'qtd_real_estate','qtd_others','perc_real_estate','perc_others',
  'age','sex_num','last_month_salary','number_dependents'
];

-- monta dinamicamente os pares de correlação
SET sql = (
  SELECT STRING_AGG(FORMAT("""
    SELECT '%s' AS var1, '%s' AS var2,
           CORR(%s, %s) AS correlacao
    FROM `lab025-p003.new_data.dt_complete_ok`
  """, c1, c2, c1, c2), " UNION ALL ")
  FROM UNNEST(cols) c1, UNNEST(cols) c2
);

-- executa o SQL gerado
EXECUTE IMMEDIATE sql;

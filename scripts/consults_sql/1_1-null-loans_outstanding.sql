SELECT 
  COUNT(*) AS linhas_totais,
  COUNTIF(loan_id IS NULL) AS loan_id_NULL,
  COUNTIF(user_id IS NULL) AS user_id_NULL,
  COUNTIF(loan_type IS NULL) AS loan_type_NULL
FROM `lab025-p003.dataset.loans_outstanding`
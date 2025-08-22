SELECT 
  loan_id, user_id, loan_type,
  COUNT(*) AS quant_freq
FROM `lab025-p003.dataset.loans_outstanding`
GROUP BY
  loan_id, user_id, loan_type
HAVING COUNT(*) > 1;
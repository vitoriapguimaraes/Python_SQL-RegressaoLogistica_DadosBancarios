SELECT 
  user_id, default_flag,
  COUNT (*) AS quant_freq
FROM `lab025-p003.dataset.defaut`
GROUP BY
  user_id, default_flag
HAVING COUNT(*) > 1;
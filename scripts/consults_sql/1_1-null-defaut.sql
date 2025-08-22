SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(user_id IS NULL) AS user_id_null,
  COUNTIF(default_flag IS NULL) as default_flag_null
FROM `lab025-p003.dataset.defaut`
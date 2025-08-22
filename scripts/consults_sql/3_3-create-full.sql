CREATE OR REPLACE TABLE `lab025-p003.new_data.dt_full_seg` AS
SELECT 
  a.*,
  b.score_risco
FROM `lab025-p003.new_data.dt_full_analysis` a
  JOIN `lab025-p003.new_data.clientes_score` b ON a.user_id = b.user_id
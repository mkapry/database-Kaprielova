WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
        UNION ALL
	SELECT dt + INTERVAL 7 DAY
      FROM cte
     WHERE dt + INTERVAL 7 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
)
SELECT cte.dt, COUNT(DISTINCT user_id) AS WAU
  FROM cte LEFT JOIN sessions ON cte.dt <= CAST(begin_dttm AS DATE) AND cte.dt + INTERVAL 6 DAY >= CAST(begin_dttm AS DATE)
 GROUP BY cte.dt
 ORDER BY cte.dt;
 
 
WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(payment_dttm AS DATE)) AS dt FROM payments
        UNION ALL
	SELECT cte.dt + INTERVAL 1 DAY
	  FROM cte
	WHERE cte.dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(payment_dttm AS DATE)) AS dt FROM payments)
),
pu_for_day AS
(
    SELECT CAST(payment_dttm AS DATE) AS dt,
           COUNT(DISTINCT user_id) as user_pay
      FROM payments
     GROUP BY dt
),
dau_for_day AS
(
    SELECT CAST(begin_dttm AS DATE) AS dt,
           COUNT(DISTINCT user_id) as user_all
      FROM sessions
     GROUP BY dt
)
SELECT cte.dt, COALESCE(pu.user_pay, 0) / COALESCE(dau.user_all, 1) as ppu
FROM cte
  LEFT JOIN pu_for_day AS pu ON cte.dt = pu.dt
  LEFT JOIN dau_for_day AS dau ON cte.dt = dau.dt;
  
  
  
  WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(payment_dttm AS DATE)) AS dt FROM payments
        UNION ALL
	SELECT cte.dt + INTERVAL 1 DAY
	  FROM cte
	WHERE cte.dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(payment_dttm AS DATE)) AS dt FROM payments)
),
pay AS
(
    SELECT CAST(payment_dttm AS DATE) AS dt,
           SUM(payment_sum) as pay_sum
      FROM payments
     GROUP BY dt
),
coun AS
(
    SELECT CAST(payment_dttm AS DATE) AS dt,
           COUNT(DISTINCT user_id) as user_pay
      FROM payments
     GROUP BY dt
)
SELECT cte.dt, COALESCE(pay.pay_sum, 0) / COALESCE(pu.user_pay, 1) as arppu
FROM cte
  LEFT JOIN pay ON cte.dt = pay.dt
  LEFT JOIN coun ON cte.dt = coun.dt;
  
  
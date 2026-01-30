SELECT payer,
       COUNT(*) AS total_requests,
       SUM(CASE WHEN status = 'Denied' THEN 1 ELSE 0 END) AS total_denials,
       ROUND(SUM(CASE WHEN status = 'Denied' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS denial_rate
FROM authorizations
GROUP BY payer
ORDER BY denial_rate DESC;
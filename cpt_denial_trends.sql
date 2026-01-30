SELECT cpt_code,
       COUNT(*) AS total_requests,
       SUM(CASE WHEN status = 'Denied' THEN 1 ELSE 0 END) AS denials
FROM authorizations
GROUP BY cpt_code
HAVING COUNT(*) > 10
ORDER BY denials DESC;
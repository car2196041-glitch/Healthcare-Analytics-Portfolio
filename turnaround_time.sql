SELECT payer,
       AVG(days_to_decision) AS avg_turnaround_days
FROM authorizations
GROUP BY payer
ORDER BY avg_turnaround_days DESC;
-- Create a temporary table for competitors who have participated
-- in more than three Olympic Games but have not won any medals

DROP TABLE IF EXISTS temp_no_medal_competitors;

CREATE TEMP TABLE temp_no_medal_competitors AS
SELECT p.full_name, COUNT(DISTINCT ce.event_id) AS games_participated

FROM olympics.person p 

JOIN (olympics.games g  
JOIN (olympics.medal m  
JOIN (olympics.games_competitor gc  
JOIN olympics.competitor_event ce 
ON gc.id=ce.competitor_id) 
ON m.id=ce.medal_id) 
ON g.id=gc.games_id) 
ON p.id=gc.person_id

WHERE m.medal_name = 'NA'
GROUP BY gc.person_id, ce.medal_id, m.medal_name, p.full_name
HAVING COUNT(ce.event_id) > 3;

-- Display the contents of the temporary table
SELECT *
FROM temp_no_medal_competitors
ORDER BY games_participated DESC, full_name;
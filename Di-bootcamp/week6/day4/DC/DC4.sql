-- Drop the temp table if it already exists
DROP TABLE IF EXISTS temp_no_medal_competitors;

-- Create a temporary table for competitors who:
-- 1) Participated in more than 3 Olympic sport
-- 2) Have not won any medals

CREATE TEMP TABLE temp_no_medal_competitors AS
SELECT
    p.id,
    p.full_name,
    COUNT(DISTINCT s.id) AS sport_participated_no_medal
FROM olympics.person AS p 
JOIN olympics.games_competitor AS ge  ON ge.person_id=p.id
JOIN olympics.competitor_event AS ce  ON ce.competitor_id=ge.id
JOIN olympics.event AS e			  ON ce.event_id = e.id
JOIN olympics.sport AS s			  ON e.sport_id = s.id
LEFT JOIN olympics.medal AS m		  ON ce.medal_id = m.id
-- Exclude cases where a real medal was awarded (Gold, Silver, Bronze)
WHERE m.medal_name = 'NA'

GROUP BY p.id, p.full_name
HAVING COUNT(DISTINCT s.id) > 3 --DISTINCT counts only different  games — without repetitions.
	-- so we get a contestant with more than 3 different sports

	-- returns 1 and more if it's a real medal
   AND SUM(CASE WHEN m.medal_name IN ('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) = 0
   ;

-- Display the contents of the temporary table
SELECT *
FROM temp_no_medal_competitors
ORDER BY sport_participated_no_medal DESC, full_name;

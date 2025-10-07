-- #1
-- Step 1: Create a temporary table for competitors who have at least one medal in both seasons.
DROP TABLE IF EXISTS temp_medal_season;

CREATE TEMP TABLE temp_medal_season AS
SELECT p.full_name, count(m.id) AS medals_qty, g.season

from olympics.games g 
JOIN (olympics.medal m 
JOIN (olympics.person p 
JOIN (olympics.games_competitor gc 
JOIN olympics.competitor_event ce 
ON gc.id=ce.competitor_id)
ON p.id=gc.person_id) 
ON m.id=ce.medal_id) 
ON g.id=gc.games_id

WHERE m.medal_name<>'NA'

group BY p.full_name,g.season ;

SELECT * FROM temp_medal_season;

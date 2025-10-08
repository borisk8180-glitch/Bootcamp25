-- Drop the temp table if it already exists
DROP TABLE IF EXISTS temp_dual_season_medalists;

-- Create a temporary table for competitors who have won medals
-- in both Summer and Winter Olympic Games
CREATE TEMP TABLE temp_dual_season_medalists AS
SELECT
    p.id,
    p.full_name,
 	-- After grouping, each aggregate function is performed separately for each group.
    -- So we can count medals for each p.id separately for each season
    SUM(CASE WHEN g.season = 'Summer' THEN 1 ELSE 0 END) AS summer_medals,
    SUM(CASE WHEN g.season = 'Winter' THEN 1 ELSE 0 END) AS winter_medals,
    
    -- Total medal count
    COUNT(m.id) AS total_medals
-- ===========================================
-- join the tables
FROM olympics.person AS p
JOIN olympics.games_competitor gc ON p.id = gc.person_id
JOIN olympics.competitor_event ce ON gc.id = ce.competitor_id
JOIN olympics.games AS g		  ON g.id = gc.games_id
JOIN olympics.medal AS m		  ON ce.medal_id = m.id 
-- exclude records without medals
AND m.medal_name <> 'NA'

-- Aggregate
-- Grouping by competitor
GROUP BY p.id, p.full_name

-- Keep only those who have at least one medal in both seasons
HAVING
    SUM(CASE WHEN g.season = 'Summer' THEN 1 ELSE 0 END) > 0
    AND
    SUM(CASE WHEN g.season = 'Winter' THEN 1 ELSE 0 END) > 0;

-- Display the temporary table contents
SELECT *
FROM temp_dual_season_medalists
ORDER BY total_medals DESC;

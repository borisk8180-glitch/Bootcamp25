-- #1
-- Step 1: Create a temporary table for competitors who have at least one medal in both seasons.
-- Drop the temp table if it already exists
DROP TABLE IF EXISTS temp_dual_season_medalists;

-- Create a temporary table for competitors who have won medals
-- in both Summer and Winter Olympic Games
CREATE TEMP TABLE temp_dual_season_medalists AS
SELECT
    p.id,
    p.full_name,
    
    -- Count medals separately for each season
    SUM(CASE WHEN g.season = 'Summer' THEN 1 ELSE 0 END) AS summer_medals,
    SUM(CASE WHEN g.season = 'Winter' THEN 1 ELSE 0 END) AS winter_medals,
    
    -- Total medal count
    COUNT(m.id) AS total_medals

FROM olympics.person AS p
JOIN olympics.games_competitor gc
ON p.id = gc.person_id
JOIN olympics.competitor_event ce
    ON gc.id = ce.competitor_id
JOIN olympics.games AS g
    ON g.id = gc.games_id
JOIN olympics.medal AS m
    ON ce.medal_id = m.id AND m.medal_name <> 'NA'

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

-- #2

-- 1. Create a temporary table for competitors 
--    who have won medals in exactly two different sports
DROP TABLE IF EXISTS competitors_two_sports;

CREATE TEMP TABLE competitors_two_sports AS
SELECT 
    gc.person_id,
    p.full_name,
    COUNT(DISTINCT ce.event_id) AS num_sports,
    COUNT(ce.medal_id) AS total_medals
-- tables to select from 
FROM olympics.games_competitor gc
JOIN olympics.competitor_event ce 
    ON gc.id = ce.competitor_id
JOIN olympics.medal m 
    ON ce.medal_id = m.id
JOIN olympics.person p 
    ON gc.person_id = p.id
-- aggregate
GROUP BY gc.person_id, p.full_name
HAVING COUNT(DISTINCT ce.event_id) = 2; --2 different sports


-- 2. Create new temp table to find the top 3 competitors 
--    with the highest total number of medals across all sports
DROP TABLE IF EXISTS top3_competitors;

CREATE TEMP TABLE top3_competitors AS
SELECT *
FROM competitors_two_sports
ORDER BY total_medals DESC
LIMIT 3;


-- 3. Display the contents of the final temporary table

SELECT * FROM top3_competitors;

-- #3

WITH 
competitor_event_counts AS (
  -- count the medals for each contestant (competitor_id, event_id)
  SELECT competitor_id, event_id, COUNT(medal_id) AS medals_in_event
  FROM olympics.competitor_event
  WHERE medal_id IS NOT NULL
  GROUP BY competitor_id, event_id
  ORDER BY competitor_id
),
competitor_max AS (
  -- take a maximum of events for each contestant.
  SELECT competitor_id, MAX(medals_in_event) AS max_medals
  FROM competitor_event_counts
  GROUP BY competitor_id
),
competitor_top_event AS (
  -- select those (competitor,event) where the number of medals = the maximum of the contestant
  SELECT cec.competitor_id, cec.event_id, cec.medals_in_event
  FROM competitor_event_counts cec
  JOIN competitor_max cm
    ON cec.competitor_id = cm.competitor_id
   AND cec.medals_in_event = cm.max_medals
)
-- SELECT * FROM competitor_top_event
,
competitor_with_person AS (
  SELECT gc.id AS competitor_id, gc.person_id, gc.games_id
  FROM olympics.games_competitor gc
),
region_medal_totals AS (
  SELECT pr.region_id, SUM(cte.medals_in_event) AS total_medals
  FROM competitor_top_event cte
  JOIN competitor_with_person cwp ON cte.competitor_id = cwp.competitor_id
  JOIN olympics.person_region pr ON pr.person_id = cwp.person_id
  GROUP BY pr.region_id
)
SELECT r.region_name, rmt.total_medals
FROM region_medal_totals rmt
JOIN olympics.noc_region r ON r.id = rmt.region_id
ORDER BY rmt.total_medals DESC
LIMIT 5;

-- #4

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

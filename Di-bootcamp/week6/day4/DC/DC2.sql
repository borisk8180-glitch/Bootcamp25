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

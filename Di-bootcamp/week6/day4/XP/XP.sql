-- #1
SELECT 
ROUND(avg(gc.age)) AS avg_age, 
m.medal_name

FROM
olympics.medal m 
INNER JOIN (olympics.games_competitor gc 
INNER JOIN olympics.competitor_event ce
ON gc.id=ce.competitor_id) 
ON m.id=ce.medal_id
WHERE m.medal_name <> 'NA'

group BY 
m.medal_name;


SELECT nr.region_name, COUNT(DISTINCT pr.person_id) AS unique_competitors
FROM olympics.noc_region nr
JOIN olympics.person_region pr ON nr.id = pr.region_id
WHERE pr.person_id IN (
    -- Subquery: competitors with more than 3 distinct events
    SELECT ce.competitor_id
    FROM ce ce
    GROUP BY ce.competitor_id
    HAVING COUNT(DISTINCT ce.event_id) > 3
)
GROUP BY nr.region_name
ORDER BY unique_competitors DESC
LIMIT 5;


CREATE TEMP TABLE temp_medal_count AS
SELECT ce.competitor_id,
       COUNT(ce.medal_id) AS total_medals
FROM ce ce
WHERE ce.medal_id IS NOT NULL
GROUP BY ce.competitor_id;


DELETE FROM temp_medal_count
WHERE competitor_id IN (
    SELECT competitor_id
    FROM temp_medal_count
    WHERE total_medals = 0
);

-- #2

UPDATE olympics.person p
SET height = (
    SELECT AVG(p2.height)
    FROM olympics.person p2
    JOIN olympics.person_region pr2 ON p2.id = pr2.person_id
    JOIN olympics.person_region pr1 ON pr1.region_id = pr2.region_id
    WHERE pr1.person_id = p.id
);

CREATE TEMP TABLE temp_multievent AS
SELECT gc.id AS competitor_id,
       gc.games_id,
       COUNT(ce.event_id) AS total_events
FROM gc gc
JOIN ce ce ON gc.id = ce.competitor_id
GROUP BY gc.id, gc.games_id
HAVING COUNT(ce.event_id) > 1;

SELECT nr.region_name
FROM olympics.noc_region nr
JOIN olympics.person_region pr ON nr.id = pr.region_id
JOIN gc gc ON pr.person_id = gc.person_id
JOIN ce ce ON gc.id = ce.competitor_id
WHERE ce.medal_id IS NOT NULL
GROUP BY nr.id, nr.region_name
HAVING AVG(1) > (
    SELECT AVG(medals_per_competitor) FROM (
        SELECT COUNT(ce2.medal_id) AS medals_per_competitor
        FROM gc gc2
        JOIN ce ce2 ON gc2.id = ce2.competitor_id
        WHERE ce2.medal_id IS NOT NULL
        GROUP BY gc2.id
    ) AS overall_avg
);

CREATE TEMP TABLE temp_season_participation AS
SELECT gc.person_id,
       g.season
FROM gc gc
JOIN olympics.games g ON gc.games_id = g.id
GROUP BY gc.person_id, g.season;

SELECT person_id
FROM temp_season_participation
GROUP BY person_id
HAVING COUNT(DISTINCT season) = 2;  -- both Summer and Winter

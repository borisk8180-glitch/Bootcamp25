WITH 
competitor_event_counts AS (
  -- count the medals for each contestant (competitor_id, event_id)
  SELECT competitor_id, event_id, COUNT(medal_id) AS medals_in_event
  
  FROM olympics.competitor_event ce
  JOIN olympics.medal AS m		  ON ce.medal_id = m.id 
  -- exclude records without medals
  AND m.medal_name <> 'NA'
  
-- Aggregate
  GROUP BY competitor_id, event_id
  ORDER BY competitor_id
),

competitor_max AS (
  -- take a maximum of medals for each event of each contestant.
  SELECT competitor_id, MAX(medals_in_event) AS max_medals
  
  FROM competitor_event_counts
  GROUP BY competitor_id
),

competitor_top_event AS (
  -- select those (competitor,event) where the number of medals = the maximum of the contestant
  SELECT cec.competitor_id, cec.event_id, cec.medals_in_event
  
  FROM competitor_event_counts cec --counted amount of medals for each event 
  JOIN competitor_max cm    ON cec.competitor_id = cm.competitor_id --counted max medals for each event
   AND cec.medals_in_event = cm.max_medals
)
-- SELECT * FROM competitor_top_event
,
competitor_with_person AS ( --get necessary fields from games_competitor
  SELECT gc.id AS competitor_id, gc.person_id, gc.games_id 
  FROM olympics.games_competitor gc
),
region_medal_totals AS ( --get list of regions that have contestants with top records
  SELECT pr.region_id, SUM(cte.medals_in_event) AS total_medals
  FROM competitor_top_event cte
  JOIN competitor_with_person cwp ON cte.competitor_id = cwp.competitor_id
  JOIN olympics.person_region pr ON pr.person_id = cwp.person_id
  GROUP BY pr.region_id
)
SELECT r.region_name, rmt.total_medals --get 5 region names and sort by amount of medals
FROM region_medal_totals rmt
JOIN olympics.noc_region r ON r.id = rmt.region_id
ORDER BY rmt.total_medals DESC
LIMIT 5;

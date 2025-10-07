SELECT olympics.noc_region.region_name,
olympics.competitor_event.competitor_id,
olympics.max(competitor_event.medal_id) AS max_medal_id,
olympics.games_competitor.games_id, olympics.event.event_name
from event  JOIN
((person  JOIN (games_competitor  JOIN competitor_event ON
olympics.games_competitor.id= olympics.competitor_event.competitor_id) ON
olympics.person.id= olympics.games_competitor.person_id)  JOIN (noc_region
JOIN person_region ON olympics.noc_region.id= olympics.person_region.region_id)
ON olympics.person.id= olympics.person_region.person_id) ON olympics.event.id=
olympics.competitor_event.event_id
group BY olympics.noc_region.region_name,
olympics.competitor_event.competitor_id, olympics.games_competitor.games_id,
olympics.event.event_name, olympics.competitor_event.event_id
having
olympics.(((competitor_event.event_id) in (select
olympics.competitor_event.event_id FROM competitor_event GROUP BY
olympics.competitor_event.event_id;)));


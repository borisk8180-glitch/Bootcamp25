SELECT olympics.person.full_name, olympics.medal.medal_name,
olympics.sport.sport_name

FROM sport  
JOIN (event  
JOIN (person  
JOIN
(medal  
JOIN (games_competitor  
JOIN competitor_event ON
olympics.games_competitor.id= olympics.competitor_event.competitor_id) ON
olympics.medal.id= olympics.competitor_event.medal_id) ON olympics.person.id=
olympics.games_competitor.person_id) ON olympics.event.id=
olympics.competitor_event.event_id) ON olympics.sport.id=
olympics.event.sport_id
group BY olympics.person.full_name,
olympics.medal.medal_name, olympics.sport.sport_name;


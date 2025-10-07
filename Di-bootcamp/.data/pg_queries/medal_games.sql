SELECT olympics.games.games_name, olympics.games_competitor.person_id,
olympics.competitor_event.medal_id, olympics.medal.medal_name,
olympics.person.id

FROM person  
JOIN (games  
JOIN (medal  
JOIN
(games_competitor  
JOIN competitor_event ON olympics.games_competitor.id=
olympics.competitor_event.competitor_id) ON olympics.medal.id=
olympics.competitor_event.medal_id) ON olympics.games.id=
olympics.games_competitor.games_id) ON olympics.person.id=
olympics.games_competitor.person_id;


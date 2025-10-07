SELECT olympics.competitor_event.competitor_id, olympics.person.full_name,
olympics.count(games_competitor.games_id) AS count_games_id,
olympics.medal.medal_name

FROM medal  
JOIN (person  
JOIN
(games_competitor  
JOIN competitor_event ON olympics.games_competitor.id=
olympics.competitor_event.competitor_id) ON olympics.person.id=
olympics.games_competitor.person_id) ON olympics.medal.id=
olympics.competitor_event.medal_id
group BY
olympics.competitor_event.competitor_id, olympics.person.full_name,
olympics.medal.medal_name;


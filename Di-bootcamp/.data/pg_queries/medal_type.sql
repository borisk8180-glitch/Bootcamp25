SELECT olympics.avg(games_competitor.age) AS avg_age,
olympics.medal.medal_name, olympics.games_competitor.id

FROM medal  
JOIN
(games_competitor  
JOIN competitor_event ON olympics.games_competitor.id=
olympics.competitor_event.competitor_id) ON olympics.medal.id=
olympics.competitor_event.medal_id
group BY olympics.medal.medal_name,
olympics.games_competitor.id
having olympics.(((games_competitor.id) in
(select olympics.competitor_event.medal_id 
FROM competitor_event WHERE
olympics.(((competitor_event.competitor_id)>0));)));


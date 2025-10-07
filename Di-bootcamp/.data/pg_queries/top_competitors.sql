SELECT olympics.count(competitor_event.medal_id) AS count_medal_id,
olympics.competitor_event.competitor_id

FROM games_competitor  
JOIN
competitor_event ON olympics.games_competitor.id=
olympics.competitor_event.competitor_id
group BY
olympics.competitor_event.competitor_id
order BY
olympics.count(competitor_event.medal_id) desc;


SELECT avg(games_competitor.age) AS [avg-age, medal.medal_name,
games_competitor._id
from medal INNER JOIN (games_competitor INNER JOIN
competitor_event ON games_competitor._id=competitor_event.competitor_id) ON
medal._id=competitor_event.medal_id
group BY medal.medal_name,
games_competitor._id
having (((games_competitor._id) in (select
competitor_event.medal_id FROM competitor_event WHERE
(((competitor_event.competitor_id)>0));)));


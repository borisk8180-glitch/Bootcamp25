SELECT olympics.person.full_name, olympics.count(medal.id) AS count_id,
olympics.games.season
from games  JOIN (medal  JOIN (person  JOIN
(games_competitor  JOIN competitor_event ON olympics.games_competitor.id=
olympics.competitor_event.competitor_id) ON olympics.person.id=
olympics.games_competitor.person_id) ON olympics.medal.id=
olympics.competitor_event.medal_id) ON olympics.games.id=
olympics.games_competitor.games_id
group BY olympics.person.full_name,
olympics.games.season
having olympics.(((count(medal.id))>0));


SELECT olympics.games_competitor.person_id, olympics.person.full_name

FROM
person  
JOIN games_competitor ON olympics.person.id=
olympics.games_competitor.person_id;


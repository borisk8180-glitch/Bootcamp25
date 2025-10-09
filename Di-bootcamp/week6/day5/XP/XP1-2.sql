-- Use the NTILE() function to divide the movies produced by each production company into quartiles based on revenue. 
-- Display the company name, movie title, revenue, and quartile.
SELECT
    pc.company_name,
    m.title,
    m.revenue,
    NTILE(4) OVER (PARTITION BY pc.company_name ORDER BY m.revenue DESC) AS revenue_quartile
	-- Divides each company’s movies into 4 quartiles (1 = highest revenue group, 4 = lowest).
FROM movies.movie AS m
JOIN movies.movie_company AS mc ON m.movie_id = mc.movie_id
JOIN movies.production_company AS pc ON mc.company_id = pc.company_id
WHERE m.revenue>0 
-- AND pc.company_name = '1492 Pictures'
ORDER BY pc.company_name, revenue_quartile, m.revenue DESC;

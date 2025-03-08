SELECT YEAR(website_sessions.created_at) AS `YEAR`,
		YEARWEEK(website_sessions.created_at) AS `WEEK`,
        COUNT(website_sessions.website_session_id) AS sessions,
        COUNT(orders.order_id) AS orders FROM website_sessions
        LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
        GROUP BY 1,2
        ORDER BY 1,2 ASC;
        
WITH Cte AS (SELECT DATE(created_at) AS `created_date`,
		WEEKDAY(created_at) AS `WEEKDAY`,
		HOUR(created_at) AS `HOUR`,
		COUNT(DISTINCT website_session_id) AS sessions
        FROM website_sessions
        WHERE created_at BETWEEN '2012-09-15' AND '2012-11-15'
        GROUP BY 1,2,3)
        SELECT `HOUR`,
				AVG(sessions) FROM Cte
                GROUP BY 1
                ORDER BY 1;
                
CREATE TEMPORARY TABLE pre_pivot_table
(SELECT 
		*,
		CASE WHEN WEEKDAY = 0 THEN 'Mon'
        WHEN WEEKDAY = 1 THEN 'Tue'
        WHEN WEEKDAY = 2 THEN 'Wed'
        WHEN WEEKDAY = 3 THEN 'Thu'
        WHEN WEEKDAY = 4 THEN 'Fri'
        WHEN WEEKDAY = 5 THEN 'Sat'
        WHEN WEEKDAY = 6 THEN 'Sun' END AS WEEKDAY_ FROM (SELECT DATE(created_at) AS `created_date`,
		WEEKDAY(created_at) AS `WEEKDAY`,
		HOUR(created_at) AS `HOUR`,
		COUNT(DISTINCT website_session_id) AS sessions
        FROM website_sessions
        WHERE created_at BETWEEN '2012-09-15' AND '2012-11-15'
        GROUP BY 1,2,3) sub);

SELECT 
		HOUR,
        round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'mon' THEN sessions ELSE null END),1) AS 'mon',
		round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'tue' THEN sessions ELSE null END),1) AS 'tue',
		round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'wed' THEN sessions ELSE null END),1) AS 'wed',
		round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'thu' THEN sessions ELSE null END),1) AS 'thu',
		round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'fri' THEN sessions ELSE null END),1) AS 'fri',
		round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'sat' THEN sessions ELSE null END),1) AS 'sat',
        round(AVG(CASE WHEN lower(WEEKDAY_) LIKE 'sun' THEN sessions ELSE null END),1) AS 'sun' FROM pre_pivot_table
        GROUP BY 1
		ORDER BY 1 ASC;
        
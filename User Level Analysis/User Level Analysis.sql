CREATE TEMPORARY TABLE sessions_repeats
SELECT
		new_sessions.user_id,
        new_sessions.website_session_id AS new_sessions,
        website_sessions.website_session_id AS repeat_sessions FROM
(SELECT user_id,
		website_session_id FROM website_sessions
        WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01' AND is_repeat_session = 0) new_sessions
        LEFT JOIN website_sessions
        ON new_sessions.user_id = website_sessions.user_id
        AND website_sessions.is_repeat_session = 1
        AND website_sessions.website_session_id > new_sessions.website_session_id
        AND website_sessions.created_at BETWEEN '2014-01-01' AND '2014-11-01';


SELECT repeat_sessions,
		COUNT(user_id) AS users FROM
(SELECT user_id,
		COUNT(DISTINCT new_sessions) AS new_sessions,
        COUNT(DISTINCT repeat_sessions) AS repeat_sessions 
 FROM sessions_repeats
 GROUP BY 1
 ORDER BY 3 ASC) CTE
 GROUP BY 1
 ORDER BY 1 ASC;
 
 --
 
CREATE TEMPORARY TABLE sessions_repeat_1
 SELECT
		new_sessions.user_id,
        new_sessions.website_session_id AS new_sessions,
        website_sessions.website_session_id AS repeat_sessions,
        new_sessions.created_at,
        website_sessions.created_at AS new_created_at,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY website_sessions.website_session_id) AS session_th FROM
(SELECT user_id,
		website_session_id,
        created_at FROM website_sessions
        WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01' AND is_repeat_session = 0) new_sessions
        LEFT JOIN website_sessions
        ON new_sessions.user_id = website_sessions.user_id
        AND website_sessions.is_repeat_session = 1
        AND website_sessions.website_session_id > new_sessions.website_session_id
        AND website_sessions.created_at BETWEEN '2014-01-01' AND '2014-11-01'
        ORDER BY 1,2,3 ASC;


SELECT 
		MIN(DATEDIFF(new_created_at,created_at)) AS min_time,
        MAX(DATEDIFF(new_created_at,created_at)) AS max_time,
        AVG(DATEDIFF(new_created_at,created_at)) AS avg_time FROM sessions_repeat_1
        WHERE session_th = 1;
        
--
SELECT 
		channels,
        COUNT(DISTINCT CASE WHEN is_repeat_session = 0 THEN website_session_id END) AS new_sessions,
        COUNT(DISTINCT CASE WHEN is_repeat_session = 1 THEN website_session_id END) AS repeat_sessions FROM
(SELECT website_session_id,
		created_at,
        user_id,
        is_repeat_session,
        utm_source,
        http_referer,
		CASE WHEN
		http_referer IS NULL THEN 'direct_type_in'
        WHEN http_referer IS NOT NULL AND utm_source IS NULL THEN 'organic_search'
        when utm_campaign LIKE 'nonbrand' THEN 'paid_nonbrand'
        WHEN utm_campaign LIKE 'brand' THEN 'paid_brand'
        WHEN utm_source LIKE 'socialbook' THEN 'paid_social' END AS channels
        FROM website_sessions
        WHERE created_at BETWEEN '2014-01-01' AND '2014-11-05') sessions_channels
		GROUP BY 1;
        
--
SELECT 
		year(website_sessions.created_at) as `year`,
		CASE WHEN
			website_sessions.is_repeat_session = 0 THEN 'A. new_sessions'
            ELSE 'B. repeat_sessions' END AS repeat_type,
            COUNT(website_sessions.website_session_id) AS sessions,
            COUNT(orders.order_id) AS orders,
            COUNT(orders.order_id)/COUNT(website_sessions.website_session_id) AS CR,
            SUM(orders.price_usd)/COUNT(website_sesSions.website_session_id) AS revenue_per_session 
            FROM website_sessions
            LEFT JOIN orders
            ON website_Sessions.website_session_id = orders.website_session_id
            WHERE website_sessions.created_at BETWEEN '2014-01-01' AND '2014-11-08'
            GROUP BY 1,2
            ORDER BY 1,2;
SELECT
		pageview_url,
        COUNT(DISTINCT website_session_id) AS `session` FROM website_pageviews
        WHERE created_at < '2012-06-12'
        GROUP BY 1
        ORDER BY 2 DESC;
        
-- It seems like the homepage,products,mrfuzzy get the bulk of our traffic
        
WITH CTE AS (
		SELECT website_session_id,
        MIN(website_pageview_id) AS min_website_pv
        FROM website_pageviews
        WHERE created_at < '2012-06-12'
        GROUP BY 1)
        SELECT 
				website_pageviews.pageview_url,
                COUNT(DISTINCT CTE.website_session_id) AS `session`
                FROM CTE JOIN website_pageviews ON CTE.min_website_pv = website_pageviews.website_pageview_id
                GROUP BY 1;

-- Everyone comes to our website through the homepage.
CREATE TEMPORARY TABLE table_w_landing_page
WITH CTE AS (
		SELECT website_session_id,
        MIN(website_pageview_id) AS min_website_pv
        FROM website_pageviews
        WHERE created_at < '2012-06-14' AND pageview_url = '/home'
        GROUP BY 1)
        SELECT CTE.website_session_id,
				website_pageviews.pageview_url
                FROM CTE JOIN website_pageviews ON CTE.min_website_pv = website_pageviews.website_pageview_id;
CREATE TEMPORARY TABLE table_w_bounced_sessions
SELECT
		table_w_landing_page.website_session_id
        FROM table_w_landing_page JOIN website_pageviews ON table_w_landing_page.website_session_id = website_pageviews.website_session_id
        GROUP BY 1
        HAVING COUNT(website_pageview_id) = 1;
SELECT 
				table_w_landing_page.pageview_url,
                COUNT(DISTINCT table_w_landing_page.website_session_id) AS sessions,
                COUNT(DISTINCT table_w_bounced_sessions.website_Session_id) AS bounced_sessions,
                COUNT(DISTINCT table_w_bounced_sessions.website_Session_id)/COUNT(DISTINCT table_w_landing_page.website_session_id) AS `%_of_sessions_which_bounced`
                FROM table_w_landing_page LEFT JOIN table_w_bounced_sessions ON table_w_landing_page.website_session_id = table_w_bounced_sessions.website_session_id
                GROUP BY 1;
-- The bounced rate is almost 60% that is very high.
-- They started the new customer landingpage

SELECT 
        MIN(website_pageview_id)
        FROM website_pageviews
        WHERE lower(pageview_url) LIKE '/lander-1' AND created_at < '2012-07-28';
        
-- lander-1 get the traffic on 23504 pageview_id

CREATE TEMPORARY TABLE IF NOT EXISTS table_with_landing_page
WITH CTE AS (SELECT
		website_sessions.website_session_id,
        MIN(website_pageviews.website_pageview_id) AS min_pageview_id
        FROM website_sessions JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
        WHERE website_sessions.created_at < '2012-07-28' AND lower(website_pageviews.pageview_url) IN ('/home','/lander-1') AND website_pageviews.website_pageview_id > 23504 
        AND lower(website_sessions.utm_source) LIKE 'gsearch' AND lower(website_sessions.utm_campaign) LIKE 'nonbrand'
        GROUP BY 1)
        SELECT CTE.website_session_id,
				website_pageviews.pageview_url FROM CTE
                JOIN website_pageviews ON CTE.min_pageview_id = website_pageviews.website_pageview_id;

CREATE TEMPORARY TABLE table_with_bounced_sessions
SELECT
		table_with_landing_page.website_session_id
        FROM table_with_landing_page JOIN website_pageviews ON table_with_landing_page.website_session_id = website_pageviews.website_session_id
        GROUP BY 1
        HAVING COUNT(website_pageview_id) = 1;


SELECT table_with_landing_page.pageview_url,
		COUNT(DISTINCT table_with_landing_page.website_session_id) AS sessions,
        COUNT(DISTINCT table_with_bounced_Sessions.website_session_id) AS bounced_sessions,
        COUNT(DISTINCT table_with_bounced_Sessions.website_session_id)/COUNT(DISTINCT table_with_landing_page.website_session_id) AS `%_of_sessions_which_bounced`
        FROM table_with_landing_page LEFT JOIN table_with_bounced_sessions ON table_with_landing_page.website_session_id = table_with_bounced_sessions.website_session_id
        GROUP BY 1;

-- The new landing page has lower bounced rate.
CREATE TEMPORARY TABLE min_pv_joined_bounced_table
SELECT website_sessions.website_session_id,
		MIN(website_pageviews.website_pageview_id) AS first_pageview,
        COUNT(website_pageviews.website_pageview_id) AS count_pageviews FROM website_sessions
        LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
        WHERE website_sessions.created_at > '2012-06-01' AND website_sessions.created_at < '2012-08-31'
        AND lower(website_sessions.utm_campaign) LIKE 'nonbrand' AND lower(website_sessions.utm_source) LIKE 'gsearch'
        GROUP BY website_sessions.website_session_id;

CREATE TEMPORARY TABLE sessions_count_wlandingpage
SELECT min_pv_joined_bounced_table.website_session_id,
		 min_pv_joined_bounced_table.first_pageview,
		min_pv_joined_bounced_table.count_pageviews,
        website_pageviews.pageview_url AS landing_page,
		website_pageviews.created_at FROM min_pv_joined_bounced_table
        LEFT JOIN website_pageviews ON min_pv_joined_bounced_table.first_pageview = website_pageviews.website_pageview_id;

SELECT 
    YEARWEEK(created_at) AS year_week,
    COUNT(CASE WHEN LOWER(landing_page) LIKE '/home' THEN 1 END) AS total_sessions_homepage,
    COUNT(CASE WHEN LOWER(landing_page) LIKE '/lander-1' THEN 1 END) AS total_sessions_lander_1,
    COUNT(CASE WHEN LOWER(landing_page) LIKE '/home' AND count_pageviews = 1 THEN 1 END) AS total_bounced_sessions_home,
    COUNT(CASE WHEN LOWER(landing_page) LIKE '/lander-1' AND count_pageviews = 1 THEN 1 END) AS total_bounced_sessions_lander_1,
    SUM(CASE WHEN LOWER(landing_page) LIKE '/home' AND count_pageviews = 1 THEN 1 END) * 1.0 /
        NULLIF(COUNT(CASE WHEN LOWER(landing_page) LIKE '/home' THEN 1 END), 0) AS bounced_homepage_ratio,
    SUM(CASE WHEN LOWER(landing_page) LIKE '/lander-1' AND count_pageviews = 1 THEN 1 END) * 1.0 /
        NULLIF(COUNT(CASE WHEN LOWER(landing_page) LIKE '/lander-1' THEN 1 END), 0) AS bounced_lander_1_ratio
FROM 
    sessions_count_wlandingpage
GROUP BY 
    YEARWEEK(created_at);
-- We fully switched to the new landing page, our bounced rate comes down over time.

CREATE TEMPORARY TABLE Mutually_exclusively_table_for_conversion_funnel
SELECT sessions,
		MAX(home_page) AS home_page,
		MAX(lander_1_page) AS lander_1_page,
        MAX(product_page) AS product_page,
        MAX(mrfuzzy_page) as mrfuzzy_page,
        MAX(cart_page) AS cart_page,
        MAX(shipping_page) AS shipping_page,
        MAX(billing_page) AS billing_page,
        MAX(thankyou_page) AS thankyou_page FROM 
(SELECT 
    w_s.website_session_id AS sessions,
    w_p.pageview_url AS landing_page,
    -- w_s.created_at AS visited_time,
    CASE WHEN w_p.pageview_url = '/home' THEN 1 ELSE 0 END AS home_page,
    CASE WHEN w_p.pageview_url = '/lander-1' THEN 1 ELSE 0 END AS lander_1_page,
        CASE WHEN w_p.pageview_url = '/products' THEN 1 ELSE 0 END AS product_page,
        CASE WHEN w_p.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
        CASE WHEN w_p.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN w_p.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN w_p.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN w_p.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
FROM
    website_sessions w_s
        LEFT JOIN
    website_pageviews w_p ON w_s.website_Session_id = w_p.website_pageview_id
WHERE
    w_s.created_at BETWEEN '2012-08-05' AND '2012-09-05'
        AND w_s.utm_source = 'gsearch' AND w_s.utm_campaign = 'nonbrand'
ORDER BY w_s.website_session_id) AS matrix_page_table
GROUP BY sessions;

        
SELECT COUNT(DISTINCT sessions) AS sessions,
        COUNT(CASE WHEN product_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN lander_1_page = 1 THEN sessions ELSE NULL END) AS lander_1_clickthrough_rate,
        COUNT(CASE WHEN mrfuzzy_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN product_page = 1 THEN sessions ELSE NULL END) AS product_clickthrough_rate,
		COUNT(CASE WHEN cart_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN mrfuzzy_page = 1 THEN sessions ELSE NULL END) AS mrfuzzy_clickthrough_rate,
		COUNT(CASE WHEN shipping_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN cart_page = 1 THEN sessions ELSE NULL END) AS cart_clickthrough_rate,
		COUNT(CASE WHEN billing_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN shipping_page = 1 THEN sessions ELSE NULL END) AS shipping_clickthrough_rate,
		COUNT(CASE WHEN thankyou_page = 1 THEN sessions ELSE NULL END)/COUNT(CASE WHEN billing_page = 1 THEN sessions ELSE NULL END) AS billing_clickthrough_rate FROM Mutually_exclusively_table_for_conversion_funnel;
-- Focusing on lander_clickthr,mrfuzzy_clickthr,billing_clickthr

SELECT MIN(website_pageview_id) FROM website_pageviews
WHERE pageview_url LIKE '/billing-2';
-- website_pageview_id = 53550


SELECT pageview_url,
		COUNT(website_session_id) AS sessions,
        COUNT(order_id) AS orders,
        COUNT(order_id)/COUNT(website_session_id) AS conversion_rate FROM
(SELECT w_p.website_session_id,
		w_p.pageview_url,
        orders.order_id FROM website_pageviews w_p
        LEFT JOIN orders ON w_p.website_session_id = orders.website_session_id
        WHERE w_p.website_pageview_id > 53550 AND w_p.pageview_url IN ('/billing','/billing-2') AND w_p.created_at BETWEEN '2012-09-05' AND '2012-11-10') AS flag_table
		GROUP BY pageview_url;
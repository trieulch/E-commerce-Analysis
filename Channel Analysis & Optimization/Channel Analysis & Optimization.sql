SELECT YEARWEEK(created_at) AS 'WEEKS',
		MIN(created_at) AS start_date,
		COUNT(DISTINCT CASE WHEN lower(UTM_source) LIKE 'bsearch' AND lower(UTM_campaign) LIKE 'nonbrand' THEN website_session_id END) AS bsearch_n_session,
		COUNT(DISTINCT CASE WHEN lower(UTM_source) LIKE 'gsearch' AND lower(UTM_campaign) LIKE 'nonbrand' THEN website_session_id END) AS gsearch_n_session FROM website_sessions
        WHERE created_at BETWEEN '2012-08-22' AND '2012-11-29'
        GROUP BY 1
        ORDER BY 1 ASC;
        
        
SELECT utm_source,
		COUNT(DISTINCT website_session_id) AS sessions,
		COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions,
        COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' THEN website_session_id ELSE NULL END)/COUNT(DISTINCT website_session_id) AS pct_mobile
        FROM website_sessions
        WHERE created_at BETWEEN '2012-08-22' AND '2012-11-30' AND utm_campaign ='nonbrand'
        GROUP BY 1;
        
SELECT utm_source,
		device_type,
		COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS conv_sessions_to_orders FROM website_sessions
        LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
        WHERE website_sessions.utm_source IN ('gsearch','bsearch') AND website_sessions.utm_campaign LIKE 'nonbrand' AND website_sessions.created_at BETWEEN '2012-08-22' AND '2012-09-19'
        GROUP BY 1,2
        ORDER BY 1 ASC;
        
SELECT YEARWEEK(created_at) AS `WEEK`,
		COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' AND lower(utm_source) LIKE 'gsearch' THEN website_session_id ELSE NULL END) AS mobile_gsearch_sessions,
		COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'desktop' AND lower(utm_source) LIKE 'gsearch' THEN website_session_id ELSE NULL END) AS desktop_gsearch_sessions,
        COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' AND lower(utm_source) LIKE 'bsearch' THEN website_session_id ELSE NULL END) AS mobile_bsearch_sessions,
		COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'desktop' AND lower(utm_source) LIKE 'bsearch' THEN website_session_id ELSE NULL END) AS desktop_bsearch_sessions,
        COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' AND lower(utm_source) LIKE 'bsearch' THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'mobile' AND lower(utm_source) LIKE 'gsearch' THEN website_session_id ELSE NULL END) AS pct_mobile,
        COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'desktop' AND lower(utm_source) LIKE 'bsearch' THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN lower(device_type) LIKE 'desktop' AND lower(utm_source) LIKE 'gsearch' THEN website_session_id ELSE NULL END) AS pct_desktop
        FROM website_sessions
        WHERE created_at BETWEEN '2012-12-02' AND '2012-12-22' AND lower(utm_campaign) LIKE 'nonbrand'
        GROUP BY 1
        ORDER BY 1;
        
SELECT YEAR(created_at) AS `Year`,
		MONTH(created_at) AS `Month`,
        COUNT(DISTINCT CASE WHEN channel_types LIKE 'nonbrand' THEN website_session_id END) AS nonbrand,
        COUNT(DISTINCT CASE WHEN channel_types LIKE 'paid_brand_search' THEN website_session_id END) AS paid_brand_search,
        COUNT(DISTINCT CASE WHEN channel_types LIKE 'paid_brand_search' THEN website_session_id END)/COUNT(DISTINCT CASE WHEN channel_types LIKE 'nonbrand' THEN website_session_id END) AS brand_pct_of_nonbrand,
		COUNT(DISTINCT CASE WHEN channel_types LIKE 'direct type in' THEN website_session_id END) AS direct_type_in,
        COUNT(DISTINCT CASE WHEN channel_types LIKE 'direct type in' THEN website_session_id END)/COUNT(DISTINCT CASE WHEN channel_types LIKE 'nonbrand' THEN website_session_id END) AS direct_pct_of_nonbrand,
        (COUNT(DISTINCT CASE WHEN channel_types LIKE 'gsearch_organic' THEN website_session_id END)+COUNT(DISTINCT CASE WHEN channel_types LIKE 'bsearch_organic' THEN website_session_id END))/
        COUNT(DISTINCT CASE WHEN channel_types LIKE 'nonbrand' THEN website_session_id END) AS organic_pct_of_nonbrand
        FROM
(SELECT website_session_id,created_at,
	CASE WHEN http_referer IS NULL THEN 'direct type in'
	WHEN http_referer LIKE 'https://www.gsearch.com' AND utm_source IS NULL THEN 'gsearch_organic'
	WHEN http_referer LIKE 'https://www.bsearch.com' AND utm_source IS NULL THEN 'bsearch_organic'
    WHEN utm_campaign LIKE 'brand' THEN 'paid_brand_search'
    ELSE 'nonbrand' END AS channel_types FROM website_sessions
    WHERE created_at < '2012-12-23') AS test_table
    GROUP BY 1,2;
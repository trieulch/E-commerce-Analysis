SELECT 
    utm_source,
    utm_campaign,
    utm_content,
    http_referer,
    COUNT(DISTINCT website_Session_id) AS `session`,
    COUNT(DISTINCT website_session_id) * 100 / (SELECT 
            COUNT(DISTINCT website_session_id)
        FROM
            website_sessions
        WHERE
            created_at < '2012-04-12') AS `%_traffic_source_of_total`
FROM
    website_sessions
WHERE
    created_at < '2012-04-12'
GROUP BY 1 , 2 , 3 , 4
ORDER BY `session` DESC;

-- The gsearch source in nonbrand campaign is quite dominated since beginning to April. The % of total is 97.44%.

SELECT 
    COUNT(DISTINCT w_s.website_session_id) AS `session`,
    COUNT(DISTINCT o.order_id) AS `order`,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT w_s.website_session_id) AS conversion_rate
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    w_s.created_at < '2012-04-12'
        AND LOWER(w_s.utm_source) LIKE 'gsearch'
        AND LOWER(w_s.utm_campaign) LIKE 'nonbrand';

-- Its conversion rate is lower than 4%(threshhold).
-- * The marketing department decided to bid down the gsearch nonbrand on '2014-04-15'


SELECT 
    CASE
        WHEN created_at < '2012-04-15' THEN 'Pre'
        ELSE 'Post'
    END AS Period,
    MIN(created_at) AS week_start_date,
    COUNT(DISTINCT website_session_id) AS `session`
FROM
    website_sessions
WHERE
    created_at < '2012-05-10'
        AND LOWER(utm_source) LIKE 'gsearch'
        AND LOWER(utm_campaign) LIKE 'nonbrand'
GROUP BY WEEK(created_at) , 1
ORDER BY WEEK(created_at) ASC;
        
-- The gsearch nonbrand is fairly sensitive to bid changes. Its drop ~42,5% in volume

SELECT 
    w_s.device_type,
    COUNT(DISTINCT w_s.website_session_id) AS `session`,
    COUNT(DISTINCT o.order_id) AS `order`,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT w_s.website_session_id) AS conversion_rate
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    w_s.created_at < '2012-05-11'
        AND LOWER(w_s.utm_source) LIKE 'gsearch'
        AND LOWER(w_s.utm_campaign) LIKE 'nonbrand'
GROUP BY 1;
-- The conversion_rate of desktop is much more higher than mobile, we might bid it up.
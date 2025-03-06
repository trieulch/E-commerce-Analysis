-- MID COURSE PROJECT
-- PULLING THE MONTHLY TRENDS OF SESSIONS AND ORDERS TO SHOWCASE THE GROWTH

SELECT 
    DATE_FORMAT(w_s.created_at, '%Y-%m') AS `MONTH`,
    MIN(w_s.created_at) AS Start_date,
    COUNT(w_s.website_session_id) AS sessions,
    COUNT(o.order_id) AS orders
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    LOWER(w_s.utm_source) LIKE 'gsearch'
        AND w_s.created_at BETWEEN DATE_SUB('2012-11-27', INTERVAL 8 MONTH) AND '2012-11-27'
GROUP BY DATE_FORMAT(w_s.created_at, '%Y-%m')
ORDER BY DATE_FORMAT(w_s.created_at, '%Y-%m');
        
-- The monthly trend of sessions and orders of gsearch are picking up in 8-month period. What a significant number

SELECT 
    DATE_FORMAT(w_s.created_at, '%Y-%m') AS `MONTH`,
    MIN(w_s.created_at) AS Start_date,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_campaign) LIKE 'brand' THEN w_s.website_session_id
        END) AS brand_sessions,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_campaign) LIKE 'nonbrand' THEN w_s.website_session_id
        END) AS non_brand_sessions,
    COUNT(w_s.website_session_id) AS sessions,
    COUNT(o.order_id) AS orders,
    CONCAT(ROUND((COUNT(o.order_id) / COUNT(w_s.website_session_id)) * 100,
                    2),
            '%') AS cvr_sessions_to_orders
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    LOWER(w_s.utm_source) LIKE 'gsearch'
        AND w_s.created_at BETWEEN DATE_SUB('2012-11-27', INTERVAL 8 MONTH) AND '2012-11-27'
GROUP BY DATE_FORMAT(w_s.created_at, '%Y-%m')
ORDER BY DATE_FORMAT(w_s.created_at, '%Y-%m');
-- The brands' traffic is picking up. This could be notable increasement from 5 to 383(increased by 75.6 times)

SELECT 
    DATE_FORMAT(w_s.created_at, '%Y-%m') AS `MONTH`,
    MIN(w_s.created_at) AS Start_date,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.device_type) LIKE 'mobile' THEN w_s.website_session_id
        END) AS mobile_sessions,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.device_type) LIKE 'desktop' THEN w_s.website_session_id
        END) AS desktop_sessions,
    COUNT(w_s.website_session_id) AS sessions,
    COUNT(o.order_id) AS orders,
    CONCAT(ROUND((COUNT(o.order_id) / COUNT(w_s.website_session_id)) * 100,
                    2),
            '%') AS cvr_sessions_to_orders
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    LOWER(w_s.utm_source) LIKE 'gsearch'
        AND w_s.created_at BETWEEN DATE_SUB('2012-11-27', INTERVAL 8 MONTH) AND '2012-11-27'
        AND LOWER(w_s.utm_campaign) LIKE 'nonbrand'
GROUP BY DATE_FORMAT(w_s.created_at, '%Y-%m')
ORDER BY DATE_FORMAT(w_s.created_at, '%Y-%m');
        
-- The desktop_sessions is dominated than mobile_sessions. This could be an biased behavior of customers' usage or poor mobile UI/UX.

SELECT 
    DATE_FORMAT(w_s.created_at, '%Y-%m') AS `MONTH`,
    MIN(w_s.created_at) AS Start_date,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_source) LIKE 'gsearch' THEN w_s.website_session_id
        END) AS gsearch_sessions,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_source) LIKE 'bsearch' THEN w_s.website_session_id
        END) AS bsearch_sessions,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_source) LIKE 'socialbook' THEN w_s.website_session_id
        END) AS socialbook_sessions,
    COUNT(DISTINCT CASE
            WHEN LOWER(w_s.utm_source) IS NULL THEN w_s.website_session_id
        END) AS unknown_sessions,
    COUNT(w_s.website_session_id) AS sessions
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    w_s.created_at BETWEEN DATE_SUB('2012-11-27', INTERVAL 8 MONTH) AND '2012-11-27'
GROUP BY DATE_FORMAT(w_s.created_at, '%Y-%m')
ORDER BY DATE_FORMAT(w_s.created_at, '%Y-%m');
        
-- The monthly sessions of gsearch is picking up and it seems a strong correlation with other channels and total sessions.

SELECT 
    DATE_FORMAT(w_s.created_at, '%Y-%m') AS `MONTH`,
    MIN(w_s.created_at) AS Start_date,
    COUNT(w_s.website_session_id) AS sessions,
    COUNT(o.order_id) AS orders,
    CONCAT(ROUND((COUNT(o.order_id) / COUNT(w_s.website_session_id)) * 100,
                    2),
            '%') AS cvr_sessions_to_orders
FROM
    website_sessions w_s
        LEFT JOIN
    orders o ON w_s.website_session_id = o.website_session_id
WHERE
    w_s.created_at BETWEEN DATE_SUB('2012-11-27', INTERVAL 8 MONTH) AND '2012-11-27'
        AND LOWER(w_s.utm_campaign) LIKE 'nonbrand'
GROUP BY DATE_FORMAT(w_s.created_at, '%Y-%m')
ORDER BY DATE_FORMAT(w_s.created_at, '%Y-%m');
-- The cvr is picking up in the 8-month period FROM 3.07% to 4.42% increased by 31.0%. What a significant figure when in intial stages.


SELECT 
    MIN(website_pageview_id)
FROM
    website_pageviews
WHERE
    LOWER(pageview_url) LIKE '/lander-1';

-- first_pageview_id = 23504


CREATE TEMPORARY TABLE first_pv_each_session_id
SELECT w_s.website_session_id,
		MIN(w_p.website_pageview_id) AS first_pv
        FROM website_sessions w_s
        LEFT JOIN website_pageviews w_p ON w_s.website_session_id = w_p.website_session_id
        WHERE lower(w_s.utm_source) LIKE 'gsearch' AND lower(w_s.utm_campaign) LIKE 'nonbrand' AND w_s.created_at BETWEEN '2012-06-19' AND '2012-07-28' AND w_p.website_pageview_id >= 23504
        GROUP BY w_s.website_session_id;


CREATE TEMPORARY TABLE landing_page_each_session_id
SELECT first_pv_each_session_id.website_session_id,
		w_p.pageview_url AS landing_page FROM first_pv_each_session_id
        LEFT JOIN website_pageviews w_p ON first_pv_each_session_id.website_session_id = w_p.website_session_id
        WHERE w_p.pageview_url IN ('/home','/lander-1');
        
WITH order_id_joined_table AS (SELECT landing_page_each_session_id.website_session_id,
		landing_page_each_session_id.landing_page,
        orders.order_id FROM landing_page_each_session_id
        LEFT JOIN orders ON landing_page_each_session_id.website_session_id = orders.website_session_id)
SELECT landing_page,
		count(distinct website_session_id) AS sessions,
        count(distinct order_id) AS orders,
        count(distinct order_id)/count(distinct website_session_id) AS conv_rate FROM order_id_joined_table
        GROUP BY landing_page;
        
-- the increasement is 0.0088, now we calcuate the increasement of sessions

SELECT 
    MAX(website_sessions.website_session_id)
FROM
    website_sessions
        LEFT JOIN
    website_pageviews w_p ON website_sessions.website_session_id = w_p.website_session_id
WHERE
    LOWER(website_sessions.utm_campaign) LIKE 'nonbrand'
        AND LOWER(website_sessions.utm_source) LIKE 'gsearch'
        AND website_sessions.created_at < '2012-11-27'
        AND LOWER(w_p.pageview_url) LIKE '/home';
        
        
-- the max session id of '/home' is 17145
SELECT 
    COUNT(website_sessions.website_session_id) * 0.0088 AS incremental_orders,
    ROUND(COUNT(website_sessions.website_session_id) * 0.0088 / 4,
            0) AS avg_orders_per_month
FROM
    website_sessions
WHERE
    LOWER(website_sessions.utm_campaign) LIKE 'nonbrand'
        AND LOWER(website_sessions.utm_source) LIKE 'gsearch'
        AND website_sessions.created_at < '2012-11-27'
        AND website_sessions.website_session_id > 17145;

-- 22972*0.0088 = 202. in 4 months we can get 202 incremental orders since 7/29. so roughly 50 orders per month.
DROP TEMPORARY TABLE IF EXISTS metrics_table;

CREATE TEMPORARY TABLE metrics_table
SELECT website_session_id,
		MAX(homepage) AS homepage,
        MAX(lander_1_page) AS lander_1_page,
        MAX(mrfuzzy_page) AS mrfuzzy_page,
        MAX(product_page) AS product_page,
        MAX(cart_page) AS cart_page,
        MAX(billing_page) AS billing_page,
        MAX(shipping_page) AS shipping_page,
        MAX(`order`) AS `order` FROM
(SELECT w_s.website_session_id,
		CASE WHEN lower(w_p.pageview_url) LIKE '/home' THEN 1 ELSE 0 END AS homepage,
        CASE WHEN lower(w_p.pageview_url) LIKE '/lander-1' THEN 1 ELSE 0 END AS lander_1_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/products' THEN 1 ELSE 0 END AS product_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/billing' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN lower(w_p.pageview_url) LIKE '/thank-you-for-your-order' THEN 1 ELSE 0 END AS `order`
        FROM website_sessions w_s LEFT JOIN website_pageviews w_p ON w_s.website_session_id = w_p.website_session_id
        WHERE lower(w_s.utm_campaign) LIKE 'nonbrand' AND lower(w_s.utm_source) LIKE 'gsearch' AND w_s.created_at BETWEEN '2012-06-19' AND '2012-07-28') metrics_table
        GROUP BY website_session_id;

SELECT 
    CASE
        WHEN homepage = 1 THEN 'homepage'
        WHEN lander_1_page = 1 THEN 'lander_1_page'
        ELSE 'check the logic again'
    END AS segment,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE
            WHEN product_page = 1 THEN website_session_id
        END) AS to_product,
    COUNT(DISTINCT CASE
            WHEN mrfuzzy_page = 1 THEN website_session_id
        END) AS to_mrfuzzy,
    COUNT(DISTINCT CASE
            WHEN cart_page = 1 THEN website_session_id
        END) AS to_cart,
    COUNT(DISTINCT CASE
            WHEN shipping_page = 1 THEN website_session_id
        END) AS to_shipping,
    COUNT(DISTINCT CASE
            WHEN billing_page = 1 THEN website_session_id
        END) AS to_billing,
    COUNT(DISTINCT CASE
            WHEN `order` = 1 THEN website_session_id
        END) AS to_order
FROM
    metrics_table
GROUP BY (1);

SELECT 
    CASE
        WHEN homepage = 1 THEN 'homepage'
        WHEN lander_1_page = 1 THEN 'lander_1_page'
        ELSE 'check the logic again'
    END AS segment,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE
            WHEN mrfuzzy_page = 1 THEN website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN product_page = 1 THEN website_session_id
        END) AS to_mrfuzzy_clickthr,
    COUNT(DISTINCT CASE
            WHEN cart_page = 1 THEN website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN mrfuzzy_page = 1 THEN website_session_id
        END) AS to_cart_clickthr,
    COUNT(DISTINCT CASE
            WHEN shipping_page = 1 THEN website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN cart_page = 1 THEN website_session_id
        END) AS to_shipping_clickthr,
    COUNT(DISTINCT CASE
            WHEN billing_page = 1 THEN website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN shipping_page = 1 THEN website_session_id
        END) AS to_billing_clickthr,
    COUNT(DISTINCT CASE
            WHEN `order` = 1 THEN website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN billing_page = 1 THEN website_session_id
        END) AS to_order_clickthr
FROM
    metrics_table
GROUP BY (1);

SELECT 
    MAX(website_sessions.website_session_id)
FROM
    website_sessions
        LEFT JOIN
    website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE
    website_pageviews.pageview_url LIKE '/billing';

-- MAX 63501


SELECT 
    'This month' AS `date`,
    pageview_each_session.pageview_url AS pageview,
    COUNT(pageview_each_session.website_session_id) AS sessions,
    COUNT(orders.order_id) AS orders,
    COUNT(orders.order_id) / COUNT(pageview_each_session.website_session_id) AS cvr_billing_to_oders,
    SUM(orders.price_usd * orders.items_purchased) / COUNT(pageview_each_session.website_session_id) AS revenue_per_billing_session
FROM
    (SELECT 
        website_sessions.website_session_id,
            website_pageviews.pageview_url
    FROM
        website_sessions
    LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
    WHERE
        website_sessions.created_at BETWEEN '2012-09-10' AND '2012-11-10'
            AND website_pageviews.pageview_url IN ('/billing' , '/billing-2')) pageview_each_session
        LEFT JOIN
    orders ON pageview_each_session.website_session_id = orders.website_session_id
GROUP BY 1 , 2 
UNION SELECT 
    'Last month' AS `date`,
    pageview_each_session.pageview_url AS pageview,
    COUNT(pageview_each_session.website_session_id) AS sessions,
    COUNT(orders.order_id) AS orders,
    COUNT(orders.order_id) / COUNT(pageview_each_session.website_session_id) AS cvr_billing_to_oders,
    SUM(orders.price_usd * orders.items_purchased) / COUNT(pageview_each_session.website_session_id) AS revenue_per_billing_session
FROM
    (SELECT 
        website_sessions.website_session_id,
            website_pageviews.pageview_url
    FROM
        website_sessions
    LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
    WHERE
        website_sessions.created_at BETWEEN DATE_SUB('2012-09-10', INTERVAL 1 MONTH) AND DATE_SUB('2012-11-10', INTERVAL 1 MONTH)
            AND website_pageviews.pageview_url IN ('/billing' , '/billing-2')) pageview_each_session
        LEFT JOIN
    orders ON pageview_each_session.website_session_id = orders.website_session_id
GROUP BY 1 , 2
ORDER BY 1 , 2;
-- 22.82 FOR BILLING, 31.34 FOR BILLING-2
-- LIFT: 8.51 FOR BILLING PAGE VIEW

SELECT 
    COUNT(website_session_id) AS billing_sessions_past_month
FROM
    website_pageviews
WHERE
    website_pageviews.pageview_url IN ('/billing' , '/billing-2')
        AND created_at BETWEEN '2012-10-27' AND '2012-11-27';-- past month

SELECT 
    YEAR(website_sessions.created_at) AS `YEAR`,
    QUARTER(website_sessions.created_at) AS `MONTH`,
    COUNT(website_sessions.website_session_id) AS sessions,
    COUNT(orders.order_id) AS orders
FROM
    website_sessions
        LEFT JOIN
    orders ON website_sessions.website_Session_id = orders.website_session_id
WHERE
    YEAR(website_sessions.created_at) != 2015
        AND QUARTER(website_sessions.created_at) != 1
GROUP BY 1 , 2
ORDER BY 1 , 2;
-- Both quarterly sessions and orders are picking up, session_to_order
SELECT 
    YEAR(website_sessions.created_at) AS `YEAR`,
    QUARTER(website_sessions.created_at) AS `MONTH`,
    COUNT(orders.order_id) / COUNT(website_sessions.website_session_id) AS session_to_order,
    SUM(orders.price_usd) / COUNT(orders.order_id) AS revenue_per_order,
    SUM(orders.price_usd) / COUNT(website_sessions.website_session_id) AS revenue_per_session
FROM
    website_sessions
        LEFT JOIN
    orders ON website_sessions.website_Session_id = orders.website_session_id
WHERE
    YEAR(website_sessions.created_at) != 2015
        AND QUARTER(website_sessions.created_at) != 1
GROUP BY 1 , 2
ORDER BY 1 , 2;
-- Quarterly session_to_order is picking up from 3.04% to 7.74% nearly 154% increasement.
-- Quarterly revenue_per_order is picking up from 49.9 to 63.7 nearly 28%
-- Quarterly revenue_per_session is picking up from 1.51 to 4.93 nearly 200% increasement

SELECT 
    CASE
        WHEN
            website_sessions.utm_source LIKE 'gsearch'
                AND website_sessions.utm_campaign LIKE 'nonbrand'
        THEN
            'gsearch_nonbrand'
        WHEN
            website_sessions.utm_source LIKE 'bsearch'
                AND website_sessions.utm_campaign LIKE 'nonbrand'
        THEN
            'bsearch_nonbrand'
        WHEN website_sessions.utm_campaign LIKE 'brand' THEN 'brand_search_overall'
        WHEN
            website_sessions.http_referer IS NOT NULL
                AND website_sessions.utm_source IS NULL
        THEN
            'organic_search'
        WHEN website_sessions.http_referer IS NULL THEN 'direct_type_in'
        ELSE 'others'
    END AS Channel_types,
    COUNT(orders.order_id) AS orders
FROM
    website_sessions
        JOIN
    orders ON website_sessions.website_session_id = orders.website_session_id
GROUP BY 1
ORDER BY 2 DESC;
-- The sessions in paid brand is ineffective in overall because we have already bid down in the the beginning of the launch


WITH cte AS (SELECT 
		website_sessions.website_session_id,
        website_sessions.created_at,
        CASE WHEN website_sessions.utm_source LIKE 'gsearch' AND website_sessions.utm_campaign LIKE 'nonbrand' THEN 'gsearch_nonbrand'
        WHEN website_sessions.utm_source LIKE 'bsearch' AND website_sessions.utm_campaign LIKE 'nonbrand' THEN 'bsearch_nonbrand'
        WHEN website_sessions.utm_campaign LIKE 'brand' THEN 'brand_search_overall'
        WHEN website_sessions.http_referer IS NOT NULL AND website_sessions.utm_source IS NULL THEN 'organic_search'
        WHEN website_sessions.http_referer IS NULL THEN 'direct_type_in' ELSE 'others' END AS channel_types
        FROM website_sessions)
        SELECT YEAR(cte.created_at) AS `YEAR`,
				QUARTER(cte.created_at) AS `QUARTER`,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'gsearch_nonbrand' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'gsearch_nonbrand' THEN cte.website_session_id END) AS gsearch_nonbrand_cr,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'bsearch_nonbrand' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'bsearch_nonbrand' THEN cte.website_session_id END) AS bsearch_nonbrand_cr,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'brand_search_overall' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'brand_search_overall' THEN cte.website_session_id END) AS brand_search_overall_cr,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'organic_search' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'organic_search' THEN cte.website_session_id END) AS organic_search_cr,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'direct_type_in' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'direct_type_in' THEN cte.website_session_id END) AS direct_type_in_cr,
                COUNT(DISTINCT CASE WHEN cte.channel_types = 'others' THEN orders.order_id END)/COUNT(DISTINCT CASE WHEN cte.channel_types = 'others' THEN cte.website_session_id END) AS others_cr FROM cte
			LEFT JOIN orders ON cte.website_session_id = orders.website_session_id
            GROUP BY 1,2;
-- Quarter 4, 2012 we made major improvement on conversion_rates. every_channel is increasing 32% in avg


SELECT 
    YEAR(created_at) AS `YEAR`,
    MONTH(created_at) AS `MONTH`,
    SUM(CASE
        WHEN product_id = 1 THEN price_usd
    END) AS revenue_p1,
    SUM(CASE
        WHEN product_id = 2 THEN price_usd
    END) AS revenue_p2,
    SUM(CASE
        WHEN product_id = 3 THEN price_usd
    END) AS revenue_p3,
    SUM(CASE
        WHEN product_id = 4 THEN price_usd
    END) AS revenue_p4,
    SUM(CASE
        WHEN product_id = 1 THEN price_usd - cogs_usd
    END) AS margin_p1,
    SUM(CASE
        WHEN product_id = 2 THEN price_usd - cogs_usd
    END) AS margin_p2,
    SUM(CASE
        WHEN product_id = 3 THEN price_usd - cogs_usd
    END) AS margin_p3,
    SUM(CASE
        WHEN product_id = 4 THEN price_usd - cogs_usd
    END) AS margin_p4,
    COUNT(DISTINCT order_id) AS sales,
    SUM(price_usd) AS total_revenue
FROM
    order_items
GROUP BY 1 , 2;
        -- The trend pattern is picking up from month 1 to month 12. Every end of the year, the sales is going to increase AS P1,p2 increase at month 2 and month 12


CREATE TEMPORARY TABLE table_after_products_page
With cte AS (SELECT
		website_pageviews.website_session_id,
        website_pageviews.website_pageview_id,
        website_pageviews.pageview_url FROM website_pageviews
        WHERE pageview_url IN ('/products'))
        SELECT cte.website_session_id,
				website_pageviews.website_pageview_id,
                website_pageviews.pageview_url 
				FROM cte
                LEFT JOIN website_pageviews
                ON cte.website_session_id = website_pageviews.website_session_id AND website_pageviews.website_pageview_id > cte.website_pageview_id;

CREATE TEMPORARY TABLE table_with_flagged
SELECT 
		website_session_id,
        MAX(mrfuzzy_page) AS to_fuzzy,
        MAX(lovebear_page) AS to_lovebear,
        MAX(birthbear_page) AS to_birthbear,
        MAX(minibear_page) AS to_minibear,
        MAX(cart_page) AS to_cart,
        MAX(shipping_page) AS to_shipping,
        MAX(billing_page) AS to_billing,
        MAX(billing_2_page) AS to_billing_2,
        MAX(thankyou_page) AS to_thankyou FROM
(SELECT 
		website_session_id,
        CASE WHEN lower(pageview_url) LIKE '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
        CASE WHEN lower(pageview_url) LIKE '/the-forever-love-bear' THEN 1 ELSE 0 END AS lovebear_page,
        CASE WHEN lower(pageview_url) LIKE '/the-birthday-sugar-panda' THEN 1 ELSE 0 END AS birthbear_page,
        CASE WHEN lower(pageview_url) LIKE '/the-hudson-river-mini-bear' THEN 1 ELSE 0 END AS minibear_page,
        CASE WHEN lower(pageview_url) LIKE '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN lower(pageview_url) LIKE '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN lower(pageview_url) LIKE '/billing' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN lower(pageview_url) LIKE '/billing-2' THEN 1 ELSE 0 END AS billing_2_page,
        CASE WHEN lower(pageview_url) LIKE '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page FROM table_after_products_page) int_table
        GROUP BY 1;


SELECT 
    YEAR(website_sessions.created_at) AS `YEAR`,
    MONTH(website_sessions.created_at) AS `MONTH`,
    COUNT(DISTINCT table_with_flagged.website_session_id) AS product_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_fuzzy = 1 THEN table_with_flagged.website_session_id
        END) AS fuzzy_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_lovebear = 1 THEN table_with_flagged.website_session_id
        END) AS lovebear_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_birthbear = 1 THEN table_with_flagged.website_session_id
        END) AS birthbear_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_minibear = 1 THEN table_with_flagged.website_session_id
        END) AS minibear_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_cart = 1 THEN table_with_flagged.website_session_id
        END) AS cart_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_shipping = 1 THEN table_with_flagged.website_session_id
        END) AS shipping_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing = 1 THEN table_with_flagged.website_session_id
        END) AS billing_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing_2 = 1 THEN table_with_flagged.website_session_id
        END) AS billing_2_sessions,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_thankyou = 1 THEN table_with_flagged.website_session_id
        END) AS thankyou_sessions
FROM
    table_with_flagged
        LEFT JOIN
    website_sessions ON table_with_flagged.website_session_id = website_sessions.website_session_id
GROUP BY 1 , 2
ORDER BY 1 , 2;
        
SELECT 
    YEAR(website_sessions.created_at) AS `YEAR`,
    MONTH(website_sessions.created_at) AS `MONTH`,
    COUNT(DISTINCT table_with_flagged.website_session_id) AS product_sessions,
    (COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_fuzzy = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_lovebear = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_birthbear = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_minibear = 1 THEN table_with_flagged.website_session_id
        END)) / COUNT(DISTINCT table_with_flagged.website_session_id) AS product_detailed_clickthr,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_cart = 1 THEN table_with_flagged.website_session_id
        END) / (COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_fuzzy = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_lovebear = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_birthbear = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_minibear = 1 THEN table_with_flagged.website_session_id
        END)) AS cart_ctr,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_shipping = 1 THEN table_with_flagged.website_session_id
        END) / COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_cart = 1 THEN table_with_flagged.website_session_id
        END) AS shipping_ctr,
    (COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing_2 = 1 THEN table_with_flagged.website_session_id
        END)) / COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_shipping = 1 THEN table_with_flagged.website_session_id
        END) AS billing_ctr,
    COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_thankyou = 1 THEN table_with_flagged.website_session_id
        END) / (COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing = 1 THEN table_with_flagged.website_session_id
        END) + COUNT(DISTINCT CASE
            WHEN table_with_flagged.to_billing_2 = 1 THEN table_with_flagged.website_session_id
        END)) AS thankyou_sessions
FROM
    table_with_flagged
        LEFT JOIN
    website_sessions ON table_with_flagged.website_session_id = website_sessions.website_session_id
GROUP BY 1 , 2
ORDER BY 1 , 2;
--


WITH cte AS (SELECT 
		orders.order_id,
        orders.primary_product_id,
        order_items.product_id,
        order_items.price_usd
        FROM orders LEFT JOIN order_items ON orders.order_id = order_items.order_id)
		SELECT primary_product_id,
        COUNT(DISTINCT CASE WHEN product_id = 1 THEN order_id END) x_selling_p1,
        COUNT(DISTINCT CASE WHEN product_id = 2 THEN order_id END) x_selling_p2,
        COUNT(DISTINCT CASE WHEN product_id = 3 THEN order_id END) x_selling_p3,
        COUNT(DISTINCT CASE WHEN product_id = 4 THEN order_id END) x_selling_p4
        FROM cte
		GROUP BY 1;


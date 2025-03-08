SELECT YEAR(created_at) AS `YEAR`
		,MONTH(created_at) AS `MONTH`,
		MIN(created_at) AS start_date,
		COUNT(order_id) AS sales,
		SUM(price_usd*items_purchased) AS total_revenue,
        SUM((price_usd-cogs_usd)*items_purchased) AS total_margin,
        SUM(price_usd*items_purchased)/COUNT(order_id) AS Average_orders_value FROM orders
        WHERE created_at < '2013-01-04'
        GROUP BY 1,2
        ORDER BY 1,2 ASC;

SELECT YEAR(w_s.created_at) AS `YEAR`,
		MONTH(w_s.created_at) AS `MONTH`,
        MIN(o.created_at) AS start_date,
        COUNT(o.order_id) AS sales,
        COUNT(o.order_id)/COUNT(DISTINCT w_s.website_session_id) AS conv_sessions_to_orders,
        SUM(o.price_usd*o.items_purchased)/count(w_s.website_session_id) AS revenue_per_session,
        COUNT(CASE WHEN o.primary_product_id = 1 THEN o.order_id ELSE NULL END) AS product_1_sales,
		COUNT(CASE WHEN o.primary_product_id = 2 THEN o.order_id ELSE NULL END) AS product_2_sales
        FROM website_sessions w_s
        LEFT JOIN orders o ON w_s.website_session_id = o.website_session_id
        WHERE w_s.created_at BETWEEN '2012-04-01' AND '2013-04-05'
        GROUP BY 1,2
        ORDER BY 1,2 ASC;
        
CREATE TEMPORARY TABLE table_with_product_page
SELECT website_sessions.website_session_id,
		website_pageviews.website_pageview_id,
        website_sessions.created_at,
		CASE 
        WHEN website_sessions.created_at < '2013-01-06' THEN 'A. Pre_new_product'
		WHEN website_sessions.created_at >= '2013-01-06' THEN 'B. Post_new_product' ELSE 'LAG' END AS Time_period
		FROM website_sessions
                LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
                WHERE website_sessions.created_at >= '2012-10-06' AND website_sessions.created_at <= '2013-04-06'
                AND website_pageviews.pageview_url LIKE '/products';

CREATE TEMPORARY TABLE table_with_after_product_page
SELECT table_with_product_page.website_session_id,
		website_pageviews.website_pageview_id,
        table_with_product_page.Time_period
        FROM table_with_product_page LEFT JOIN website_pageviews ON table_with_product_page.website_session_id = website_pageviews.website_session_id
        AND website_pageviews.website_pageview_id > table_with_product_page.website_pageview_id;

CREATE TEMPORARY TABLE table_with_after_product_page_joined_name
SELECT table_with_after_product_page.website_session_id,
		table_with_after_product_page.website_pageview_id,
        table_with_after_product_page.Time_period,
        website_pageviews.pageview_url FROM table_with_after_product_page
        LEFT JOIN website_pageviews ON table_with_after_product_page.website_pageview_id = website_pageviews.website_pageview_id;


SELECT Time_period,
		COUNT(DISTINCT website_session_id) AS sessions,
        COUNT(DISTINCT CASE WHEN website_pageview_id IS NOT NULL THEN website_session_id END) AS sessions_next_page,
        COUNT(DISTINCT CASE WHEN website_pageview_id IS NOT NULL THEN website_session_id END)/COUNT(DISTINCT website_session_id) AS clickthr_next_page,
        COUNT(DISTINCT CASE WHEN lower(pageview_url) LIKE '/the-original-mr-fuzzy' THEN website_session_id END) AS session_mrfuzzy,
        COUNT(DISTINCT CASE WHEN lower(pageview_url) LIKE '/the-original-mr-fuzzy' THEN website_session_id END)/COUNT(DISTINCT website_session_id) AS clickthr_session_mrfuzzy,
        COUNT(DISTINCT CASE WHEN lower(pageview_url) LIKE '/the-forever-love-bear' THEN website_session_id END) AS session_mrbear,
        COUNT(DISTINCT CASE WHEN lower(pageview_url) LIKE '/the-forever-love-bear' THEN website_session_id END)/COUNT(DISTINCT website_session_id) AS clickthr_session_mrbear
        FROM table_with_after_product_page_joined_name
        GROUP BY 1;
        
--

CREATE TEMPORARY TABLE table_after_product_page
SELECT
		website_sessions.website_session_id,
        website_sessions.created_at,
        website_pageviews.website_pageview_id,
        website_pageviews.pageview_url
        FROM website_sessions
        LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
         WHERE website_sessions.created_at BETWEEN '2013-01-06' AND '2013-04-10' AND website_pageviews.pageview_url IN('/the-original-mr-fuzzy','/the-forever-love-bear');

CREATE TEMPORARY TABLE table_with_after_product_transformed
SELECT 
		table_after_product_page.website_session_id,
        website_pageviews.created_at,
        table_after_product_page.pageview_url,
        CASE WHEN website_pageviews.pageview_url LIKE '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN website_pageviews.pageview_url LIKE '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN website_pageviews.pageview_url LIKE '/billing-2' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN website_pageviews.pageview_url LIKE '/thank-you-for-your-order' THEN 1 ELSE 0 END AS order_page FROM table_after_product_page
        LEFT JOIN website_pageviews ON table_after_product_page.website_session_id = website_pageviews.website_session_id
				AND website_pageviews.website_pageview_id > table_after_product_page.website_pageview_id
		ORDER BY 1,2;     

SELECT
		CASE WHEN pageview_url LIKE '/the-original-mr-fuzzy' THEN 'mrfuzzy'
        WHEN pageview_url LIKE '/the-forever-love-bear' THEN 'lovebear'
        ELSE 'CHECK THE LOGIC' END AS product_seen,
        COUNT(DISTINCT website_session_id) AS sessions,
        COUNT(DISTINCT CASE WHEN cart_page = 1 then website_session_id END) AS to_cart,
        COUNT(DISTINCT CASE WHEN shipping_page = 1 then website_session_id END) AS to_shipping,
        COUNT(DISTINCT CASE WHEN billing_page = 1 then website_session_id END) AS to_billing,
        COUNT(DISTINCT CASE WHEN order_page = 1 then website_session_id END) AS to_order FROM table_with_after_product_transformed
        GROUP BY 1;


SELECT
		CASE WHEN pageview_url LIKE '/the-original-mr-fuzzy' THEN 'mrfuzzy'
        WHEN pageview_url LIKE '/the-forever-love-bear' THEN 'lovebear'
        ELSE 'CHECK THE LOGIC' END AS product_seen,
        COUNT(DISTINCT CASE WHEN cart_page = 1 then website_session_id END)/ COUNT(DISTINCT website_session_id) AS productpage_click_thr,
        COUNT(DISTINCT CASE WHEN shipping_page = 1 then website_session_id END)/COUNT(DISTINCT CASE WHEN cart_page = 1 then website_session_id END) AS cart_click_rt,
        COUNT(DISTINCT CASE WHEN billing_page = 1 then website_session_id END)/COUNT(DISTINCT CASE WHEN shipping_page = 1 then website_session_id END) AS shipping_click_rt,
        COUNT(DISTINCT CASE WHEN order_page = 1 then website_session_id END)/ COUNT(DISTINCT CASE WHEN billing_page = 1 then website_session_id END) AS billing_click_rt FROM table_with_after_product_transformed
        GROUP BY 1;
        
        
--
DROP TEMPORARY TABLE IF EXISTS table_after_cartpage;
CREATE TEMPORARY TABLE table_after_cartpage
WITH CTE AS(
SELECT CASE WHEN
		created_at < '2013-09-25' THEN 'A.Pre'
        ELSE 'B.Post' END AS time_period,
		website_session_id,
        website_pageview_id,
        pageview_url
        FROM website_pageviews
        WHERE created_at > '2013-08-25' AND created_at < '2013-10-25' AND pageview_url LIKE ('/cart'))
        SELECT 
				CTE.time_period,
                CTE.website_session_id,
                CASE WHEN website_pageviews.website_pageview_id IS NOT NULL THEN 1 ELSE 0 END AS after_cartpage
                FROM CTE
                LEFT JOIN website_pageviews ON CTE.website_session_id = website_pageviews.website_session_id AND website_pageviews.website_pageview_id > CTE.website_pageview_id
                GROUP BY 1,2,3;

SELECT 
	  table_after_cartpage.time_period,
      COUNT(DISTINCT table_after_cartpage.website_session_id) AS sessions,
      COUNT(CASE WHEN table_after_cartpage.after_cartpage = 1 THEN table_after_cartpage.website_session_id END)/COUNT(DISTINCT table_after_cartpage.website_session_id) AS cart_clickthr,
      COUNT(orders.items_purchased)/COUNT(DISTINCT orders.order_id) AS avg_product_per_order,
      SUM(orders.price_usd)/COUNT(DISTINCT orders.order_id) AS AOV,
      SUM(orders.price_usd)/COUNT(DISTINCT table_after_cartpage.website_session_id) AS rev_per_cart_session
      FROM table_after_cartpage
      LEFT JOIN orders ON table_after_cartpage.website_session_id = orders.website_session_id
      GROUP BY 1
      ORDER BY 1 ASC;
      
--
WITH cte AS(SELECT 
		CASE
			WHEN website_pageviews.created_at < '2013-12-12' THEN 'A.Pre_new_product'
            WHEN website_pageviews.created_at >= '2013-12-12' THEN 'B.Post_new_product'
            ELSE 'Check the logic again' END AS Time_period,
		website_pageviews.website_session_id,
		orders.order_id,
        orders.items_purchased,
        orders.price_usd FROM website_pageviews
        LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
        WHERE website_pageviews.created_at BETWEEN '2013-11-12' AND '2014-01-12'
        GROUP BY 1,2,3,4,5)
		SELECT Time_period,
        COUNT(DISTINCT website_session_id) AS sessions,
        COUNT(DISTINCT order_id) AS orders,
        COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS session_to_order_cr,
        SUM(price_usd)/COUNT(order_id) AS AOV,
        AVG(items_purchased) AS products_per_order,
        SUM(price_usd)/COUNT(DISTINCT website_session_id) AS Revenue_per_session FROM cte
        GROUP BY 1
        ORDER BY 1;
--

SELECT 
		YEAR(order_items.created_at) AS `YEAR`,
        MONTH(order_items.created_at) AS `MONTH`,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_items.order_id ELSE NULL END) AS p1_orders,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_item_refunds.order_item_refund_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_items.order_id ELSE NULL END) AS p1_refund_rt,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 2 THEN order_items.order_id ELSE NULL END) AS p2_orders,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 2 THEN order_item_refunds.order_item_refund_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_items.order_id ELSE NULL END) AS p2_refund_rt,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 3 THEN order_items.order_id ELSE NULL END) AS p3_orders,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 3 THEN order_item_refunds.order_item_refund_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_items.order_id ELSE NULL END) AS p3_refund_rt,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 4 THEN order_items.order_id ELSE NULL END) AS p4_orders,
        COUNT(DISTINCT CASE WHEN order_items.product_id = 4 THEN order_item_refunds.order_item_refund_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN order_items.product_id = 1 THEN order_items.order_id ELSE NULL END) AS p4_refund_rt
        FROM order_items LEFT JOIN order_item_refunds ON order_items.order_item_id = order_item_refunds.order_item_id
        WHERE order_items.created_at BETWEEN '2012-01-01' AND '2014-10-15'
        GROUP BY 1,2
        order by 1,2;
        
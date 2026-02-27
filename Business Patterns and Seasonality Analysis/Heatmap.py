import mysql.connector
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="xxx",
    database="mavenfuzzyfactory"
)

query = """
SELECT 
hours,
ROUND(AVG(CASE WHEN week_day = 0 THEN sessions END),1) AS 'Mon',
ROUND(AVG(CASE WHEN week_day = 1 THEN sessions END),1) AS 'Tue',
ROUND(AVG(CASE WHEN week_day = 2 THEN sessions END),1) AS 'Wed',
ROUND(AVG(CASE WHEN week_day = 3 THEN sessions END),1) AS 'Thu',
ROUND(AVG(CASE WHEN week_day = 4 THEN sessions END),1) AS 'Fri',
ROUND(AVG(CASE WHEN week_day = 5 THEN sessions END),1) AS 'Sat',
ROUND(AVG(CASE WHEN week_day = 6 THEN sessions END),1) AS 'Sun' FROM 
(SELECT date(created_at) AS date_,
WEEKDAY(created_at) AS week_day,
 HOUR(created_at) AS hours,
 COUNT(DISTINCT website_session_id) AS sessions FROM website_Sessions
 WHERE created_at BETWEEN '2012-09-15' AND '2012-11-15'
 GROUP BY date_,week_day,hours) t
 GROUP BY hours
 ORDER BY hours ASC;
"""

df = pd.read_sql(query, conn)
conn.close()

df = df.set_index("hours")
df = df[["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]]

plt.figure(figsize=(10,6))

sns.heatmap(
    df,
    annot=False,          # ❌ bỏ data label
    cmap="Blues",         # ✅ navy/blue theme
    linewidths=0.3
)

plt.title("Sessions Heatmap by Hour and Day")
plt.xlabel("Day of Week")
plt.ylabel("Hour of Day")

plt.show()

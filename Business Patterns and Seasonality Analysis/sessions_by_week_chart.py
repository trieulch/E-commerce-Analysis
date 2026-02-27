import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="xxx",
    database="mavenfuzzyfactory"
)

query = """
SELECT 
    STR_TO_DATE(CONCAT(YEARWEEK(ws.created_at), ' Monday'), '%X%V %W') AS week_start_date,
    COUNT(ws.website_session_id) AS sessions
FROM website_sessions ws
LEFT JOIN orders o 
    ON ws.website_session_id = o.website_session_id
GROUP BY week_start_date
ORDER BY week_start_date;
"""

df = pd.read_sql(query, conn)

navy = "#0B3D91"

plt.figure(figsize=(14,6))

plt.bar(
    df["week_start_date"],
    df["sessions"],
    color=navy,
    width=5
)

# clean styling
plt.grid(axis="y", linestyle="--", alpha=0.3)
plt.gca().set_axisbelow(True)

ax = plt.gca()
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

plt.title("Weekly Website Sessions", fontsize=16, weight="bold")
plt.xlabel("Week", fontsize=11)
plt.ylabel("Sessions", fontsize=11)

plt.xticks(rotation=45)

plt.tight_layout()
plt.show()

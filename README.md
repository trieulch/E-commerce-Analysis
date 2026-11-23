# E-Commerce Analytics | End-to-End SQL Business Analysis

## Overview

This project performs a comprehensive **end-to-end analysis of an e-commerce business** using **MySQL** and **Python**, replicating real-world analytical workflows used by Data Analysts in technology companies.

The dataset contains realistic transactional, behavioral, and marketing data, enabling deep analysis across:

- Traffic acquisition
- Website performance
- Conversion funnel optimization
- Marketing channel performance
- Product performance
- User retention
- Business growth and seasonality

---

## Information

- **Targeted Conversion Rate:** 4%
- **Cost Per Conversion:** 2

**Sales funnel**
/home → /products → /(product-name) → /cart → /shipping → /billing → /thanks

**4-product launch period**

- mrfuzzy
- lovebear
- birthday panda
- mini-bear

The goal is to answer stakeholder questions and generate insights to support **marketing, product, and executive decision-making**.

---

# Dataset Structure

- **website_sessions** — traffic source, device, and session information (500k+ rows)
- **website_pageviews** — user navigation behavior (1.3M+ rows)
- **orders** — transaction records
- **order_items** — product-level purchase details
- **order_items_refund** — product-level return details

---

# 1. Traffic Analysis & Optimization

## Top Traffic Sources

![Traffic Source](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/1_traffic_source_analysis.png)

The **gsearch / nonbrand** campaign contributes **97.4% of total traffic**, indicating it is the most significant acquisition source.

---

## Conversion Rates by Top Traffic Source

![Conversion Rate](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/2_traffic_source_analysis.png)

The conversion rate of **gsearch / nonbrand** is **2.96%**, which is below the **target 4%**.

---

## Conversion Rate, CPA & CPC by Device

![Device Performance](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/5_traffic_source_analysis.png)

Breaking gsearch / nonbrand performance down by device shows a large gap:

| Device | Conversion rate | CPA (cost per order) |
|---|---|---|
| Desktop | **3.73%** | **$53.62** |
| Mobile | 0.96% | $208.33 |

Desktop acquires an order at roughly **1/4 of the mobile cost**. Reallocating bid budget toward **desktop traffic** should improve marketing efficiency.

---

## Traffic Analysis for Bid Launch

![Bid Analysis](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/3_traffic_source_analysis.png)

Because gsearch / nonbrand converted below the **4%** threshold, the campaign was **bid down on 2012-04-15**. Weekly session volume fell by about **42.5%**, showing the campaign is highly sensitive to bid changes.

![Bid Launch Comparison](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/6_traffic_source_analysis.png)

The visualization compares **before bid launch (Pre)** and **after bid launch (Post)**.

---

# 2. Website Measurement & Testing

## Most Visited Pages

![Visited Pages](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/1_website_measurement_testing.png)

The first three pages capture the majority of sessions. Most users enter through **/home**.

---

## Bounce Rate Analysis

![Bounce Rate](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/3_website_measurement_testing.png)

The homepage shows a **59.18% bounce rate**, which is considered high.  
A **new landing page test** was proposed.

---

## Landing Page Test Results

![Landing Page Test](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/4_website_measurement_testing.png)

The experiment resulted in a **5.12% improvement in bounce rate**.

---

## Landing Page Trend

![Landing Page Trend](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/5_website_measurement_testing.png)

A noticeable traffic shift occurred after launching the new homepage.

Stable analysis period: **Week 25–30**

Bounce rate improved from:

**58.16% → 53.14% (≈5% improvement)**

---

![Traffic Shift](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/8_website_measurement_testing.png)

Traffic shift after homepage launch.

---

![Bounced Sessions](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/9_website_measurement_testing.png)

Bounced session trend.

---

![Bounce Rate Improvement](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/10_website_measurement_testing.png)

Bounce rate improvement after launch.

---

## Conversion Funnel

![Funnel](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/6_website_measurement_testing.png)

The **billing page** has the lowest conversion rate (**43.02%**), so a new page **billing-2** was introduced.

---

## Funnel Test Comparison

![Funnel Test](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/7_website_measurement_testing.png)

After a **2-month experiment**, conversion improved from:

**45.66% → 62.63%**

---

# 3. Channel Analysis & Optimization

## Channel Portfolio Trend by Traffic

![Traffic Trend](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/1_Channel_Analysis_Optimization.png?raw=true)

Weekly sessions from **week 34 to week 48**, with a major spike in **week 47 (Black Friday)**.

---

![Channel Trend](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/6_Channel_Analysis_Optimization.png?raw=true)

Trend and **week-over-week (WoW)** comparison of the two main channels.

---

## Channel Analysis by Mobile Device

![Mobile Traffic](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/2_Channel_Analysis_Optimization.png?raw=true)

Mobile share:

- **gsearch:** 24.52%
- **bsearch:** 8.62%

---

## Channel Analysis by Device Type

![Device Type](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/3_Channel_Analysis_Optimization.png?raw=true)

Overall, **gsearch outperforms bsearch**, leading to a slight **bid down on bsearch**.

---

![Channel Impact](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/4_Channel_Analysis_Optimization.png?raw=true)

After the bid down, **bsearch sessions decreased slightly**.

---

## Channel Portfolio Growth

![Channel Portfolio](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/5_Channel_Analysis_Optimization.png?raw=true)

Traffic growth appears not only in **nonbrand**, but also in:

- brand
- direct
- indirect

---

# 4. Business Patterns & Seasonality

## Business Performance Overview

![Business Overview](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Business%20Patterns%20and%20Seasonality%20Analysis/Result/1_Business_Patterns_And_Seasonality_Analysis.png)

![Sessions by Week](https://github.com/trieulch/E-commerce-Analysis/blob/main/Business%20Patterns%20and%20Seasonality%20Analysis/sessions_by_week.png?raw=true)

Year-over-year growth is consistent.

Major spikes appear during:

- **Black Friday**
- **Cyber Monday**

**Growth**

- Sessions ↑ **93.75%**
- Orders ↑ **157.19%**

---

## Correlation Analysis

![Correlation](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Business%20Patterns%20and%20Seasonality%20Analysis/Result/3_Business_Patterns_And_Seasonality_Analysis.png)

**R² = 0.4414**

This indicates a **moderate relationship between sessions and conversion rate**, though additional variables may influence this relationship.

---

## Business Pattern

![Business Pattern](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Business%20Patterns%20and%20Seasonality%20Analysis/Result/2_Business_Patterns_And_Seasonality_Analysis.png)

Traffic peaks between:

**9 AM – 5 PM on weekdays**

---

![Traffic Heatmap](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/main/Business%20Patterns%20and%20Seasonality%20Analysis/Heatmap_sesions_by_hour_day.png)

Heatmap of traffic distribution by **hour and weekday**.

---

# 5. Product-Level Analysis

## Product Sales

![Product Sales](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/1_Product_Level_Analysis.png)

Revenue and margin are growing at an average **29.21% MoM**.

---

![Product Launch](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/2_Product_Level_Analysis.png)

Although sales dipped slightly after launch, **revenue per session and conversion rate increased**.

---

## Product Launch Analysis

![Launch Impact](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/3_Product_Level_Analysis.png)

CTR for **mrfuzzy** decreased slightly after launching the new product.

---

![Product Funnel](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/4_Product_Level_Analysis.png)

The new product **lovebear** performs well in funnel conversion.

---

![Cross Sell](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/5_Product_Level_Analysis.png)

After adding **cross-selling at /cart**, both **AOV** and **revenue per cart session increased**.

---

![Third Product](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/6_Product_Level_Analysis.png)

All key metrics improved after launching the third product.

---

## Product Return Analysis

![Refund Rate](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Product%20Level%20Analysis/Results/7_Product_Level_Analysis.png)

In **Aug–Sep 2014**, Product 1 experienced an unusual **~14% refund rate**.

After validation with the operations team, the issue was identified as a **product quality malfunction**.

---

# 6. User-Level Analysis

![User Distribution](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/User%20Level%20Analysis/Results/1_User_Level_Analysis.png)

Total users: **145,900**

User distribution:

| Repeat sessions | Users | Share |
|---|---|---|
| 0 (no return) | 126,813 | 86.92% |
| 1 | 14,086 | 9.65% |
| 2 | 315 | 0.22% |
| 3 | 4,686 | 3.21% |

About **13% of new users come back** at least once within the period.

---

![Session Duration](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/User%20Level%20Analysis/Results/2_User_Level_Analysis.png)

Time from a user's first session to their first repeat session:

- **Min:** 1 day
- **Max:** 69 days
- **Average:** 33.2 days

Users who return typically do so about **one month** after their first visit, which suggests a natural window for retention campaigns (e.g. email reminders around day 25–30).

---

![User Channels](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/User%20Level%20Analysis/Results/3_User_Level_Analysis.png)

Most new sessions come from **paid_nonbrand**, indicating strong marketing performance.

Repeat sessions are dominated by:

- direct_type_in
- organic_search
- paid_brand

---

![Returning Users](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/User%20Level%20Analysis/Results/4_User_Level_Analysis.png)

Returning users are more valuable than new users (2014):

| Session type | Conversion rate | Revenue per session |
|---|---|---|
| New | 6.80% | $4.34 |
| Repeat | **8.11%** | **$5.17** |

Repeat sessions convert **1.31 percentage points higher** and generate **~19% more revenue per session**, and they arrive mostly through low-cost channels (direct, organic, paid brand). This supports investing in retention alongside paid acquisition.
---

# Business Questions and Answers

## Q1
Monthly Gsearch sessions and orders  
![Q1](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q1.png)

## Q2
Brand vs Non-brand performance  
![Q2](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q2.png)

## Q3
Device-level performance  
![Q3](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q3.png)

## Q4
Channel diversification  
![Q4](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q4.png)

## Q5
Conversion rate improvement  
![Q5](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q5.png)

## Q6
Landing page experiment revenue impact  
![Q6](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q6.png)

![Q6-1](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q6_1.png)

## Q7
Conversion funnel experiment  
![Q7](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q7.png)

![Q7-1](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q7_1.png)

## Q8
Billing page experiment impact  
![Q8](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q8.png)

## Q9
Quarterly growth trend  
![Q9](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q9.png)

## Q10
Efficiency metrics  
![Q10](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q10.png)

## Q11
Channel growth  
![Q11](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q11.png)

## Q12
Channel conversion rate trend  
![Q12](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q12.png)

## Q13
Product revenue trends  
![Q13](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q13.png)

## Q14
Product page performance  
![Q14](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q14.png)

![Q14-1](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q14_1.png)

## Q15
Cross-sell performance  
![Q15](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q15.png)

---

# Skills Demonstrated

SQL  
Data Analysis  
Funnel Analysis  
A/B Testing Analysis  
Marketing Analytics  
Product Analytics  
Business Intelligence  

---

# Author

Lê Chí Hoàng Triều  

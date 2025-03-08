The content for e-commerce analysis in MySQL  
The dataset from MavenAnalytics(which you can find on some published sources) has a common content and structure with other e-commerce datasets.  
I noted what I analyzed in mysql files.  
The content of analysis is included all theses segment below:  
- **Traffic Analysis & Optimization**: Identify top traffic sources, measure their conversion rates, analyze trends, and use segmentation for bidding optimization  
> Finding Top Traffic Source:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/1_traffic_source_analysis.png)  
> Traffic Source Conversion Rates:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/2_traffic_source_analysis.png)  
> Traffic Source Trending:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/3_traffic_source_analysis.png)  
> Trending w/ Granualar Segments:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Traffic%20Analysis%20%26%20Optimization/Results/4_traffic_source_analysis.png)  
- **Website Measurement & Testing**: Find the most-visited pages and top entry pages, calculate bounce rates, build conversion funnels, and analyze tests  
> Finding Top Website Pages:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/1_website_measurement_testing.png)  
> Finding Top Entry Pages:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/2_website_measurement_testing.png)  
> Calculating Bounced Rates:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/3_website_measurement_testing.png)  
> Analyzing Landing Page Tests:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/4_website_measurement_testing.png)  
> Landing Page Trend Analysis:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/5_website_measurement_testing.png)  
> Building Conversion Funnels:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/6_website_measurement_testing.png)  
> Analyzing Conversion Funnel Tests:  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/Website%20Measurement%20%26%20Testing/Results/7_website_measurement_testing.png)  
- **Channel Analysis & Optimization**: Compare marketing channels, understand relative performance, optimize a channel portfolio, and analyze trends
> Analyzing Channel Portfolios:  
![Alt text](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/1_Channel_Analysis_Optimization.png)  
> Comparing Channel Characteristics:  
![Alt text](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/2_Channel_Analysis_Optimization.png)  
> Cross-Channel Bid Optimization:  
![Alt text](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/3_Channel_Analysis_Optimization.png)  
> Analyzing Channel Portfolio:  
![Alt text](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/4_Channel_Analysis_Optimization.png)  
> Analyzing Direct Traffic:  
![Alt text](https://github.com/trieulch/E-commerce-Analysis/blob/main/Channel%20Analysis%20%26%20Optimization/Result/5_Channel_Analysis_Optimization.png)  
- **Product-Level Analysis**: Analyze sales, build product-level conversion funnels, learn about cross-selling, and measure the impact of launching new products  
- **User-Level Analysis**: Learn about behaviors of repeat visitors and purchasers, and compare new and repeat visitor website conversion patterns  
  
Questions:
- **Q1**: Gsearch seems to be the biggest driver of our business. Could you pull monthly trends for gsearch sessions 
and orders so that we can showcase the growth there?  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q1.png)  
- **Q2**: Next, it would be great to see a similar monthly trend for Gsearch, but this time splitting out nonbrand and 
brand campaigns separately. I am wondering if brand is picking up at all. If so, this is a good story to tell.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q2.png)  
- **Q3**: While we’re on Gsearch, could you dive into nonbrand, and pull monthly sessions and orders split by device 
type? I want to flex our analytical muscles a little and show the board we really know our traffic sources.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q3.png)  
- **Q4**: I’m worried that one of our more pessimistic board members may be concerned about the large % of traffic from 
Gsearch. Can you pull monthly trends for Gsearch, alongside monthly trends for each of our other channels?  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q4.png)  
- **Q5**: I’d like to tell the story of our website performance improvements over the course of the first 8 months. 
Could you pull session to order conversion rates, by month?  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q5.png)  
- **Q6**: For the gsearch lander test, please estimate the revenue that test earned us. Period: (Jun 19 – Jul 28)  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q6.png)  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q6_1.png)  
- **Q7**: For the landing page test you analyzed previously, it would be great to show a full conversion funnel from each 
of the two pages to orders. Period: (Jun 19 – Jul 28)  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q7.png)  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q7_1.png)  
- **Q8**: I’d love for you to quantify the impact of our billing test, as well. Please analyze the lift generated from the test 
(Sep 10 – Nov 10), in terms of revenue per billing page session, and then pull the number of billing page sessions 
for the past month to understand monthly impact  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q8.png)  
- **Q9**: First, I’d like to show our volume growth. Can you pull overall session and order volume, trended by quarter 
for the life of the business? Since the most recent quarter is incomplete, you can decide how to handle it.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q9.png)  
- **Q10**: Next, let’s showcase all of our efficiency improvements. I would love to show quarterly figures since we 
launched, for session-to-order conversion rate, revenue per order, and revenue per session.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q10.png)  
- **Q11**: I’d like to show how we’ve grown specific channels. Could you pull a quarterly view of orders from Gsearch 
nonbrand, Bsearch nonbrand, brand search overall, organic search, and direct type-in?  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q11.png)  
- **Q12**: Next, let’s show the overall session-to-order conversion rate trends for those same channels, by quarter. 
Please also make a note of any periods where we made major improvements or optimizations.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q12.png)  
- **Q13**: We’ve come a long way since the days of selling a single product. Let’s pull monthly trending for revenue 
and margin by product, along with total sales and revenue. Note anything you notice about seasonality.  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q13.png)  
**Q14**: Let’s dive deeper into the impact of introducing new products. Please pull monthly sessions to the /products 
page, and show how the % of those sessions clicking through another page has changed over time, along with 
a view of how conversion from /products to placing an order has improved  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q14.png)  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q14_1.png)  
- **Q15**: We made our 4th product available as a primary product on December 05, 2014 (it was previously only a cross-sell 
item). Could you please pull sales data since then, and show how well each product cross-sells from one another?  
![Alt text](https://raw.githubusercontent.com/trieulch/E-commerce-Analysis/refs/heads/main/results/Q15.png)  

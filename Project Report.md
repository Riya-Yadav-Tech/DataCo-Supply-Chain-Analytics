📊 DataCo Supply Chain Analytics — Project Analysis
1. Project Overview

This project analyzes the DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS dataset to understand the company's financial performance, delivery operations, customer behavior, market performance, and product profitability.

The analysis was performed using SQL Server and Power BI, with the final analysis presented through four focused dashboards.

Dataset Source: Kaggle – DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS

2. What I Analyzed
Business Area	What I Analyzed	
💰 Financial Performance:	Revenue, profit, orders, profit margin	
🚚 Delivery Performance:	Late orders, delivery %, delay, shipping modes
🌍 Market Performance:	Revenue by market and region	
👥 Customer Performance	:Customer segments, cities, revenue	
📦 Product Performance:	Product/category revenue and profit	I
📈 Trends:	Monthly revenue, profit and delivery trends	

3. Dashboard Analysis

Dashboard 1 — Supply Chain Executive Dashboard
ROLE: This dashboard provides a high-level overview of the entire business.
It answers:How is the supply chain performing overall?

Key Insights:
54.82% of orders were late, making delivery performance the biggest operational concern.
Europe generated ₹10.87M (29.56%), the highest market revenue.
LATAM generated ₹10.28M (27.94%), making it the second-largest market.
Fishing generated approximately ₹6.9M revenue, the highest displayed product-category revenue.

Business Action:
The business should maintain its strong revenue performance while prioritizing delivery reliability and operational efficiency.

Dashboard 2 — Delivery & Logistics Performance
ROLE:This dashboard focuses specifically on where and how delivery problems are occurring.
It answers:Which shipping methods and regions have the greatest delivery risk?

Key Insights:
Standard Class had the highest number of late orders: 14.6K.
Second Class and First Class had approximately 9.5K and 9.4K late orders respectively.
Central Africa had the highest displayed late-delivery rate: 57.55%.
East Africa followed at 56.77%.
South Asia followed at 56.11%.
Western Europe had the highest displayed number of late orders by region at 5.6K.

Business Action:
Investigate high-risk regions, shipping processes and carrier performance to reduce late deliveries.
Important: Standard Class has the highest number of late orders, but this does not automatically mean it has the worst rate.
Order volume should also be considered.

Dashboard 3 — Customer & Market Analysis
ROLE:This dashboard explains who generates the revenue and where the revenue comes from.
It answers:Which customers, markets and cities are most valuable?

Key Insights:
Consumer customers generated 51.89% of orders.
Corporate customers generated 30.20%.
Home Office generated 17.91%.
Consumer customers generated approximately ₹19M revenue.
Europe contributed 29.56% of total revenue.
LATAM contributed 27.94%.
Caguas generated approximately ₹13.61M, significantly higher than the other displayed cities.

Business Action:
Focus customer strategies on the Consumer segment, protect major markets such as Europe and LATAM, 
and investigate the unusually high revenue concentration in Caguas.

Dashboard 4 — Product & Profitability Analysis
ROLE:This dashboard focuses on which products and categories actually generate profit, rather than just revenue.
It answers:Which products are driving sales and profitability?

Key Insights:
Fishing generated approximately ₹0.76M profit, the highest displayed category.
Cleats generated approximately ₹0.49M.
Field & Stream generated approximately ₹6.9M revenue.
Field & Stream also generated approximately ₹0.76M profit.
USCA had the highest displayed market profit margin at 11.14%.
Pacific Asia had the lowest displayed market margin at 10.37%.
The difference between the highest and lowest displayed market margin was only 0.77 percentage points.

Business Action:
Prioritize high-profit products and categories, while monitoring revenue and margin together rather than relying on sales alone.

4. Overall Insights

After combining all four dashboards, the major findings are:
💰 Strong Financial Performance
The business generated approximately:
₹36.78M Revenue → ₹3.97M Profit → 10.78% Profit Margin

🚚 Delivery Is the Major Problem
54.82% of orders were late, while on-time delivery was only around 45%.
This is the clearest operational improvement opportunity.

🌍 Revenue Is Concentrated
Europe and LATAM together contribute approximately 57.5% of total revenue.

👥 Consumers Are the Largest Customer Group
Consumers account for 51.89% of orders and approximately ₹19M revenue.

📦 A Few Products Drive Significant Value
Field & Stream generated approximately ₹6.9M revenue and ₹0.76M profit.

⚠️ Geographic Concentration Needs Investigation

Caguas generated approximately ₹13.61M, which is substantially higher than the other displayed cities.
This should be investigated before making strategic decisions.

5. Business Recommendations

Based on the analysis, the business should:
Improve delivery reliability and reduce the 54.82% late-delivery rate.
Investigate high-risk regions, particularly Central Africa, East Africa and South Asia.
Evaluate shipping modes using both late-order volume and late-delivery percentage.
Protect high-value markets, particularly Europe and LATAM.
Focus on high-profit products and categories such as Fishing and Field & Stream.
Strengthen Consumer-segment strategies, as Consumers represent the largest order share.
Investigate the unusual Caguas revenue concentration to understand its business and data implications.

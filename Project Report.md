# 📊 DataCo Supply Chain Analytics — Project Report

## 1. Project Overview

This project analyzes the **DataCo Smart Supply Chain for Big Data Analysis** dataset to understand the company's financial performance, delivery operations, customer behavior, market performance and product profitability.

The analysis was done in **SQL Server** (data preparation and business queries) and **Power BI** (DAX measures and dashboards). The results are presented in **four focused dashboards**.

**Dataset source:** [Kaggle – DataCo Smart Supply Chain for Big Data Analysis](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)

> All currency values are in **US Dollars ($)**, as in the original dataset.

---

## 2. What I Analyzed

| Business Area | What I Analyzed |
|---|---|
| 💰 Financial Performance | Revenue, profit, orders, profit margin |
| 🚚 Delivery Performance | Late orders, late-delivery %, delays, shipping modes |
| 🌍 Market Performance | Revenue by market and region |
| 👥 Customer Performance | Customer segments, cities, revenue |
| 📦 Product Performance | Product and category revenue and profit |
| 📈 Trends | Monthly revenue, profit and delivery trends |

---

## 3. Dashboard Analysis

### Dashboard 1 — Supply Chain Executive Dashboard

**Purpose:** A high-level overview of the whole business.
**Question it answers:** *How is the supply chain performing overall?*

**Key insights**
- **54.82%** of orders were delivered late, making delivery performance the biggest operational concern.
- **Europe** generated **$10.87M (29.56%)**, the highest revenue of any market.
- **LATAM** generated **$10.28M (27.94%)**, the second-largest market.
- **Fishing** was the top product category, with about **$6.9M** in revenue.

**Business action:** Maintain strong revenue performance while making delivery reliability and operational efficiency the top priority.

---

### Dashboard 2 — Delivery & Logistics Performance

**Purpose:** Shows where and how delivery problems occur.
**Question it answers:** *Which shipping modes and regions carry the highest delivery risk?*

**Key insights**

| Shipping Mode | Late Orders |
|---|---|
| Standard Class | 14.6K |
| Second Class | ~9.5K |
| First Class | ~9.4K |

| Region | Late-Delivery Rate |
|---|---|
| Central Africa | 57.55% |
| East Africa | 56.77% |
| South Asia | 56.11% |

- **Western Europe** had the highest **number** of late orders of any region (**5.6K**).

**Business action:** Investigate high-risk regions, shipping processes and carrier performance to reduce late deliveries.

> ⚠️ **Note:** Standard Class has the most late orders, but it also handles the most orders. A high **count** does not automatically mean a high **rate**, so shipping modes should be compared using both late-order volume and late-delivery percentage.

---

### Dashboard 3 — Customer & Market Analysis

**Purpose:** Shows who generates revenue and where it comes from.
**Question it answers:** *Which customers, markets and cities are most valuable?*

**Key insights**

| Customer Segment | Share of Orders |
|---|---|
| Consumer | 51.89% |
| Corporate | 30.20% |
| Home Office | 17.91% |

- **Consumer** customers generated about **$19M** in revenue.
- **Europe (29.56%)** and **LATAM (27.94%)** together contributed about **57.5%** of total revenue.
- **Caguas** generated about **$13.61M**, far more than any other city.

**Business action:** Focus customer strategy on the Consumer segment, protect the Europe and LATAM markets, and investigate the unusually high revenue concentration in Caguas.

---

### Dashboard 4 — Product & Profitability Analysis

**Purpose:** Shows which products and categories actually generate **profit**, not just revenue.
**Question it answers:** *Which products drive sales and profitability?*

**Key insights**
- **Fishing** was the most profitable category, with about **$0.76M** profit.
- **Cleats** followed with about **$0.49M** profit.
- **Field & Stream** was the top product, with about **$6.9M** revenue and **$0.76M** profit.

| Market | Profit Margin |
|---|---|
| USCA (highest) | 11.14% |
| Pacific Asia (lowest) | 10.37% |

- The gap between the highest and lowest market margin was only **0.77 percentage points**, so margins are fairly even across markets.

**Business action:** Prioritize high-profit products and categories, and track revenue and margin together instead of relying on sales alone.

---

## 4. Overall Insights

| Area | Finding |
|---|---|
| 💰 Financial | **$36.78M** revenue → **$3.97M** profit → **10.78%** profit margin |
| 🚚 Delivery | **54.82%** of orders were late; only about **45%** were not late. This is the clearest improvement opportunity. |
| 🌍 Markets | Europe and LATAM together contribute about **57.5%** of revenue. |
| 👥 Customers | Consumers account for **51.89%** of orders and about **$19M** revenue. |
| 📦 Products | Field & Stream alone generated about **$6.9M** revenue and **$0.76M** profit. |
| ⚠️ Geography | Caguas generated about **$13.61M**, much higher than other cities. This should be checked before making strategic decisions. |

---

## 5. Business Recommendations

1. **Improve delivery reliability** and reduce the 54.82% late-delivery rate.
2. **Investigate high-risk regions**, especially Central Africa, East Africa and South Asia.
3. **Evaluate shipping modes** using both late-order volume and late-delivery percentage.
4. **Protect high-value markets**, especially Europe and LATAM.
5. **Focus on high-profit categories** such as Fishing and products such as Field & Stream.
6. **Strengthen Consumer-segment strategies**, since Consumers are the largest order share.
7. **Investigate the Caguas revenue concentration** to understand whether it reflects real business activity or a data issue.

---

## 6. Tools Used

**SQL Server** · **Power BI** · **DAX** · **Microsoft Excel**

---

**Author:** Riya Yadav | B.Tech, Production & Industrial Engineering, NIT Jamshedpur

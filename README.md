# 📊 DataCo Supply Chain Analytics

[![View Dashboards](https://img.shields.io/badge/📈_View-Power_BI_Dashboards-F2C811?style=for-the-badge)](DATACO%20SUPPLY%20CHAIN%20DATASET.pdf)
[![Project Report](https://img.shields.io/badge/📄_Read-Project_Report-0A66C2?style=for-the-badge)](Project%20Report.md)

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-6B46C1?style=flat-square)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat-square&logo=microsoftexcel&logoColor=white)

An end-to-end supply chain analytics project using **SQL Server** and **Power BI** to analyze revenue, profitability, delivery performance, customers, products and markets in the DataCo supply chain dataset.

---

## 🔑 Key Results at a Glance

| KPI | Value |
|---|---|
| Total Orders | **65.75K** |
| Total Revenue | **$36.78M** |
| Total Profit | **$3.97M** |
| Profit Margin | **10.78%** |
| On-Time Delivery | **45.18%** |
| Late Orders | **~36K (54.82%)** |
| Total Customers | **21K** |
| Average Order Value | **$559.45** |

**Main finding:** More than half of all orders (**54.82%**) were delivered late. Delivery reliability, not revenue, is the company's biggest operational problem.

---

## 🎯 Business Objectives

- Analyze overall revenue and profitability
- Evaluate delivery and logistics performance
- Identify late-delivery patterns by shipping mode and region
- Analyze customer segments and markets
- Identify high-performing products and categories
- Track revenue and profit trends over time
- Support data-driven supply chain decisions

---

## 📈 Dashboards

The analysis is presented in **four Power BI dashboards** (see `DATACO SUPPLY CHAIN DATASET.pdf`):

| # | Dashboard | Question it answers |
|---|---|---|
| 1 | Supply Chain Executive | How is the supply chain performing overall? |
| 2 | Delivery & Logistics Performance | Which shipping modes and regions carry the highest delivery risk? |
| 3 | Customer & Market Analysis | Which customers, markets and cities are most valuable? |
| 4 | Product & Profitability | Which products and categories drive profit, not just revenue? |

---

## 💡 Key Insights

- 🚚 **Delivery:** Central Africa (**57.55%**), East Africa (**56.77%**) and South Asia (**56.11%**) had the highest late-delivery rates. Standard Class had the most late orders (**14.6K**).
- 🌍 **Markets:** Europe (**29.56%**) and LATAM (**27.94%**) together generate about **57.5%** of revenue.
- 👥 **Customers:** The Consumer segment places **51.89%** of orders and brings about **$19M** in revenue.
- 📦 **Products:** Fishing is the most profitable category (**$0.76M** profit), driven by the Field & Stream product (**$6.9M** revenue).
- 💰 **Margins:** Market profit margins are close together, from **10.37%** (Pacific Asia) to **11.14%** (USCA).

👉 Full analysis and recommendations: **[Project Report](Project%20Report.md)**

---

## 🛠️ Tools & Technologies

| Tool | Used for |
|---|---|
| **SQL Server** | Data preparation, validation, analysis and business queries |
| **Power BI** | Interactive dashboards and data visualization |
| **DAX** | KPI and business measure creation |
| **Microsoft Excel** | Data handling and supporting analysis |

---

## 🔄 Project Workflow

1. **Data loading** – Imported the Kaggle dataset into SQL Server
2. **Data validation** – Checked total records, columns, date range and duplicate order IDs
3. **Business analysis** – Wrote SQL queries for revenue, profit, delivery and customer questions
4. **KPI creation** – Built DAX measures for revenue, profit margin, on-time delivery % and delay days
5. **Dashboards** – Built four Power BI dashboards with filters for date, market, region, shipping mode and segment
6. **Insights** – Summarized findings and business recommendations in the project report

---

## 📁 Project Structure

```
DataCo-Supply-Chain-Analytics/
│
├── SUPPLY CHAIN DATA CO.sql           # SQL queries (validation + analysis)
├── DATACO SUPPLY CHAIN DATASET.pdf    # Power BI dashboards (4 pages)
├── Project Report.md                  # Full analysis and recommendations
└── README.md
```

---

## 📂 Dataset

**DataCo Smart Supply Chain for Big Data Analysis** (Kaggle). It covers orders, customers, products, sales, shipping, delivery status, markets, regions and customer segments from **2015 to 2018**. All currency values are in **US Dollars ($)**.

**Source:** [Kaggle – DataCo Smart Supply Chain for Big Data Analysis](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)

---

## 👩‍💻 Author

**Riya Yadav** | B.Tech, Production & Industrial Engineering, NIT Jamshedpur
[LinkedIn](https://www.linkedin.com/in/riya-yadav-2b5688378) · [GitHub](https://github.com/Riya-Yadav-Tech)

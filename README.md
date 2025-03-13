# 🏦 Bank Loan Report  

## 📌 Table of Contents  
- [Overview](#overview)  
- [Dataset](#dataset)  
- [Problem Statement](#problem-statement)  
- [Tableau Dashboard](#tableau-dashboard)  
- [Key Performance Indicators (KPIs)](#key-performance-indicators-kpis)  
- [SQL Queries](#sql-queries)  
- [Expected Outcomes](#expected-outcomes)  
- [Recommendations](#recommendations)  
- [Tools Used](#tools-used)  

---

## 📊 Overview  

The **Bank Loan Report** is designed to monitor and assess **lending activities and performance**. This report provides insights into **loan applications, funding amounts, interest rates, debt-to-income ratios, and loan statuses**. It enables data-driven decision-making by analyzing **trends, borrower behavior, and loan health**.

📌 **Key Insights:**  
- Track **total loan applications**, **funded amounts**, and **repayments**.  
- Identify **loan trends** based on region, term, and borrower profile.  
- Distinguish between **Good Loans (Fully Paid, Current)** and **Bad Loans (Charged Off)**.  
- Assess borrower **employment length, homeownership, and loan purpose**.  

---

## 📂 Dataset  

📥 **Download Data**: [`financial_loan.csv`](./financial_loan.csv)  

**Columns Include:**  
- `Id` – Unique loan identifier  
- `Purpose` – Reason for loan (Debt Consolidation, Credit Card, etc.)  
- `Home_Ownership` – Borrower’s home status (Rent, Mortgage, Own)  
- `Grade` – Loan grading system  
- `Issue_Date` – Date the loan was issued  
- `Installment` – Monthly installment amount  
- `Interest_Rate` – Loan interest rate  
- `Loan_Amount` – Loan principal amount  
- `Total_Payment` – Total repayment amount  

---

## ❓ Problem Statement  

Banks and financial institutions issue loans to borrowers for various purposes such as **debt consolidation, home improvement, medical expenses, and small businesses**. However, managing loan portfolios and minimizing **default risk** is a major challenge.  

📌 **Key Problems:**  
- How can we **identify high-risk borrowers** before loan approval?  
- What factors influence **loan repayment success** and **default rates**?  
- Which loan purposes have the **highest risk of default**?  
- How do **homeownership, employment length, and income level** affect loan performance?  
- How can banks **optimize loan approval processes** and **improve overall profitability**?  

By analyzing past loan data, this project aims to provide **actionable insights** that help financial institutions **improve lending decisions, reduce defaults, and increase loan recovery rates**.

---

## 📊 Tableau Dashboard  

### **Summary Dashboard**  
📊 Provides an overview of **loan performance**, including **good vs. bad loans** and **loan status breakdown**.  
![Summary Dashboard](./Summary.png)  

### **Overview Dashboard**  
📍 Displays **loan trends by month, region, term, employment length, and purpose**.  
![Overview Dashboard](./Overview1.png)  

### **Details Dashboard**  
📋 Presents a **detailed loan dataset**, allowing users to filter by **purpose, grade, and verification status**.  
![Details Dashboard](./Details.png)  

---

## 📈 Key Performance Indicators (KPIs)  

### **Loan Portfolio Metrics**  
- **Total Loan Applications** 📊  
- **Total Funded Amount** 💰  
- **Total Amount Received** ✅  
- **Average Interest Rate** 📉  
- **Average Debt-to-Income Ratio (DTI)**  

### **Good Loan vs. Bad Loan KPIs**  
✔ **Good Loans** (Fully Paid, Current)  
❌ **Bad Loans** (Charged Off)  

✔ **Good Loan Funded Amount vs. Received Amount**  
❌ **Bad Loan Funded Amount vs. Received Amount**  

✔ **Good Loan Application Percentage**  
❌ **Bad Loan Application Percentage**  

---

## 💾 SQL Queries  

### **1. Loan Portfolio Metrics**  
```sql
SELECT COUNT(*) AS Total_Loan_Applications FROM bank_loans;
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loans;
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loans;
SELECT AVG(interest_rate) AS Average_Interest_Rate FROM bank_loans;
SELECT AVG(loan_amount) / AVG(total_payment) AS Average_DTI FROM bank_loans;
```

### **2. Loan Trends by Month**  
```sql
SELECT MONTH(issue_date) AS Month, COUNT(*) AS Total_Applications 
FROM bank_loans 
GROUP BY Month 
ORDER BY Month;
``` 
### 3. Loan Applications by Purpose
```sql
SELECT purpose, COUNT(*) AS Total_Applications, SUM(loan_amount) AS Funded_Amount
FROM bank_loans 
GROUP BY purpose 
ORDER BY Funded_Amount DESC;
```
### 4. Good vs. Bad Loans
```sql
SELECT 
    (COUNT(CASE WHEN grade IN ('A', 'B') THEN id END) * 100.0 / COUNT(*)) AS Good_Loan_Percentage,
    (COUNT(CASE WHEN grade IN ('C', 'D', 'E') THEN id END) * 100.0 / COUNT(*)) AS Bad_Loan_Percentage
FROM bank_loans;
```
## 🎯 Expected Outcomes  

✔ **Understand loan trends** based on **monthly applications, funding, and repayments**.  
✔ **Identify high-risk loans** by analyzing **interest rates, DTI, and repayment behavior**.  
✔ **Optimize lending decisions** using **Good Loan vs. Bad Loan classification**.  
✔ **Improve marketing strategies** based on **loan purpose and borrower demographics**.  

---

## 🔹 Recommendations  

### 📌 **Reduce Loan Default Risk**  
- Stricter **eligibility criteria** for high-risk borrowers.  
- Improve **loan collection processes** to minimize defaults.  

### 📌 **Increase Loan Approvals for Low-Risk Borrowers**  
- Target **good credit score applicants** with **lower interest rates**.  
- Offer **incentives for early repayments** to improve cash flow.  

### 📌 **Optimize Loan Marketing Strategies**  
- Promote loans **based on borrower needs** *(Debt Consolidation, Home Improvement)*.  
- Use **regional analysis** to identify **high-loan-demand states**.
- 
## 🛠 Tools Used  

- **MySQL** – Data storage, queries, and trend analysis  
- **Tableau** – Interactive dashboard visualization  
- **Excel** – Data cleaning and preprocessing  



SELECT * FROM BankLoanDB.financial_loan;

-- Total loan applications, it is essential to monitor the Month-to-Date (MTD) Loan Applications and track changes Month-over-Month (MoM)

SELECT COUNT(id) AS Total_Loan_Applications FROM BankLoanDB.financial_loan;

ALTER TABLE BankLoanDB.financial_loan
ADD COLUMN new_date_col DATE; 

UPDATE BankLoanDB.financial_loan
SET new_date_col = STR_TO_DATE(issue_date, '%d-%m-%Y')
WHERE issue_date IS NOT NULL 
AND issue_date <> '' ;

SELECT issue_date, new_date_col FROM BankLoanDB.financial_loan;

ALTER TABLE BankLoanDB.financial_loan
DROP COLUMN issue_date;

ALTER TABLE BankLoanDB.financial_loan
CHANGE new_issue_date issue_date VARCHAR(50);


SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT COUNT(id) AS PMTD_Total_Loan_Applications FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 11	 AND YEAR(issue_date) = 2021;

-- Total funded amount (MTD and PMTD)

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Amount Received (MTD and PMTD)
SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average Interest Rate (MTD and PMTD)
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_AVG_Interest_Rate FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_AVG_Interest_Rate FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average Debt-to-Income Ratio (DTI)
SELECT ROUND(AVG(dti), 4) * 100 AS MTD_DTI_Ratio FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(dti), 4) * 100 AS PMTD_DTI_Ratio FROM BankLoanDB.financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Good Loan Application Percentage
SELECT 	ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) *100) / COUNT(loan_status)) AS Good_Loan_Percentage
FROM BankLoanDB.financial_loan;

-- Good Loan Applications
SELECT 	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)) AS Good_Loan_Application
FROM BankLoanDB.financial_loan;

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Application FROM BankLoanDB.financial_loan 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' ;

-- Good Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Total_Payment FROM BankLoanDB.financial_loan 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' ;

-- Bad Loan Application Percentage
SELECT ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100 / COUNT(id)) AS Bad_Loan_Percentage FROM BankLoanDB.financial_loan;

-- Bad Loan Applications
SELECT COUNT(loan_status) FROM BankLoanDB.financial_loan 
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) FROM BankLoanDB.financial_loan 
WHERE loan_status = 'Charged Off';

-- Bad Loan Total Received Amount
SELECT SUM(total_payment) FROM BankLoanDB.financial_loan 
WHERE loan_status = 'Charged Off';

-- Loan Status
SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Application,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        BankLoanDB.financial_loan 
    GROUP BY
        loan_status;
        
        -- Loan Status MTD
        
        SELECT
        loan_status,
        SUM(total_payment) AS MTD_Total_Amount_Received,
        SUM(loan_amount) AS MTD_Total_Funded_Amount
        FROM
        BankLoanDB.financial_loan 
        WHERE 
        MONTH(issue_date) = 12
    GROUP BY
        loan_status;
        
   -- Loan status by month
   SELECT 
   MONTH(issue_date) AS Months,
   MONTHNAME(issue_date) AS Monthname,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
   ORDER BY MONTH(issue_date), MONTHNAME(issue_date);
   
-- Loan status by State
SELECT 
   address_state,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY address_state
   ORDER BY Loan_Amount DESC;
   
   -- Loan status by term
   SELECT
    term,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY term
   ORDER BY term;
   
   -- Loan status by employment length
   SELECT
    emp_length,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY emp_length
   ORDER BY emp_length;
   
   -- Loan status by purpose
      SELECT
    purpose,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY purpose
   ORDER BY Total_Applications DESC;
   
   -- Loan status by homeowner
   SELECT
    home_ownership,
   COUNT(id) AS Total_Applications,
   SUM(loan_amount) AS Loan_Amount ,
   SUM(total_payment) AS Loan_received
   FROM BankLoanDB.financial_loan 
   GROUP BY home_ownership
   ORDER BY Total_Applications DESC
   
   
   
   
   








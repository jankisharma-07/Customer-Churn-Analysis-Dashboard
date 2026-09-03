-- CUSTOMER CHURN ANALYSIS PROJECT
-- SQL ANALYSIS

-- 1. DATABASE SETUP

CREATE DATABASE IF NOT EXISTS customer_churn_db;
USE customer_churn_db;

-- 2. TABLE CREATION

CREATE TABLE IF NOT EXISTS customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    TenureGroup VARCHAR(20),
    tenure INT,
    PhoneService VARCHAR(20),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(10)
);


-- 3. DATA CLEANING

-- Remove carriage return characters from Churn values
UPDATE customer_churn
SET Churn = REPLACE(Churn, CHAR(13), '');


-- 4. BASIC CUSTOMER METRICS

-- 4.1 Total Customers

SELECT COUNT(*) AS Total_Customers
FROM customer_churn;


-- 4.2 Churned Customers

SELECT COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE Churn = 'Yes';


-- 4.3 Retained Customers

SELECT COUNT(*) AS Retained_Customers
FROM customer_churn
WHERE Churn = 'No';

-- 5. CHURN & RETENTION ANALYSIS

-- 5.1 Churn Rate

SELECT
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn;


-- 5.2 Retention Rate

SELECT
    ROUND(
        SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Retention_Rate_Percent
FROM customer_churn;

-- 6. CUSTOMER DEMOGRAPHICS

-- 6.1 Churn by Gender

SELECT
    gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY gender
ORDER BY Churn_Rate_Percent DESC;


-- 6.2 Churn by Senior Citizen

SELECT
    SeniorCitizen,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY SeniorCitizen
ORDER BY Churn_Rate_Percent DESC;


-- 6.3 Churn by Dependents

SELECT
    Dependents,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY Dependents
ORDER BY Churn_Rate_Percent DESC;


-- 7. SUBSCRIPTION BEHAVIOUR

-- 7.1 Churn by Contract

SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;


-- 7.2 Churn by Internet Service

SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY InternetService
ORDER BY Churn_Rate_Percent DESC;


-- 7.3 Churn by Payment Method

SELECT
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate_Percent DESC;


-- 8. CHURN INDICATORS & CUSTOMER SEGMENTATION

-- 8.1 Churn by Tenure Group

SELECT
    TenureGroup,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY TenureGroup
ORDER BY
    CASE TenureGroup
        WHEN '0-1 Year' THEN 1
        WHEN '1-2 Years' THEN 2
        WHEN '2-4 Years' THEN 3
        WHEN '4+ Years' THEN 4
    END;


-- 8.2 Monthly Charges vs Churn

SELECT
    Churn,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM customer_churn
GROUP BY Churn;


-- 8.3 Churn by Tech Support

SELECT
    TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM customer_churn
GROUP BY TechSupport
ORDER BY Churn_Rate_Percent DESC;

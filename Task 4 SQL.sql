
-- Creating Table
CREATE TABLE ecommerce_data (
    OrderID INTEGER,
    CustomerName TEXT,
    State TEXT,
    Category TEXT,
    SubCategory TEXT,
    ProductName TEXT,
    Quantity INTEGER,
    Amount FLOAT,
    PaymentMode TEXT,
    OrderDate DATE
);

-- Total Sales by State
SELECT State, SUM(Amount) AS TotalSales
FROM ecommerce_data
GROUP BY State
ORDER BY TotalSales DESC;

-- Top 5 Customers by Sales
SELECT CustomerName, SUM(Amount) AS TotalAmount
FROM ecommerce_data
GROUP BY CustomerName
ORDER BY TotalAmount DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT strftime('%Y-%m', OrderDate) AS Month, SUM(Amount) AS MonthlySales
FROM ecommerce_data
GROUP BY Month
ORDER BY Month;

-- Sales by Category and Sub-Category
SELECT Category, SubCategory, SUM(Amount) AS TotalSales
FROM ecommerce_data
GROUP BY Category, SubCategory
ORDER BY TotalSales DESC;

-- Payment Mode Preferences
SELECT PaymentMode, COUNT(*) AS NumOrders, SUM(Amount) AS TotalRevenue
FROM ecommerce_data
GROUP BY PaymentMode
ORDER BY TotalRevenue DESC;

-- Subquery: Top State for Each Category
SELECT Category, State, MAX(TotalSales) AS MaxSales
FROM (
    SELECT Category, State, SUM(Amount) AS TotalSales
    FROM ecommerce_data
    GROUP BY Category, State
)
GROUP BY Category;

-- Creating View: Order Summary
CREATE VIEW order_summary AS
SELECT OrderID, CustomerName, Category, SubCategory, Amount, OrderDate
FROM ecommerce_data;

-- Creating Indexes
CREATE INDEX idx_orderdate ON ecommerce_data(OrderDate);
CREATE INDEX idx_state ON ecommerce_data(State);

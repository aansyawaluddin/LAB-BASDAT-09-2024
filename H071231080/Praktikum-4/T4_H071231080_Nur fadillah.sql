-- Nama : Nur fadillah
-- NIM : H071231080



-- No.1
USE classicmodels;

SELECT * FROM customers;
SELECT
customerNumber,
customerName,
country
FROM customers
WHERE country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000
OR country <> 'USA' AND creditLimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC;


-- No.2
SELECT * FROM products
SELECT
productCode,
productName,
quantityInStock,
buyPrice
FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000 
AND buyPrice < 50 OR buyPrice > 150
AND productLine <> 'Vintage Cars';


-- No.3
SELECT * FROM products
SELECT
productCode,
productName,
MSRP
FROM products
WHERE productLine LIKE 'Classic Cars' AND buyPrice > 50


-- No.4
SELECT * FROM orders
SELECT
orderNumber,
orderDate,
STATUS,
customerNumber
FROM orders
WHERE orderNumber > 10250 AND STATUS NOT IN ('Shipped', 'Cancelled')
AND orderDate BETWEEN '2004-01-01' AND '2005-12-31';


-- No.5
SELECT * FROM orderdetails
SELECT
orderNumber,
orderLineNumber,
productCode,
quantityOrdered,
priceEach, (priceEach * 0.95) AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50 AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;







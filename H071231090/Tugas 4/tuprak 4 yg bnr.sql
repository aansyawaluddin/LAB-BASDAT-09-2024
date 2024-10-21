USE classicmodels;

-- nomor 1
SELECT customerNumber, customerName, country FROM customers
WHERE (country = 'USA' AND creditLimit BETWEEN 50000 AND 100000)
OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

-- nomor 2
SELECT productCode, productName, quantityInStock, buyPrice, productLine FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
AND buyPrice < 50 OR buyPrice > 150
AND productline NOT LIKE 'vintage%';

-- nomor 3
SELECT productCode, productLine, productName, MSRP FROM products
WHERE productLine LIKE '%classic%'
AND buyPrice > 50;

-- 4
SELECT orderNumber, orderDate, STATUS, customerNumber FROM orders
WHERE orderNumber > '10250'
AND STATUS NOT LIKE 'shipped'
AND STATUS NOT LIKE 'cancelled'
AND orderDate BETWEEN '2004-01-01' AND '2005-12-31';

-- 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, (priceEach - (0.05 * priceEach)) AS 'discountedTotalPrice' FROM orderdetails
WHERE quantityOrdered > 50
AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;

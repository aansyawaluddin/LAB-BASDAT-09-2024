-- Query 1
SELECT * FROM customers;
SELECT customerNumber, customerName, country
FROM customers
WHERE country = 'USA' AND creditLimit BETWEEN 50000 AND 100000
OR country != 'USA' AND creditLimit BETWEEN 100000 AND 200000
ORDER BY creditLimit DESC;

-- Query 2
SELECT * FROM products;
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
AND buyPrice < 50 OR buyPrice > 150
AND productLine NOT LIKE 'Vintage%';

-- Query 3
SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE 'Classic%'
AND buyPrice > 50;

-- Query 4
SELECT * FROM orders;
SELECT orderNumber, orderDate, STATUS, customerNumber
FROM orders
WHERE orderNumber > 10250
AND STATUS NOT IN ('Shipped', 'Cancelled')
AND orderDate BETWEEN '2004-01-01' AND '2005-12-31';

-- Query 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, 
(quantityOrdered * priceEach * 0.95) AS discountedTotalPrice 
FROM orderdetails
WHERE quantityOrdered > 50 AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;


-- Query 6 (Soal Tambahan)
SELECT * FROM products;
SELECT productCode, productName, productLine
FROM products
WHERE productLine IN ('Planes', 'Ships', 'Trains');

-- Query 7 (Soal Tambahan)
SELECT productCode, productName, quantityInStock, buyPrice,
quantityInStock * buyPrice - (quantityInStock * buyPrice * 0.12) AS discountedTotalStockValue
FROM products
WHERE (quantityInStock * buyPrice) > 50000
ORDER BY discountedTotalStockValue DESC
LIMIT 5;
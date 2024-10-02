
USE classicmodels

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

-- Nomor 1
SELECT customerNumber, customerName, country
FROM customers
WHERE (country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000) 
OR (country != 'USA' AND creditLimit >= 100000 AND creditLimit <= 200000)
ORDER BY creditLimit DESC;

-- Nomor 2
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE quantityInStock > 1000 
AND quantityInStock < 2000
AND buyprice < 50
AND buyprice > 150
NOT LIKE '%Vintage%';

-- Nomor 3
SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE '%Classic%'
AND buyprice > 50;

-- NOMOR 4
SELECT orderNumber, orderDate, STATUS, customerNumber
FROM orders
WHERE ordernumber > 10250
AND STATUS != 'Shipped' 
AND STATUS != 'Cancelled'
AND ORDERDATE BETWEEN '2004-01-01' AND '2005-12-30';


-- NOMOR 5
SELECT orderNumber, orderlinenumber, productcode, quantityordered, priceeach,
(priceeach * quantityordered) - (priceeach * quantityordered * 0.05) AS 'discountedTotalPrice'
FROM orderdetails
WHERE quantityordered > 50 
AND priceeach > 100
AND productcode NOT LIKE '%S18%'
ORDER BY discountedTotalPrice DESC; 


-- soal tambahan 1

SELECT customername
FROM customers
WHERE customername
LIKE 'D%s';

SELECT * FROM products

-- soal tambahan 2

SELECT productcode, productname, quantityinstock, buyprice,
(quantityinstock * buyprice) - (quantityinstock * buyprice * 0.12) AS 'discountedTotalStockValue'
FROM products
WHERE (quantityinstock * buyprice) - (quantityinstock * buyprice * 0.12) > 50000
ORDER BY discountedTotalStockValue DESC
LIMIT 5;





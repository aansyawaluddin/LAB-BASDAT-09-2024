USE classicmodels;

-- Nomor 1
SELECT customerNumber, customerName, country
FROM customers
WHERE (country ='USA' AND creditLimit > 50000 AND creditLimit < 100000) OR (country !='USA' AND creditLimit >= 100000 AND creditLimit <= 200000)

-- Nomor 2
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
	AND (buyPrice < 50 OR buyPrice > 150)
	AND productLine NOT LIKE 'Vintage';
	
-- Nomor 3
SELECT productCode, productName, MSRP
FROM products
WHERE productLine LIKE '%Classic%'
	AND buyPrice > 50;
	
-- Nomor 4
SELECT orderNumber, orderDate, status, customerNumber
FROM orders
WHERE orderNumber > 10250
	AND status NOT IN('Shipped', 'Cancelled')
	AND YEAR(orderDate) BETWEEN 2004 AND 2005;
	
-- Nomro 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach,
	ROUND(quantityOrdered * priceEach * 0.95, 2) AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50
	AND priceEach > 100
	AND productCode NOT LIKE 'S18%';
-- Nama : Muhammad Rifky Kurniawan
-- H071231023

USE classicmodels;

-- Nomor 1
SELECT 
	c.customerName,
	CONCAT(e.firstName, ' ', e.lastName)  AS salesRep,
	(c.creditLimit - SUM(p.amount)) AS `remainingCredit`
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p
USING (customerNumber)
GROUP BY c.customerName
HAVING remainingCredit >= 0;

-- Nomor 2
SELECT 
	p.productName, 
	GROUP_CONCAT(distinct c.customerName SEPARATOR ",") AS "Nama Customer",
	COUNT(distinct c.customerNumber) AS "Jumlah Customer",
	SUM(od.quantityOrdered) AS "Total Quantity"
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
GROUP BY p.productName;

-- Nomor 3
SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
    COUNT(c.customerNumber) AS totalCustomers
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY (e.employeeNumber)
ORDER BY totalCustomers DESC;

-- Nomor 4
SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan`,
	p.productName AS "Nama Produk",
	SUM(od.quantityOrdered) AS `Jumlah Pesanan`
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
RIGHT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o
USING (officeCode)
WHERE o.country LIKE "Australia"
GROUP BY p.productName, `Nama Karyawan`
ORDER BY `Jumlah Pesanan` DESC;

-- Nomor 5
SELECT 
	c.customerName,
	p.productName, 
    COUNT(p.productLine) AS "Banyak Jenis Produk"
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE (o.shippedDate IS NULL)
GROUP BY c.customerName;

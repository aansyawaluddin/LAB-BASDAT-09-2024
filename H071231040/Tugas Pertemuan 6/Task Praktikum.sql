-- Query 1
SELECT 
	c.customerName,
	CONCAT(e.firstName, " ", e.lastName) AS 'salesRep',
	(c.creditLimit - SUM(p.amount)) AS 'remainingCredit'
FROM customers c
JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
	USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- Query 2
SELECT
	p.productName AS 'Nama Produk',
	GROUP_CONCAT(DISTINCT c.customerName) AS 'Nama Customer',
	COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
	SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM customers c
JOIN orders o
	USING(customerNumber)
JOIN orderdetails od
	USING(orderNumber)
JOIN products p
	USING(productCode)
GROUP BY productName;

-- Query 3
SELECT
	CONCAT(e.firstName, " ", e.lastName) AS employeeName,
	COUNT(customerNumber) AS 'totalCustomers'
FROM employees e
JOIN customers c
	ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeNumber
ORDER BY totalCustomers DESC;

-- Query 4
SELECT
	CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
	GROUP_CONCAT(p.productName) AS 'Nama Produk',
	SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM offices oc
LEFT JOIN employees e
	USING(officeCode)
LEFT JOIN customers c
	ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN orders o
	USING(customerNumber)
LEFT JOIN orderdetails od
	USING(orderNumber)
LEFT JOIN products p
	USING(productCode)
WHERE oc.country = 'Australia'
GROUP BY e.employeeNumber, p.productCode
ORDER BY SUM(od.quantityOrdered) DESC;

-- Query 5
SELECT
	c.customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
	COUNT(p.productLine) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
	USING(customerNumber)
JOIN orderdetails od
	USING(orderNumber)
JOIN products p
	USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;
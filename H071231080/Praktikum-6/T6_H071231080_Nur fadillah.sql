-- Nama : Nur fadillah
-- NIM : H071231080

USE classicmodels;

-- NO.1
SELECT 
		c.customerName,
		CONCAT(e.firstName, " ", e.lastName) AS 'SalesRep',
		(c.creditLimit - SUM(p.amount)) AS 'remainingCredit'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
HAVING remainingCredit > 0;




-- NO.2
SELECT 
		p.productName AS 'Nama Produk',
		GROUP_CONCAT(DISTINCT c.customerName ORDER BY c.customerName ASC SEPARATOR ', ') AS 'Nama Customer',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
		SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od 
ON p.productCode = od.productCode
JOIN orders o
ON od.orderNumber = o.orderNumber
JOIN customers c
ON o.customerNumber = c.customerNumber
GROUP BY p.productName
ORDER BY p.productName




-- NO.3
SELECT 
	CONCAT(e.firstName, " ", e.lastName) AS 'employeeName',
	COUNT(DISTINCT c.customerNumber) AS 'totalCustomers'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.jobTitle = 'Sales Rep'
GROUP BY employeeName
ORDER BY totalCustomers DESC 




-- NO.4
SELECT
		CONCAT(e.firstName, " ", e.lastName) AS 'Nama Karyawan',
		p.productName AS 'Nama Produk',
		SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
JOIN orders o
ON od.orderNumber = o.orderNumber
JOIN customers c
ON o.customerNumber = c.customerNumber
RIGHT JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices ofc
ON e.officeCode = ofc.officeCode
WHERE ofc.country = 'Australia' 
GROUP BY `Nama Produk` , e.employeeNumber
ORDER BY `Jumlah Pesanan` DESC;



-- NO.5
SELECT * FROM orders
SELECT 
		c.customerName AS 'Nama Pelanggan',
		GROUP_CONCAT(p.productName ORDER BY p.productName) AS 'Nama Produk',
		COUNT(p.productName) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE o.shippedDate IS NULL 
GROUP BY c.customerName







USE classicmodels;

-- nomor 1
SELECT DISTINCT c.customerName AS 'namaKustomer', p.productName AS 'namaProduk', pl.textDescription
FROM customers AS c
JOIN orders 
ON c.customerNumber = orders.customerNumber
JOIN orderdetails 
ON orders.orderNumber = orderdetails.orderNumber
JOIN products AS p 
ON orderdetails.productCode = p.productCode
JOIN productlines AS pl
ON p.productLine = pl.productLine
WHERE p.productName LIKE '%titanic%'
ORDER BY c.customerName;

-- nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails 
ON o.orderNumber = orderdetails.orderNumber
JOIN products AS p 
ON orderdetails.productCode = p.productCode
WHERE p.productName LIKE '%ferrari%'
AND STATUS  LIKE 'shipped'
AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;

-- nomor 3
SELECT CONCAT (e1.firstName, ' ', e1.lastName) AS 'Supervisor', 
		 CONCAT (e2.firstName, ' ', e2.lastName) AS 'Karyawan'
FROM employees AS e1
JOIN employees AS e2
ON e2.reportsTo = e1.employeeNumber
WHERE e1.firstName LIKE 'Gerard'
ORDER BY e2.firstName;

-- nomor 4
-- a
SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName', p.amount
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11%';

-- b
SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName', p.amount
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11%'
ORDER BY p.amount DESC
LIMIT 1;

-- c
SELECT c.customerName, pr.productName
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS pr
ON pr.productCode = od.productCode
WHERE c.customerName LIKE 'Corporate Gift Ideas Co.';

-- tambahan
SELECT o.orderNumber, o.orderDate, c.customerName, p.amount
FROM orders AS o
JOIN customers AS c
USING(customerNumber)
JOIN payments AS p
USING(customerNumber)
WHERE amount < 50000
AND o.status LIKE 'cancelled';
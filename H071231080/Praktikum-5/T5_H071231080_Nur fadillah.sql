-- Nama : Nur Fadillah
-- NIM : H071231080
USE classicmodels
 -- No.1

 
 SELECT DISTINCT 
		 c.customerName AS 'namaKustomer',
		 p.productName AS 'namaProduk',
		 p.productDescription AS 'textDescription'
 FROM customers AS c
 JOIN orders AS o
 ON c.customerNumber = o.customerNumber
 JOIN orderDetails AS od
 ON o.orderNumber = od.orderNumber
JOIN products AS p
 ON od.productCode = p.productCode
 WHERE productName LIKE '%Titanic%' 
ORDER BY c.customerName ASC;  



-- No.2
SELECT * FROM orders
SELECT * FROM 

SELECT c.customerName,
p.productName,
o.status,
o.shippedDate
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
WHERE productName LIKE '%Ferrari%' 
AND STATUS = 'Shipped' 
AND shippedDate BETWEEN '2003-10-01' AND '2004-09-31'


-- no. 3
SELECT * FROM employees

SELECT  
    s.firstName AS 'supervisor',
    k.firstName AS 'karyawan'
FROM employees s
INNER JOIN employees k
ON s.employeeNumber = k.reportsTo
WHERE s.firstName LIKE '%gerard%'
ORDER BY s.firstName ASC;



-- no.4
-- a
SELECT * from payments

SELECT c.customerName,
p.paymentDate,
e.firstName AS 'employeeName',
p.amount
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '_____11%'



-- b
SELECT c.customerName,
p.paymentDate,
e.firstName AS 'employeeName',
p.amount
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '_____11%'
ORDER BY amount DESC
LIMIT 1;

-- C
SELECT * FROM products

SELECT  c.customerName,
 p.productName 
 FROM customers AS c
 INNER JOIN payments AS py
 ON c.customerNumber = py.customerNumber
 INNER JOIN orders AS o
 ON c.customerNumber = o.customerNumber
 INNER JOIN orderDetails AS od
 ON o.orderNumber = od.orderNumber
 INNER JOIN products AS p
 ON od.productCode = p.productCode
WHERE c.customerName LIKE 'corporate%' 
AND paymentDate LIKE '_____11%'




-- No.2 22x10
SELECT * FROM products
SELECT * FROM orderdetails



SELECT 
		c.customerName,
		o.orderNumber,
		o.orderDate,
		o.shippedDate,
		p.productName,
		od.quantityOrdered,
		od.priceEach,
		of.city AS officeCity,
		e.firstname AS salesRepFirstName,
		e.lastname AS salesRepLastName

FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber

INNER JOIN orderDetails od
ON o.orderNumber = od.orderNumber

INNER JOIN products p
ON od.productCode = p.productCode

INNER JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber

INNER JOIN offices of
ON e.officeCode = Of.officeCode

WHERE p.productName LIKE '1%r' 
AND o.orderDate < '2004-12-25' 
AND od.quantityOrdered > 10 
AND c.city = 'NYC'
AND od.priceEach BETWEEN 20 AND 100





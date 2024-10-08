
USE classicmodels

-- Nnomor 1
SELECT DISTINCT c.`customerName` AS "NamaKustomer", p.`productName` AS "namaProduk", pl.`textDescription`
FROM customers c
JOIN orders o ON c.`customerNumber` = o.`customerNumber`
JOIN orderdetails od ON o.`orderNumber` = od.`orderNumber`
JOIN products p ON od.`productCode` = p.`productCode`
JOIN productlines pl ON p.`productLine` = pl.`productLine`
WHERE p.`productName` LIKE "%Titanic%"
ORDER BY c.customerName;


-- Nomor 2
SELECT c.`customerName`, p.`productName`, o.status, o.`shippedDate`
FROM customers c
JOIN orders o ON c.`customerNumber` = o.`customerNumber`
JOIN orderdetails od ON o.`orderNumber` = od.`orderNumber`
JOIN products p ON od.`productCode` = p.`productCode`
WHERE p.`productName` LIKE "%Ferrari%"
AND o.status = "Shipped"
AND o.`shippedDate` BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY `shippedDate` DESC;



-- Nomor 3
SELECT * FROM employees
WHERE firstname = "Gerard" OR lastname = "Gerard"

SELECT * FROM employees
WHERE reportsto = 1102



SELECT sup.`firstName` AS "Supervisor", kar.`firstName` AS "Karyawan"
FROM employees sup
JOIN employees kar ON sup.`employeeNumber` = kar.`reportsTo`
WHERE kar.`jobTitle` = "Sales Rep" AND sup.`firstName` = "Gerard"
ORDER BY kar.`firstName`;


-- Nomor 4
-- bagian a
SELECT c.`customerName`, p.`paymentDate`, e.`firstName` AS "employeeName", p.`amount`
FROM customers c
JOIN payments p ON c.`customerNumber` = p.`customerNumber`
JOIN employees e ON c.`salesRepEmployeeNumber` = e.`employeeNumber`
WHERE p.`paymentDate` LIKE "%-11-%";



-- bagian b
SELECT c.`customerName`, p.`paymentDate`, e.`firstName` AS "employeeName", p.`amount`
FROM customers c
JOIN payments p ON c.`customerNumber` = p.`customerNumber`
JOIN employees e ON c.`salesRepEmployeeNumber` = e.`employeeNumber`
WHERE p.`paymentDate` LIKE "%-11-%"
ORDER BY p.amount DESC LIMIT 1;


-- bagian c
SELECT c.`customerName`, p.`productName`
FROM customers c
JOIN payments py ON c.`customerNumber` = py.`customerNumber`
JOIN orders o ON c.`customerNumber` = o.`customerNumber`
JOIN orderdetails od ON o.`orderNumber` = od.`orderNumber`
JOIN products p ON od.`productCode` = p.`productCode`
WHERE py.`paymentDate` LIKE "%-11-%" AND c.customerName = "Corporate Gift Ideas Co."


-- Soal tambahan
SELECT * FROM orders
WHERE orderDate > "2003-03-01"

SELECT * FROM products
WHERE productname LIKE "2%0"


SELECT c.customerName, 
o.orderNumber, 
o.orderDate, 
o.shippedDate, 
p.productName, 
od.quantityOrdered, 
od.priceEach,
ofc.city,
e.firstName,
e.lastName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
JOIN employees e ON c.`salesRepEmployeeNumber` = e.`employeeNumber`
JOIN offices ofc ON e.officeCode = ofc.officeCode
WHERE p.productName LIKE "2%o"
AND o.orderDate > "2003-03-01"
AND od.quantityOrdered > 15
AND c.city = "San Francisco"
AND od.priceEach >= 50
AND od.priceEach <= 150
ORDER BY c.customerName ASC

 




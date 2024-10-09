USE classicmodels;

-- Query 1
SELECT DISTINCT
    c.customerName AS 'namaKustomer',
    p.productName AS 'namaProduk',
    pl.textDescription
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS p
    ON od.productCode = p.productCode
JOIN productlines AS pl
    ON p.productLine = pl.productLine
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;

-- Query 2
SELECT
    c.customerName,
    p.productName,
    o.status,
    o.shippedDate
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS p
    ON od.productCode = p.productCode
WHERE 
    p.productName LIKE '%Ferrari%'
    AND o.status = 'Shipped'
    AND o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY o.shippedDate DESC;

-- Query 3
SELECT * FROM employees;
SELECT
    s.firstName AS 'Supervisor',
    k.firstName AS 'Karyawan'
FROM employees AS k
JOIN employees AS s
    ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstName ASC;

-- Query 4
## a
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
FROM customers AS c
JOIN payments AS p
    ON c.customerNumber = p.customerNumber
JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%';

## b
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
FROM customers AS c
JOIN payments AS p
    ON c.customerNumber = p.customerNumber
JOIN employees AS e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

## c
SELECT
    c.customerName,
    po.productName
FROM customers AS c
JOIN orders AS o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
JOIN products AS po
    ON od.productCode = po.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.';

-- Query 5 (Tambahan Soal)
SELECT
	c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	od.quantityOrdered,
	od.priceEach,
	oc.city,
	e.firstName,
	e.lastName
FROM customers AS c
JOIN orders AS o
	ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS oc
	ON e.officeCode = oc.officeCode
WHERE p.productName LIKE '%69%'
	AND o.orderDate > '2003-07-01'
	AND oc.city IN ('Paris','London')
	AND od.priceEach > 70
ORDER BY od.quantityOrdered DESC;
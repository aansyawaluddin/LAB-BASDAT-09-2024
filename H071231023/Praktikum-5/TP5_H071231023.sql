USE classicmodels

# Nomor 1
SELECT DISTINCT c.customerName AS namaKustomer, p.productName AS namaProduk, p.productDescription AS textDescription
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS det
ON o.orderNumber = det.orderNumber
INNER JOIN products AS p
ON det.productCode = p.productCode
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;


# Nomor 2
SELECT c.customerName, productName, o.status, o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderDetails AS det
ON o.orderNumber = det.orderNumber
INNER JOIN products AS p
ON det.productCode = p.productCode
WHERE productName LIKE '%ferrari%' 
AND STATUS = 'shipped'
AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC;

# Nomor 3
SELECT e.firstName AS Supervisor, sv.firstName AS Karyawan
FROM employees AS e
INNER JOIN employees AS sv
ON sv.reportsTo = e.employeeNumber
WHERE e.firstName LIKE '%Gerard%'
ORDER BY sv.firstName ASC;

SELECT * FROM employees

# Nomor 4 A
SELECT c.customername,p.paymentdate,e.firstname,p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentdate LIKE '_____11___'
ORDER BY p.amount DESC
# Nomor 4 B
LIMIT 1;

# Nomor 4 C
SELECT c.customername, p.productname
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS det 
ON o.orderNumber = det.orderNumber
INNER JOIN products AS p
ON det.productCode = p.productCode
WHERE customername LIKE '%Corporate Gift Ideas Co.%';


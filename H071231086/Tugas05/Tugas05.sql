SELECT DISTINCT c.customername AS namaKustomer, p.productname AS namaProduk, p.productdescription AS textDescription                                 
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od 
ON o.ordernumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productcode
WHERE productname LIKE '%Titanic%'
ORDER BY namakustomer;

SELECT c.customername, p.productName, o.`status`, o.shippedDate
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od 
ON o.ordernumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productcode
WHERE productname LIKE '%Ferrari%'
AND STATUS = 'shipped'
AND shippeddate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY DATE(o.shippedDate) DESC;

SELECT e1.firstname AS Supervisor, e2.lastname AS karyawan
FROM employees e1
INNER JOIN employees e2
ON e1.employeeNumber = e2.reportsTo
WHERE e1.firstname = 'Gerard'
ORDER BY e2.lastname;

SELECT 
   c.customerName, 
   p.paymentDate, 
   CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
   p.amount
FROM 
   customers AS c
JOIN 
   payments AS p ON p.customerNumber = c.customerNumber
JOIN 
   employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE 
   p.paymentDate LIKE '%-11-%'
ORDER BY 
   p.amount;


SELECT 
   c.customerName, 
   p.paymentDate, 
   CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
   p.amount
FROM 
   customers AS c
JOIN 
   payments AS p ON p.customerNumber = c.customerNumber
JOIN 
   employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE 
   p.paymentDate LIKE '%-11-%'
ORDER BY 
   p.amount DESC
LIMIT 1;



SELECT 
   c.customerName, 
   p.productName
FROM 
   customers AS c
JOIN 
   payments AS ps ON ps.customerNumber = c.customerNumber
JOIN 
   orders AS o ON o.customerNumber = c.customerNumber
JOIN 
   orderdetails AS od ON od.orderNumber = o.orderNumberc
JOIN 
   products AS p ON p.productCode = od.productCode
WHERE 
   c.customerName LIKE 'Corporate%' 
   AND ps.paymentDate LIKE '%-11-%';
   
 






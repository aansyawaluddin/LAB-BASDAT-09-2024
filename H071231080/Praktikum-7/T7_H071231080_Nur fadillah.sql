-- Nama : Nur fadillah
-- NIM : H071231080

USE classicmodels
-- NO.1
SELECT
		productCode,
		productName, 
		buyPrice
FROM products p1
WHERE buyPrice > (SELECT AVG(buyPrice)
						FROM products p2
						ORDER BY p2.buyPrice DESC);


-- NO.2
SELECT 
		o.orderNumber,
		o.orderDate
FROM orders o
JOIN customers c
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc
USING (officeCode)
WHERE employeeNumber IN(SELECT employeeNumber 
								FROM employees
								WHERE ofc.city = 'Tokyo');
								
		

-- NO.3
SELECT shippedDate FROM orders

SELECT 
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    GROUP_CONCAT(p.productName) AS products,
    SUM(od.quantityOrdered) AS total_quantity_ordered,
    CONCAT(e.firstName, " ", e.lastName) AS employeeName
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
WHERE o.orderNumber = (SELECT DISTINCT o1.orderNumber
								FROM orders o1
								WHERE o1.shippedDate > o1.requiredDate);
								

-- NO.4

SELECT
   p.productName,
   p.productLine,
   SUM(od.quantityOrdered) AS 'total_quantity_ordered'
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE p.productLine IN(
   SELECT productLine
   FROM (SELECT p1.productLine
      	FROM products p1
      	JOIN orderdetails od1
      	USING (productCode)
	      GROUP BY p1.productLine
	      ORDER BY SUM(od1.quantityOrdered) DESC
	      LIMIT 3) AS tabel2)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;		

					
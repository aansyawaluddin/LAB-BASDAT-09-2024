USE classicmodels;

#1
SELECT productCode, productName, buyPrice FROM products
GROUP BY productCode, productName
HAVING buyPrice > 
	(SELECT (AVG(buyPrice)) AS rata FROM products);

# 2
SELECT orderNumber, orderDate
FROM orders
WHERE customerNumber IN (
    SELECT customerNumber
    FROM customers
    WHERE salesRepEmployeeNumber IN (
        SELECT employeeNumber
        FROM employees
        WHERE officeCode = (
            SELECT officeCode
            FROM offices
            WHERE city = 'Tokyo'
        )
    )
);

#3
SELECT c.customerName,
		 o.orderNumber,
		 o.shippedDate,
		 o.requiredDate,
		 GROUP_CONCAT(p.productName) AS productName,
		 sum(od.quantityOrdered) AS total_quantity_ordered,
		 CONCAT(e.firstName, ' ', e.lastName) as employeeName
FROM customers c
JOIN orders o 
	ON c.customerNumber = o.customerNumber
JOIN employees e 
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orderdetails od 
	ON o.orderNumber = od.orderNumber
JOIN products p 
	ON p.productCode = od.productCode
WHERE o.orderNumber IN (
    SELECT o2.orderNumber
    FROM orders o2
    WHERE DATEDIFF(o2.shippedDate, o2.requiredDate) > 0
	)
GROUP BY o.shippedDate
ORDER BY productName DESC;

#4
SELECT productName, 
		 productLine,
		 (SELECT SUM(quantityOrdered) AS qo FROM orderdetails o WHERE o.productCode = p.productCode) 
		 AS total_quantity_ordered 
FROM products p
WHERE productLine IN (
	    SELECT productLine 
	    FROM (
	         SELECT p.productLine,
	            	SUM(o.quantityOrdered) AS total_quantity_ordered
	         FROM products p
	         JOIN orderdetails o 
			  		ON p.productCode = o.productCode
	         GROUP BY p.productLine
	         ORDER BY total_quantity_ordered DESC
	      	LIMIT 3
	    ) AS urutan
	)
GROUP BY productLine, productName
HAVING total_quantity_ordered IS NOT null
ORDER BY productline, total_quantity_ordered DESC;

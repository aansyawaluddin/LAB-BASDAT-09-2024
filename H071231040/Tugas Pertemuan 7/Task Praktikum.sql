-- Query 1
SELECT 
	p.productCode,
	p.productName,
	p.buyPrice
FROM products AS p
WHERE p.buyPrice > (
		SELECT AVG(buyPrice) AS 'Average' 
		FROM products
);

-- Query 2
SELECT
	o.orderNumber,
	o.orderDate
FROM orders AS o
JOIN customers AS c
	USING(customerNumber)
WHERE c.salesRepEmployeeNumber IN (
		SELECT employeeNumber
		FROM employees
		JOIN offices AS of
			USING(officeCode)
		WHERE of.city = 'Tokyo'
);

-- Query 3
SELECT 
	c.customerName,
	o.orderNumber, o.shippedDate, o.requiredDate,
	GROUP_CONCAT(p.productName) AS 'products',
	SUM(od.quantityOrdered) AS 'total_quantity_ordered',
	CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName'
FROM customers AS c
JOIN orders AS o
	USING(customerNumber)
JOIN orderdetails AS od
	USING(orderNumber)
JOIN products AS p
	USING(productCode)
JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (
		SELECT o2.orderNumber
		FROM orders AS o2
		WHERE o2.requiredDate < o2.shippedDate
)

-- Query 4
SELECT
	p.productName,
	p.productLine,
	SUM(od.quantityOrdered) AS 'total_quantity_ordered'
FROM products AS p
JOIN orderdetails AS od
	USING(productCode)
WHERE p.productLine IN (
		SELECT productLine
		FROM (
			SELECT productLine
			FROM products
			JOIN orderdetails
				USING (productCode)
			GROUP BY productLine
			ORDER BY SUM(quantityOrdered) DESC
			LIMIT 3
		) AS top_product
)
GROUP BY p.productName
ORDER BY p.productLine, total_quantity_ordered DESC;
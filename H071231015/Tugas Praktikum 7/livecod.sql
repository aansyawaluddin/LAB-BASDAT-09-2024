USE classicmodels

-- nomor 1

SELECT p.productCode, p.productName, p.buyPrice
FROM products p
WHERE p.buyPrice > (
	SELECT AVG(p2.buyprice)
	FROM products p2
)



-- nomor 2
SELECT * FROM employees


SELECT o.orderNumber, o.orderDate
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc ON e.officeCode = ofc.officeCode
WHERE e.officeCode = (
	SELECT ofc2.officecode
	FROM offices ofc2
	WHERE ofc2.city = 'Tokyo'
)



-- nomor 3
SELECT o FROM orders

SELECT distinct pdt.productName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = o.orderNumber
JOIN products pdt ON od.productCode = pdt.productCode
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber = 10165


SELECT c.customerName,
o.orderNumber,
o.shippedDate,
o.requiredDate,
GROUP_CONCAT(pdt.productName) "products",
SUM(od.quantityOrdered) "total_quantity_ordered",
CONCAT(e.firstName, " ", e.lastName) "employeeName"
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products pdt ON od.productCode = pdt.productCode
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber = (
	SELECT o2.orderNumber
	FROM orders o2
	WHERE DATEDIFF(o2.requiredDate, o2.shippedDate) < 0
)

-- nomor 4


SELECT pdt.productName, 
pdt.productLine,
sum(od.quantityOrdered) "total"
FROM products pdt
JOIN orderdetails od USING (productCode)
JOIN (
	SELECT DISTINCT pdt2.productline
	FROM products pdt2
	JOIN orderdetails od2 USING (productCode)
	GROUP BY pdt2.productLine
	ORDER BY SUM(od2.quantityOrdered) DESC
	LIMIT 3
) table_baru using(productLine)
GROUP BY pdt.productName
ORDER BY pdt.productLine, total DESC


-- soal tambahan

SELECT py2.amount
	FROM payments py2
ORDER BY py2.amount 



SELECT ofc.officeCode,
ofc.addressLine1,
ofc.country
FROM offices ofc
JOIN employees e USING(officeCode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py USING(customerNumber)
WHERE py.amount = (
	SELECT MIN(py2.amount)
	FROM payments py2
) 







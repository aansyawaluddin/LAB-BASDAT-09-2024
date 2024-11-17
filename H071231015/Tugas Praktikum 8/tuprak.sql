USE classicmodels;


--nomor 1
SELECT AVG(p2.`buyPrice`)
    FROM products p2


SELECT p.`productCode`, p.`productName`, p.`buyPrice`
FROM products p
WHERE p.`buyPrice` > (
    SELECT AVG(p2.`buyPrice`)
    FROM products p2
)



--nomor 2

SELECT ofc2.`officeCode`
    FROM offices ofc2
    WHERE ofc2.city = 'Tokyo'


SELECT o.`orderNumber`, o.`orderDate`
FROM orders o
JOIN customers c ON o.`customerNumber` = c.`customerNumber`
JOIN employees e ON c.`salesRepEmployeeNumber` = e.`employeeNumber`
JOIN offices ofc ON e.`officeCode` = ofc.`officeCode`
WHERE e.`officeCode` = (
    SELECT ofc2.`officeCode`
    FROM offices ofc2
    WHERE ofc2.city = 'Tokyo'
)



--nomor 3


SELECT pdt2.`productName`, SUM(od2.`quantityOrdered`),
    DATEDIFF(o2.`shippedDate`, o2.`requiredDate`) AS "daysLate",
    TIMEDIFF(o2.`shippedDate`, o2.`requiredDate`) AS "timeLate"
    FROM orders o2
    JOIN orderdetails od2 ON o2.`orderNumber` = od2.`orderNumber`
    JOIN products pdt2 ON pdt2.`productCode` = od2.`productCode`
    WHERE DATEDIFF(o2.`shippedDate`, o2.`requiredDate`) > 0
    GROUP BY pdt2.`productName`
    ORDER BY pdt2.`productName` 


SELECT c.customerName, 
    o.orderNumber, 
    o.shippedDate,
    o.requiredDate,
    GROUP_CONCAT(pdt.productName) AS products,
    SUM(od.quantityOrdered) AS totalQuantityOrdered,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products pdt ON od.productCode = pdt.productCode
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (
    SELECT o2.orderNumber
    FROM orders o2
    WHERE DATEDIFF(o2.shippedDate, o2.requiredDate) > 0
)
GROUP BY o.shippedDate
ORDER BY products DESC;







-- nomor 4

SELECT pdt2.`productLine`
    FROM products pdt2
    JOIN orderdetails od2 ON pdt2.`productCode` = od2.`productCode`
    GROUP BY pdt2.`productLine`
    ORDER BY SUM(od2.`quantityOrdered`) DESC
    LIMIT 3




SELECT 
    pdt.`productName`, 
    pdt.`productLine`, 
    SUM(od.`quantityOrdered`) AS "totalQuantityOrdered"
FROM products pdt
JOIN orderdetails od ON pdt.`productCode` = od.`productCode`
JOIN (
    SELECT pdt2.`productLine`
    FROM products pdt2
    JOIN orderdetails od2 ON pdt2.`productCode` = od2.`productCode`
    GROUP BY pdt2.`productLine`
    ORDER BY SUM(od2.`quantityOrdered`) DESC
    LIMIT 3
) AS TopProductLines ON TopProductLines.`productLine` = pdt.`productLine`
GROUP BY pdt.`productName`, pdt.`productLine`
ORDER BY pdt.`productLine`, SUM(od.`quantityOrdered`) DESC;

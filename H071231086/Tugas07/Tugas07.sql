#Nomor 1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

#Nomor 2
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
#QUERY LAGI DAN LAGI
SELECT orderNumber,orderdate
FROM orders
JOIN customers c ON  o.customerNumber = o.customerNumber
WHERE c.salesRepEmployeeNumber IN (SELECT employeeNumber 
											  FROM employees 
											  WHERE officeCode = (SELECT officeCode 
											  							 FROM offices 
																			WHERE city = 'Tokyo' )





#Nomor 3
SELECT 
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    
   GROUP_CONCAT(p.productName )
    AS `products`,
    
        SUM(od.quantityOrdered)
         AS total_quantity_ordered,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM orders o
JOIN orderdetails AS od  USING (orderNumber)
JOIN products AS p USING (productCode)
JOIN customers c 
ON o.customerNumber = c.customerNumber
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE DATEDIFF(o.shippedDate, o.requiredDate) > 0
GROUP BY o.orderNumber;


#Nomor 4
SELECT 
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE p.productLine IN (
    SELECT productLine 
    FROM (
        SELECT productLine, SUM(od.quantityOrdered) AS total_quantity_ordered
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        JOIN orders o ON od.orderNumber = o.orderNumber
        GROUP BY p.productLine
        ORDER BY total_quantity_ordered DESC
        LIMIT 3
    ) AS topCategories
)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;




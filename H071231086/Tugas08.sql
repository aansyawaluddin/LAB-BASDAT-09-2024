-- Nomor 1
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Tinggi' AS Pendapatan
FROM products p
JOIN orderdetails od
USING(productcode)
JOIN orders o
USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue DESC
LIMIT 5)
UNION 
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Pendek (kayak kamu)' AS Pendapatan
FROM products p
JOIN orderdetails od
USING(productcode)
JOIN orders o
USING(ordernumber)
WHERE MONTH(o.orderDate) = 9
GROUP BY p.productCode
ORDER BY TotalRevenue ASC
LIMIT 5)

-- Nomor 2
SELECT productName 
FROM products
WHERE productCode NOT IN (
    SELECT od.productCode 
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    WHERE o.customerNumber IN (
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        GROUP BY c.customerNumber
        HAVING COUNT(o.orderNumber) > 10
        INTERSECT 
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        JOIN products p ON od.productCode = p.productCode
        WHERE p.buyPrice > (SELECT AVG(buyPrice) FROM products)
    )
);

-- Nomor 3
SELECT customerName
FROM customers
JOIN payments
    USING(customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAmount)
    FROM (
        SELECT DISTINCT SUM(amount) AS totalAmount
        FROM payments
        GROUP BY customerNumber
    ) AS hasil
)
INTERSECT
SELECT c.customerName
FROM customers AS c
JOIN orders AS o
    USING(customerNumber)
JOIN orderdetails AS od 
    USING(orderNumber)
JOIN products AS p 
    USING(productCode)
WHERE p.productLine IN ('Planes', 'Trains')
GROUP BY c.customerName
HAVING SUM(priceEach * quantityOrdered) > 20000;

-- Nomor 4
SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
UNION
SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
UNION
SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan' FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;

-- Nomor 5
SELECT p.productCode
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE od.priceEach > (
    SELECT AVG(od2.priceEach) 
    FROM orderdetails od2
    JOIN orders o2 
    USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
) 
AND od.quantityOrdered > 48
AND LEFT(p.productVendor, 1) IN ('a', 'e', 'i', 'o', 'u')
EXCEPT
SELECT p.productCode 
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o 
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE c.country IN ('Japan', 'germany', 'Italy');
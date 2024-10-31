-- Query 1
(SELECT 
    productName,
    SUM(priceEach * quantityOrdered)  AS TotalRevenue,
    'Pendapatan Tinggi' AS Pendapatan
FROM products
JOIN orderdetails
    USING(productCode)
JOIN orders
    USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue DESC
LIMIT 5)
UNION
(SELECT 
    productName,
    SUM(priceEach * quantityOrdered)  AS TotalRevenue,
    'Pendapatan Rendah (kayak Rudy)' AS Pendapatan
FROM products
JOIN orderdetails
    USING(productCode)
JOIN orders
    USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue ASC
LIMIT 5)

-- Query 2
## Cara 1
SELECT p.productName
FROM products p
EXCEPT
SELECT p.productName
FROM products p
JOIN orderdetails od 
    USING(productCode)
JOIN orders o 
    USING(orderNumber)
WHERE customerNumber IN (
    -- Pelanggan dengan >10 pesanan
    SELECT customerNumber
    FROM orders
    GROUP BY customerNumber
    HAVING COUNT(*) > 10
    INTERSECT
    -- Pelanggan yang pernah pesan produk di atas rata-rata
    SELECT DISTINCT o.customerNumber
    FROM orders o
    JOIN orderdetails od USING(orderNumber)
    JOIN products p USING(productCode)
    WHERE p.buyPrice > (
        SELECT AVG(buyPrice)
        FROM products
    )
);

## Cara 2
SELECT productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode
    FROM orderdetails
    JOIN orders
        USING(orderNumber)
    WHERE customerNumber IN (
        SELECT customerNumber
        FROM orders
        GROUP BY customerNumber
        HAVING COUNT(*) > 10
        INTERSECT
        SELECT customerNumber
        FROM orders
        JOIN orderdetails
            USING(orderNumber)
        JOIN products
            USING(productCode)
        WHERE buyPrice > (
            SELECT AVG(buyPrice)
            FROM products
        )
    )
);

-- Query 3
SELECT customerName
FROM customers
JOIN payments
    USING(customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAmount)
    FROM (
        SELECT SUM(amount) AS totalAmount
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


-- Query 4
SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders AS o
JOIN customers AS c 
    USING (customerNumber)
JOIN payments AS p 
    ON o.orderDate = p.paymentDate
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
	FROM orders AS o
	JOIN customers AS c 
        USING (customerNumber)
	JOIN payments AS p 
        ON o.orderDate = p.paymentDate
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
	FROM orders AS o
	JOIN customers AS c 
        USING (customerNumber)
	JOIN payments p 
        ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;

-- Query 5
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
WHERE buyPrice > (
    SELECT AVG(buyPrice) FROM products 
    join orderdetails USING(productCode) 
    join orders USING(orderNumber)
    where orderDate BETWEEN '2001-01-01' and '2004-03-31'
)
AND quantityOrdered > 48
AND LEFT(productVendor, 1) IN ('A', 'I', 'U','E','O')
EXCEPT
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
    JOIN orders USING(orderNumber)
    JOIN customers using(customerNumber)
WHERE country in ("Japan", "Germany", "Italy");

-- Query 6 (Soal Tambahan)
SELECT o.city
FROM offices AS o
JOIN employees AS e
	USING(officeCode)
WHERE LEFT(e.firstName, 1) = 'L'
INTERSECT
SELECT c.city
FROM customers AS c
WHERE LEFT(c.customerName, 1) = 'L'

-- Query 7 (Soal Tambahan)
SELECT
	c.customerName,
	o.country,
	'Customer' AS status
FROM customers AS c
JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o
	USING(officeCode)
WHERE LEFT(o.country, 1) IN ('A', 'I', 'U', 'E', 'O')
AND RIGHT(o.country, 1) IN ('A', 'I', 'U', 'E', 'O')
UNION
SELECT
	CONCAT(e.firstName, ' ', e.lastName),
	o.country,
	'Employee' AS status
FROM employees AS e
JOIN customers AS c
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o
	USING(officeCode)
WHERE LEFT(o.country, 1) IN ('A', 'I', 'U', 'E', 'O')
AND RIGHT(o.country, 1) IN ('A', 'I', 'U', 'E', 'O')

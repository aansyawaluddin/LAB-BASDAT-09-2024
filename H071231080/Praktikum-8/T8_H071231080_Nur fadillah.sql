-- Nama : Nur fadillah
-- NIM : H071231080


USE classicmodels;

-- Soal 1
SELECT 
    productName,
    TotalRevenue,
    'Pendapatan Tinggi' AS Pendapatan
FROM (
    SELECT 
        p.productName,
        SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue
    FROM orderdetails od
    JOIN products p 
	 USING(productCode)
    JOIN orders o 
	 USING(orderNumber)
    WHERE o.orderDate LIKE '%-09-%'
    GROUP BY productcode
    ORDER BY TotalRevenue DESC
    LIMIT 5) AS HighRevenue

UNION ALL 

SELECT 
    productName,
    TotalRevenue,
    'Pendapatan Rendah (kayak kamu)' AS Pendapatan
FROM (
    SELECT 
        p.productName,
        SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue
    FROM orderdetails od
    JOIN products p USING(productCode)
    JOIN orders o USING(orderNumber)
    WHERE o.orderDate LIKE '%-09-%'
    GROUP BY productcode
    ORDER BY TotalRevenue ASC
    LIMIT 5) AS LowRevenue;

-- Soal 2
SELECT p.productName
FROM products p

EXCEPT

SELECT p.productName
FROM products p
JOIN orderdetails od 
USING(productCode)
JOIN orders o 
USING(orderNumber)
WHERE customerNumber IN (SELECT customerNumber
							    FROM orders
							    GROUP BY customerNumber
							    HAVING COUNT(*) > 10
							    
						  		 INTERSECT
    
							    SELECT DISTINCT o.customerNumber
							    FROM orders o
							    JOIN orderdetails od 
								 USING(orderNumber)
							    JOIN products p 
								 USING(productCode)
							    WHERE p.buyPrice > (SELECT AVG(p2.buyPrice)
								 							FROM products p2)
										   )



-- Soal 3
SELECT 
    c.customerName
FROM customers  c
JOIN payments p
USING(customerNumber)
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > 2 * (SELECT AVG(totalPayments)
    								FROM (
								        SELECT customerNumber, SUM(amount) AS totalPayments
								        FROM payments
								        GROUP BY customerNumber) AS avgPayments)

INTERSECT

SELECT 
    c.customerName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE p.productLine IN ('Planes', 'Trains')
GROUP BY c.customerNumber, c.customerName
HAVING SUM(od.quantityOrdered * od.priceEach) > 20000;


-- Soal 4
SELECT DISTINCT 
    o.orderDate AS tanggal,
    c.customerNumber,
    c.customerName, 
    'Memesan Barang' AS keterangan
FROM customers c
LEFT JOIN orders o 
ON c.customerNumber = o.customerNumber 
LEFT JOIN payments p 
ON o.orderDate = p.paymentDate
WHERE MONTH(o.orderDate) = 9 
    AND YEAR(o.orderDate) = 2003 
    AND p.paymentDate IS NULL

UNION ALL

SELECT DISTINCT 
    p.paymentDate AS tanggal,
    c.customerNumber,
    c.customerName,  
    'Membayar Pesanan' AS keterangan
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber 
LEFT JOIN orders o ON p.paymentDate = o.orderDate
WHERE MONTH(p.paymentDate) = 9 
   AND YEAR(p.paymentDate) = 2003 
   AND o.orderDate IS NULL

UNION ALL

SELECT DISTINCT 
   o.orderDate AS tanggal,  
   c.customerNumber,
   c.customerName, 
   'Memesan dan Membayar' AS keterangan
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber 
JOIN payments p ON o.orderDate = p.paymentDate 
WHERE MONTH(o.orderDate) = 9 
   AND YEAR(o.orderDate) = 2003

ORDER BY tanggal;

-- Soal 5
SELECT p.productCode
FROM products AS p
JOIN orderdetails AS od 
USING(productCode)
WHERE od.quantityOrdered > 48
    AND LEFT(p.productVendor, 1) IN ('A', 'I', 'U', 'E', 'O')
GROUP BY p.productCode
HAVING AVG(od.priceEach) > (
    SELECT AVG(od2.priceEach)
    FROM orderdetails AS od2
    JOIN orders AS o2 USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31')

EXCEPT

SELECT
		DISTINCT p.productCode
FROM products AS p
JOIN orderdetails AS od USING(productCode)
JOIN orders AS o USING(orderNumber)
JOIN customers AS c USING(customerNumber)
WHERE c.country IN ('Japan', 'Germany', 'Italy') 

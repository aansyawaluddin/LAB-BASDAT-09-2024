classicmodelsUSE classicmodels


-- Nomor 1


SELECT c.customerName, 
CONCAT(e.firstName, ' ', e.lastName) salesRep, 
(c.creditLimit - SUM(p.amount)) remainingCredit
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p USING(customernumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;



-- Nomor 2
SELECT pd.productName "Nama Produk",
GROUP_CONCAT(DISTINCT c.customerName) "Nama customer",
COUNT(DISTINCT c.customerName) "Jumlah Customer",
SUM(od.quantityOrdered) "Total Quantitas"
FROM products pd
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
GROUP BY pd.productName

-- Nomor 3

SELECT CONCAT(e.firstname, " ", e.lastName) "employeeName",
COUNT(DISTINCT c.customerName) "totalCustomers"
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;


-- nomor 4

SELECT CONCAT(e.firstName, ' ', e.lastName, " ",e.email) "Nama Karyawan",
       pd.productName "Nama Produk",
       SUM(od.quantityOrdered) "Jumlah Pesanan"
FROM employees e
LEFT JOIN offices ofc USING(officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o USING(customerNumber)
LEFT JOIN orderdetails od USING(orderNumber)
LEFT JOIN products pd USING(productCode)
WHERE ofc.country = 'Australia'
GROUP BY pd.productname, e.firstName, e.lastName
ORDER BY `Jumlah Pesanan` DESC;





-- nomor 5

SELECT c.customerName "Nama Pelanggan",
       GROUP_CONCAT(DISTINCT pd.productName) "Nama Produk",
       COUNT(DISTINCT pd.productCode) "Banyak Jenis Produk"
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pd USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;



-- soal tambahan

SELECT c.customerName "Nama pelanggan",  
o.orderDate "Tanggal pesanan",
COALESCE (o.shippedDate, 'NOW') "Tanggal pengiriman",
TIMESTAMPDIFF(DAY, o.orderDate, o.shippedDate) "Selisih hari"
FROM customers c 
JOIN orders o USING(customerNumber)



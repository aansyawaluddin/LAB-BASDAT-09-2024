USE classicmodels;

-- nomor 1
SELECT c.customerName, 
       CONCAT(e.firstName, ' ', e.lastName) salesRep, 
    	 (c.creditLimit - IFNULL(SUM(p.amount), 0)) remainingCredit
FROM customers c
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
HAVING remainingCredit > 0
ORDER BY c.customerName;

-- nomor 2
SELECT p.productName 'Nama Produk', 
		 c.customerName 'Nama Customer',
    	 COUNT(DISTINCT c.customerNumber) 'Jumlah Customer',
    	 SUM(od.quantityOrdered) 'Total Quantitas'
FROM products p
JOIN orderdetails od 
ON p.productCode = od.productCode
JOIN orders o 
ON od.orderNumber = o.orderNumber
JOIN customers c 
ON o.customerNumber = c.customerNumber
GROUP BY p.productName;

-- nomor 3
SELECT CONCAT(e.firstName, ' ', e.lastName) employeeName,
    	 COUNT(c.customerNumber) totalCustomers
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

-- nomor 4
SELECT CONCAT(e.firstName, ' ', e.lastName) 'Nama Karyawan',
    	 p.productName 'Nama Produk',
    	 SUM(od.quantityOrdered) 'Jumlah Pesanan'
FROM employees e
LEFT JOIN customers c 
	ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders ord 
  ON c.customerNumber = ord.customerNumber
LEFT JOIN orderdetails od 
  ON ord.orderNumber = od.orderNumber
LEFT JOIN products p 
  ON od.productCode = p.productCode
WHERE e.officeCode = '6'
GROUP BY e.firstName, e.lastName, p.productName
ORDER BY `Jumlah Pesanan` DESC;

-- nomor 5
SELECT c.customerName AS 'Nama Pelanggan',
    	 p.productName AS 'Nama Produk',
    	 COUNT(p.productName) AS 'Banyak jenis Produk'
FROM customers c
JOIN orders o 
	ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
	ON o.orderNumber = od.orderNumber
JOIN products p 
	ON od.productCode = p.productCode
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;

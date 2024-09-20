USE classicmodels;


##NOMOR 1
SELECT productCode AS 'Kode Produk', 
productName AS 'Nama Produk', 
quantityInStock AS 'jumlah Stok' 
FROM products 
WHERE quantityInStock BETWEEN 5000 AND 6000;



##NOMOR 2
SELECT orderNumber AS 'Nomor Pesanan', 
orderDate AS 'Tanggal Pesanan', 
STATUS, 
customerNumber AS 'Nomor Pelanggan' 
FROM orders 
WHERE status != 'Shipped'
ORDER BY customerNumber;



## NOMOR 3
SELECT employeeNumber AS 'Nomor Karyawan', 
firstName, 
lastName, 
email, 
jobTitle AS 'Jabatan' 
FROM employees 
WHERE jobTitle = 'Sales Rep' 
ORDER BY firstName 
LIMIT 10;



## NOMOR 4
SELECT productCode AS 'Kode Produk', 
productName AS 'Nama Produk', 
productLine AS 'Lini Produk', 
buyPrice AS 'Harga Beli' 
FROM products 
ORDER BY buyPrice DESC 
LIMIT 10 OFFSET 5;



## NOMOR 5
SELECT DISTINCT country, city 
FROM customers 
ORDER BY country, city;
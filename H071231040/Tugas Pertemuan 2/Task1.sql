-- Query 1
SELECT productCode AS 'Kode Produk', 
productName AS 'Nama Produk', 
quantityInStock AS 'Jumlah Stock' 
FROM products 
WHERE quantityInStock BETWEEN '5000' AND '6000';

-- Query 2
SELECT ordernumber AS 'Nomor Pesanan', 
orderDate AS 'Tanggal Pesanan', 
status, customerNumber AS 'Nomor Pelanggan' 
FROM orders 
WHERE STATUS <> 'shipped' 
ORDER BY customerNumber;

-- Query 3
SELECT employeeNumber AS 'Nomor Karyawan', 
firstName, lastName, email, 
jobTitle AS 'Jabatan' 
FROM employees 
WHERE jobTitle = 'Sales Rep' 
ORDER BY firstName 
LIMIT 10;

-- Query 4
SELECT productCode AS 'Kode Produk', 
productName AS 'Nama Produk', 
productLine AS 'Lini Produk', 
buyPrice AS 'Harga Beli' 
FROM products 
ORDER BY buyPrice DESC 
LIMIT 10 OFFSET 5;

-- Query 5
SELECT DISTINCT country, city 
FROM customers 
ORDER BY country AND city;

-- Query 6 (Soal Tambahan)
SELECT productName AS 'Nama Produk', buyPrice AS 'Harga Beli' 
FROM products 
WHERE buyPrice BETWEEN '50' AND '100'
ORDER BY buyPrice;

-- Query 7 (Soal Tambahan)
SELECT productName AS 'Nama Produk', quantityInStock AS 'Jumlah Stock'
FROM products
WHERE quantityInStock > 1000
ORDER BY quantityInStock;

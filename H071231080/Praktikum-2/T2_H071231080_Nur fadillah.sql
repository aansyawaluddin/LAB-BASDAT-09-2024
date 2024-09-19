### Nama : Nuur fadillah
### NIM : H071231080


USE classicmodels;

## NO. 1

SELECT * FROM products;

SELECT 
	productCode AS 'kode Produk', 
	productName AS 'Nama Produk', 
	quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock between 5000 AND 6000
ORDER BY quantityInStock ;


## NO. 2
SELECT * FROM orders;
SELECT 
	orderNumber AS 'Nomor Pesanan', 
	orderDate AS 'Tanggal Pesanan', 
	status , 
	customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != "Shipped" 
ORDER BY customerNumber ;



## NO. 3
SELECT * FROM employees;
SELECT 
	employeeNumber AS 'Nomor Karyawan',
	firstName , 
	lastName,
	email, 
	jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName
LIMIT 10;



## NO. 4
SELECT * FROM products;
SELECT 
	productCode AS 'Kode Produk', 
	productName AS 'Nama Produk', 
	productLine AS 'Lini Produk', 
	buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10; 



## NO. 5
SELECT * FROM customers;
SELECT DISTINCT 
	country,
	city 
FROM customers
ORDER BY country,
			city;



DROP DATABASE classismodels;


SELECT * FROM products;
SELECT 
	productName,
	buyPrice
FROM products
WHERE buyPrice BETWEEN 40 AND 90
ORDER BY buyPrice ;


SELECT
	productName AS 'Nama produk',
	buyPrice AS 'Harga beli'
FROM products
WHERE buyPrice > 30
LIMIT 15;
	
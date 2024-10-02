-- nomor 1
SELECT productCode AS 'kode Produk', 
	productName AS 'Nama Produk', 
	quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000
ORDER BY quantityinstock

-- nomor 2
SELECT orderNumber AS 'Nomor Pesanan', 
	orderDate AS 'Tanggal Pesanan',
	STATUS AS 'Status',
	customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS <> 'shipped'
ORDER BY customerNumber

-- nomor 3
SELECT employeeNumber AS 'Nomor Karyawan', 
	firstName, LastName, email, 
	jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = 'Sales rep'
ORDER BY firstName LIMIT 10

-- nomor 4
SELECT productCode AS 'Kode Produk', 
	productName AS 'Nama Produk', 
	productLine AS 'Lini Produk', 
	buyPrice AS 'Harga Beli' 
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10

-- nomor 5
SELECT DISTINCT country, city FROM customers
ORDER BY country, city

-- nomor 6 (live coding)
SELECT orderNumber, STATUS FROM orders
WHERE STATUS = 'resolved'
ORDER BY orderNumber DESC

-- nomor 4 (live coding)
SELECT productName, buyPrice FROM products
WHERE buyPrice > 30
ORDER BY buyPrice
LIMIT 15

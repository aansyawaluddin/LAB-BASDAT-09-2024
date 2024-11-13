SELECT customernumber, customername, country FROM customers
WHERE (country = 'USA'AND creditlimit > 50000 AND creditlimit < 100000) 
OR (country != 'USA' AND creditlimit BETWEEN 100000 AND 200000)
ORDER BY creditlimit DESC;

SELECT productcode, productname, quantityinstock, buyprice FROM products
WHERE (quantityinstock BETWEEN 1000 AND 2000)
AND (buyprice < 50 OR buyprice > 150)
AND productline != 'vintage';

SELECT productcode, productname, msrp FROM products
WHERE productline LIKE '%classic%'
AND buyprice > 50;

SELECT ordernumber, orderdate, STATUS, customernumber FROM orders
WHERE (ordernumber > 10250)
AND (STATUS !='shipped' AND STATUS != 'cancelled')
and year(orderdate) BETWEEN 2004 AND 2005

SELECT ordernumber, orderlinenumber, productcode, quantityordered, priceeach, (quantityordered * priceeach * 0.95) AS discountedtotalprice FROM orderdetails
WHERE (quantityordered > 50) 
AND (priceeach > 100)
AND productcode NOT LIKE 's18%'
ORDER BY discountedtotalprice DESC;
USE classicmodels;

SELECT checkNumber, amount FROM payments 
WHERE amount > 10000
ORDER BY amount DESC
LIMIT 5;



SELECT firstName, lastName FROM employees
WHERE officeCode = '1'
ORDER BY firstName

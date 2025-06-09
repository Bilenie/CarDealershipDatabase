-- 1)Find the dealership where a certain car is located, by VIN
USE cardealrshipdb;

SELECT 
  Address, Name
FROM 
   dealership
WHERE
  Dealership_ID = ( SELECT Dealership_ID FROM inventory WHERE Vin = 10112);
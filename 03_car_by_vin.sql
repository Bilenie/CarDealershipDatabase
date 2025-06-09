-- 1)Find a car by VIN
USE cardealrshipdb;

SELECT 
  *
FROM 
   vehicles
WHERE
   Vin = 10112;
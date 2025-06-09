-- 2)Find all vehicles for a specific dealership

SELECT
    * 
FROM 
   vehicles V
JOIN
   inventory I ON ( I.Vin = V.Vin)
JOIN
   dealership D ON(I.Dealership_ID = D.Dealership_ID)
WHERE 
  I.Vin = (SELECT Vin FROM inventory WHERE Vin =  37846);

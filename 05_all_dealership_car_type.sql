-- 5)Find all Dealerships that have a certain car type (i.e. Red Ford Mustang)
USE cardealershipdb;

SELECT 
    DISTINCT*
FROM 
    dealership d
JOIN
    inventory i ON(d.Dealership_ID = i.Dealership_ID )
JOIN 
   vehicles v ON (v.Vin = i.Vin)
WHERE v.Color = 'Red'
  AND v.Make = 'Ford'
  AND v.Model = 'Explorer';

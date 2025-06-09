-- 6)Get all sales information for a specific dealer for a specific date range
USE cardealershipdb;

SELECT 
    d.Name AS DealershipName,
    d.Contact_Phone,
    c.Date,
    c.CustomerName,
    c.CustomerEmail,
    c.Vehicle,
    c.TotalPrice,
    c.MonthlyPayment,
    c.Finance,
    s.contracts_ID -- actual column names
FROM 
    dealership d
JOIN 
    inventory i ON (d.Dealership_ID = i.Dealership_ID)
JOIN 
    contracts c ON (i.Vin = c.Vin)
JOIN 
    salescontracts s ON (c.contracts_ID = s.contracts_ID)
WHERE 
    d.Name = 'Bilenie Dealership' -- dealership name
    AND c.Date BETWEEN '2024-01-02' AND '2024-01-11';
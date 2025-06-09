-- Drop Creating  Use DataBase

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          CarDealershipDatabase                           #
# ---------------------------------------------------------------------- #

DROP DATABASE IF EXISTS cardealershipdb;

CREATE DATABASE IF NOT EXISTS cardealershipdb;

USE cardealershipdb;

--

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "Dealership"                                                    #
# ---------------------------------------------------------------------- #


CREATE TABLE `dealership` (
    `Dealership_ID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(40) NOT NULL,
    `Address` VARCHAR(60),
    `Contact_Phone` VARCHAR(30),
    CONSTRAINT `PK_dealership` PRIMARY KEY (`Dealership_ID`) 
);
CREATE INDEX `Name` ON `dealership` (`Name`);

--   CONSTRAINT `fk_address_city` FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE (automatically apply changes 
-- (like DELETE or UPDATE) from a parent table to a child table.
-- return_date DATETIME DEFAULT NULL,CONSTRAINT `fk_address_city` FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
-- we use CONSTRAIT multiple line or access the FK later.
-- ENUM want it to specific thing, dallas => set it default Y/N
-- vehicle type 

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "vehicle"                                                    #
# ---------------------------------------------------------------------- #

CREATE TABLE `vehicles` (
  `Vin` int NOT NULL UNIQUE ,
  `Year` INT NOT NULL,
  `Make` varchar(15),
  `Model` varchar(15),
  `Type` varchar(15) NOT NULL,
  `Color` varchar(15)  NOT NULL,
  `Odometer` decimal(10,2) NOT NULL, 
  `Price` decimal(10,2) NOT NULL, 
   `Sold` ENUM( 'Sold' ,'NOT SOLD')  NOT NULL DEFAULT 'NOT SOLD' , -- SOLD BOOL NOT NULL DEFAULT = 0;
  
   CONSTRAINT `PK_Vehicles` PRIMARY KEY (`Vin`)
   )  AUTO_INCREMENT = 100  ; 

-- CREATE INDEX `Vin` ON `vehicles` (`Vin`); --  fast finder label that lets us quickly look up table by column we want.


# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "inventory"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `inventory` (
	`Inventory_ID` INT NOT NULL AUTO_INCREMENT,
	`Dealership_ID` INT NOT NULL,
	`Vin` INT NOT NULL UNIQUE,
	CONSTRAINT fk_inventory_Dealership_ID  FOREIGN KEY (`Dealership_ID`) REFERENCES dealership(Dealership_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_inventory_VIN   FOREIGN KEY (`Vin`) REFERENCES vehicles(`Vin`) ON DELETE RESTRICT ON UPDATE CASCADE, -- not create inventory yet so hold ?? 
	CONSTRAINT `PK_Inventory_ID` PRIMARY KEY (`Inventory_ID`)     
);
# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "contracts"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `contracts`(
	`contracts_ID` INT NOT NULL AUTO_INCREMENT,
    `Vin` INT NOT NULL,
    `Date` DATETIME NOT NULL,
    `CustomerName` VARCHAR(20) NOT NULL,
    `CustomerEmail` VARCHAR(40) NOT NULL,
	`Vehicle` VARCHAR(20) NOT NULL,
	`TotalPrice` decimal(10,2) NOT NULL,
	`MonthlyPayment` decimal(10,2) NOT NULL,
    `Finance` ENUM('IS FINANCE', 'NOT FINANCE') NOT NULL DEFAULT 'IS FINANCE',
	CONSTRAINT `PK_contracts_ID` PRIMARY KEY (`contracts_ID`),
	CONSTRAINT fk_contracts_Vehicle  FOREIGN KEY (`Vin`) REFERENCES vehicles(`Vin`) ON DELETE RESTRICT ON UPDATE CASCADE -- not create inventory yet so hold ?? 
);

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "salescontracts"                                             #
# ---------------------------------------------------------------------- #

CREATE TABLE `salescontracts`(
	`salescontracts_ID` INT NOT NULL AUTO_INCREMENT,
    `contracts_ID`INT NOT NULL,
    `Vin` INT NOT NULL,
    `TaxRate` decimal(10,2) NOT NULL,
    `RecordingFee` decimal(10,2) NOT NULL,
	`ProcessingFee` decimal(10,2) NOT NULL,
    `Finance` ENUM('IS FINANCE', 'NOT FINANCE') NOT NULL DEFAULT 'IS FINANCE',
	CONSTRAINT `PK_salescontracts_ID` PRIMARY KEY (`salescontracts_ID`),
	CONSTRAINT fk_salescontracts_VIN   FOREIGN KEY (`Vin`) REFERENCES vehicles(`Vin`) ON DELETE RESTRICT ON UPDATE CASCADE, -- not create inventory yet so hold ?? 
	CONSTRAINT fk_salescontracts_Cntr  FOREIGN KEY (`contracts_ID`) REFERENCES contracts(`contracts_ID`) ON DELETE RESTRICT ON UPDATE CASCADE -- not create inventory yet so hold ?? 
);

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "leasecontracts"                                             #
# ---------------------------------------------------------------------- #

CREATE TABLE `leasecontracts`(
	`leasecontracts_ID` INT NOT NULL AUTO_INCREMENT,
	`contracts_ID`INT NOT NULL,
    `Vin` INT NOT NULL,
	CONSTRAINT `PK_leasecontracts_ID` PRIMARY KEY (`leasecontracts_ID`),
	CONSTRAINT fk_leasecontracts_VIN   FOREIGN KEY (`Vin`) REFERENCES vehicles(`Vin`) ON DELETE RESTRICT ON UPDATE CASCADE, -- not create inventory yet so hold ?? 
	CONSTRAINT fk_leasecontracts_Cntr  FOREIGN KEY (`contracts_ID`) REFERENCES contracts(`contracts_ID`) ON DELETE RESTRICT ON UPDATE CASCADE -- not create inventory yet so hold ?? 
);


# ---------------------------------------------------------------------- #
# Add info into "dealership"                                             #
# ---------------------------------------------------------------------- #

INSERT INTO  `dealership` ( `Name`,`Address`, `Contact_Phone`) VALUES ( 'D & B Used Cars','111 Old Benbrook Rd' , '817-555-5555'),
( 'Bilenie Dealership','2101 david way' , '4694677887'),
('Auto Express','990 Sunset Blvd', '972-555-1212'),
('Prime Motors','501 Central Ave', '214-123-4567'),
('Speedy Wheels','75 Highway North', '817-111-2222'),
('Texas Auto Galaxy','2120 Western Pkwy', '469-222-3333'),
('Elite Rides','904 Parkway Dr', '682-777-8899'),
('Lone Star Autos','301 Hilltop Rd', '940-654-7788'),
('Budget Auto','4303 East Main St', '214-888-9999'),
('Honest Wheels','1700 Legacy Cir', '469-123-0000'),
('Ride Time Motors','101 Racecar Ln', '817-313-4488'),
('NextGen Auto Sales','620 W Lovers Ln', '214-456-7890'),
('Urban Drive','201 Uptown Blvd', '682-600-9000'),
('Metro Car Hub','45 Commerce Dr', '972-777-1234'),
('EZ Ride Motors','98 Kingwood St', '903-333-5555'),
('Route 66 Deals','600 Western Trl', '432-888-7777'),
('Victory Motors','1500 Lakeview Dr', '214-456-9999'),
('Flash Auto','303 Speedway Rd', '469-000-1111'),
('Sunny Motors','402 Sunshine St', '817-555-1212'),
('Platinum Drive','811 Grand Ave', '214-789-6543'),
('Car King Auto','123 Queen Blvd', '469-321-8765'),
('Select Motors','88 Select Way', '817-400-1234'),
('Riverside Autos','701 River Rd', '214-600-8787'),
('Freedom Auto Mall','490 Liberty Ave', '469-555-6543'),
('Ace Motor Group','9020 Victory Ln', '940-111-9999'),
('All Star Cars','440 Sports Dr', '903-789-0000'),
('Crown Auto Sales','322 Regal Rd', '214-222-3434'),
('Road Ready Rides','533 Journey St', '817-678-2222'),
('American Wheels','7800 Patriot Blvd', '469-123-6789'),
('Galaxy Auto','909 Space Pkwy', '972-654-4321'),
('Value Auto Traders','6400 Dealership Dr', '214-444-1010');

# ---------------------------------------------------------------------- #
# Add info into "vehicles"                                               #
# ---------------------------------------------------------------------- #

INSERT INTO  `vehicles` ( `Vin`,`Year`,`Make`,`Model`,`Type`,`Color`,`Odometer`,`Price` , `Sold`) VALUES 
( 10112,1993 ,'Ford','Explorer','SUV','Red',525123.0,995.0,'SOLD'),
(37846, 2001, 'Ford', 'Ranger', 'Truck', 'Yellow', 172544.0, 1995.0, 'SOLD'),
(44901, 2012, 'Honda', 'Civic', 'SUV', 'Gray', 103221.0, 6995.0, 'SOLD'),
(56233, 2018, 'Toyota', 'Camry', 'Sedan', 'Blue', 45120.0, 15995.0, 'NOT SOLD'),
(78452, 2015, 'Chevrolet', 'Impala', 'Sedan', 'Black', 98500.0, 12450.0, 'SOLD'),
(67321, 2020, 'Nissan', 'Rogue', 'SUV', 'White', 32110.0, 19400.0, 'NOT SOLD'),
(89211, 2008, 'Jeep', 'Wrangler', 'SUV', 'Green', 152340.0, 8450.0, 'SOLD'),
(77934, 2019, 'Tesla', 'Model 3', 'Sedan', 'Silver', 21000.0, 34995.0, 'NOT SOLD'),
(68123, 2016, 'Hyundai', 'Elantra', 'Sedan', 'Maroon', 76000.0, 8995.0, 'SOLD'),
(45098, 2014, 'Kia', 'Sorento', 'SUV', 'White', 88800.0, 10995.0, 'SOLD'),
(23987, 2011, 'Subaru', 'Outback', 'Wagon', 'Gray', 132000.0, 8499.0, 'NOT SOLD'),
(90742, 2005, 'GMC', 'Sierra', 'Truck', 'Blue', 187230.0, 7250.0, 'SOLD'),
(33455, 2003, 'BMW', '325i', 'Sedan', 'Black', 154000.0, 5995.0, 'SOLD');


# ---------------------------------------------------------------------- #
# Add info into "inventory"                                              #
# ---------------------------------------------------------------------- #
INSERT INTO `inventory` (`Dealership_ID`, `Vin`) VALUES
(1, 10112),
(2, 37846),
(3, 44901),
(4, 56233),
(5, 78452),
(6, 67321),
(7, 89211),
(8, 77934),
(9, 68123),
(10, 45098),
(11, 23987),
(12, 90742),
(13, 33455);


# ---------------------------------------------------------------------- #
# Add info into "contracts"                                              #
# ---------------------------------------------------------------------- #

INSERT INTO `contracts` (`Vin`,`Date`, `CustomerName`, `CustomerEmail`, `Vehicle`, `TotalPrice`, `MonthlyPayment`, `Finance`) VALUES
(10112,20240102, 5613101719.29, 3259044595.60, '10112', 13560.96, 237.91, 'IS FINANCE'),
(37846,20240103, 3887218558.42, 7352951656.08, '37846', 26619.06, 619.05, 'IS FINANCE'),
(44901,20240104, 9180167609.98, 6262469287.45, '44901', 10259.69, 341.99, 'NOT FINANCE'),
(56233,20240105, 3572823186.95, 8708773937.47, '56233', 25752.15, 463.67, 'IS FINANCE'),
(78452,20240106, 5938949680.69, 5574382731.44, '78452', 14252.10, 375.16, 'NOT FINANCE'),
(67321,20240107, 1564132269.37, 1084525357.72, '67321', 24833.86, 620.85, 'IS FINANCE'),
(89211,20240108, 8482158587.38, 5882868376.09, '89211', 26763.90, 487.52, 'NOT FINANCE'),
(77934,20240109, 1508212479.84, 1417467729.73, '77934', 20888.87, 464.2, 'NOT FINANCE '),
(68123,20240110, 2792020105.22, 7581102656.94, '68123', 26040.78, 579.79, 'IS FINANCE'),
(45098,20240111, 2943919493.68, 7843505819.85, '45098', 29063.61, 587.09, 'NOT FINANCE'),
(23987,20240112, 1307808414.12, 9494112793.94, '23987', 13236.91, 287.67, 'IS FINANCE'),
(90742,20240113, 1559604080.13, 6129212639.58, '90742', 14671.84, 450.69, 'IS FINANCE'),
(33455,20240114, 1878376167.51, 4823821779.25, '33455', 13498.15, 561.07, 'NOT FINANCE');


# ---------------------------------------------------------------------- #
# Add info into "salescontracts"                                         #
# ---------------------------------------------------------------------- #

INSERT INTO `salescontracts` (`contracts_ID`, `Vin`, `TaxRate`, `RecordingFee`, `ProcessingFee`, `Finance`) VALUES
(1, 10112, 6.12, 122.13, 137.97, 'IS FINANCE'),
(2, 37846, 8.54, 81.96, 454.31, 'IS FINANCE'),
(3, 44901, 6.64, 129.22, 428.09, 'NOT FINANCE'),
(4, 56233, 9.68, 132.97, 275.13, 'IS FINANCE'),
(5, 78452, 6.47, 55.59, 202.47, 'NOT FINANCE'),
(6, 67321, 7.75, 114.63, 337.63, 'IS FINANCE'),
(7, 89211, 7.73, 75.91, 494.18, 'NOT FINANCE'),
(8, 77934, 5.28, 72.57, 127.52, 'NOT FINANCE'),
(9, 68123, 8.18, 141.28, 326.08, 'IS FINANCE'),
(10, 45098, 9.76, 85.79, 151.56, 'NOT FINANCE'),
(11, 23987, 6.74, 108.25, 340.83, 'IS FINANCE'),
(12, 90742, 8.51, 92.94, 392.54, 'IS FINANCE'),
(13, 33455, 6.85, 121.27, 369.92, 'NOT FINANCE');

# ---------------------------------------------------------------------- #
# Add info into "leasecontracts"                                         #
# ---------------------------------------------------------------------- #

INSERT INTO `leasecontracts` (`contracts_ID`, `Vin`) VALUES
(1, 10112),
(2, 37846),
(3, 44901),
(4, 56233),
(5, 78452),
(6, 67321),
(7, 89211),
(8, 77934),
(9, 68123),
(10, 45098),
(11, 23987),
(12, 90742),
(13, 33455);








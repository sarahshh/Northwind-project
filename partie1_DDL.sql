
-- Table CustomerFeedback --
--1. Création de la table 'CustomerFeedback'
CREATE TABLE CustomerFeedback (
  FeedbackID INT PRIMARY KEY,
  CustomerID INT NOT NULL,
  FeedbackText NVARCHAR(1000) NOT NULL,
  FeedbackDate DATETIME NOT NULL
);
-- 2. Ajout d'une contrainte sur la colonne 'FeedbackDate' de la table 'CustomerFeedback'
ALTER TABLE CustomerFeedback
ALTER COLUMN FeedbackDate DATETIME NOT NULL;

---------------------------------------------
---------------------------------------------

-- Modification de Table existante et ajout de contraintes --

--1. Ajout d'une nouvelle colonne appelée 'CategoryID'à la table 'Products'
ALTER TABLE Products
ADD CategoryID INT;
--2. Ajout d'une contrainte sur la colonn CompanyName de la table Customers
-- pour qu'elle ne puisse pas être NULL
ALTER TABLE Customers
ALTER COLUMN CompanyName NVARCHAR(100) NOT NULL;
---
-- 3. Ajout d'une contrainte sur la colonne ShipCity de la table Orders
ALTER TABLE Orders
ALTER COLUMN ShipCity NVARCHAR(100) NOT NULL;

-- 4. Suppression de la colonne 'Discontinued' de la table 'Products'
ALTER TABLE Products
DROP CONSTRAINT DF_Products_Discontinued ;
ALTER TABLE Products
DROP COLUMN Discontinued;

-- 5. Ajout de la colonne 'PhoneNumber' à la table 'Customers'
ALTER TABLE Customers
ADD PhoneNumber NVARCHAR(20);

---------------------------------------------
---------------------------------------------

-- Table OrderItems --
-- 1. Création de la table 'OrderItems'
CREATE TABLE OrderItems (
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  UnitPrice DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (OrderID, ProductID)
);

--1. Ajout d'une contrainte sur la colonne 'Quantity' de la table 'OrderItems'
ALTER TABLE OrderItems
ADD CONSTRAINT CK_OrderItems_Quantity CHECK (Quantity > 0);
-- 2. Ajout d'une contrainte sur la colonne 'UnitPrice' de la table 'OrderItems'
ALTER TABLE OrderItems
ALTER COLUMN UnitPrice DECIMAL(10,2) NOT NULL;

-- 4. Ajout d'une contrainte de clé étrangère sur la colonne 'OrderID' de la table 'OrderItems'
ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Products
FOREIGN KEY (ProductID) REFERENCES Products (ProductID);
---------------------------------------------
---------------------------------------------

-- Table EmployyeeSales --
-- 1. Création de la table 'EmployeeSales'
CREATE TABLE EmployeeSales (
   EmployeeID INT NOT NULL,
   OrderID INT NOT NULL,
   SalesAmount DECIMAL(10,2) NOT NULL,
   PRIMARY KEY (EmployeeID, OrderID),
   CONSTRAINT FK_EmployeeSales_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
   CONSTRAINT FK_EmployeeSales_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

-- 2. Ajout d'une contrainte sur la colonne 'SalesAmount' de la table 'EmployeeSales'
ALTER TABLE EmployeeSales
ADD CONSTRAINT CK_EmployeeSales_SalesAmount CHECK (SalesAmount > 0);

---------------------------------------------
---------------------------------------------

-- Table SupplierProducts --
-- 1. Création de la table 'SupplierProducts'
CREATE TABLE SupplierProducts (
   SupplierID INT NOT NULL,
   ProductID INT NOT NULL,
   Price DECIMAL(10,2) NOT NULL,
   PRIMARY KEY (SupplierID, ProductID),
   CONSTRAINT FK_SupplierProducts_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID),
   CONSTRAINT FK_SupplierProducts_Products FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);


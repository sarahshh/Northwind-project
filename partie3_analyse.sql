--------------------------
|-- Analyse des ventes --|
--------------------------

-- chiffre d'affaire par entreprise
SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
FROM OrderDetails as od;

-- chiffre d'affaire moyen par commande
SELECT AVG(TotalRevenue) as AverageRevenuePerOrder
FROM (
    SELECT o.OrderID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
    FROM Orders as o
    JOIN OrderDetails as od ON o.OrderID = od.OrderID
    GROUP BY o.OrderID
) as SubQuery;

-- 5 produits es plus vendus (selon la quantité)
SELECT TOP 5 p.ProductID, p.ProductName, SUM(od.Quantity) as TotalQuantitySold
FROM Products as p
JOIN OrderDetails as od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantitySold DESC;

-- Chiffre d'affaire total par pays, par client
SELECT COALESCE(c.Country, 'Grand Total') as Country, COALESCE(c.CustomerID, 'Total') as CustomerID, COALESCE(c.CompanyName, 'All Customers') as CompanyName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails as od ON o.OrderID = od.OrderID
GROUP BY ROLLUP (c.Country, c.CustomerID, c.CompanyName);

--------------------------------
|-- Performance des employées --|
--------------------------------

-- Calculer les ventes totales par employé 
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSales
FROM Employees as e
JOIN Orders as o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails as od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;


-- Top 3 des emplyés avec les commandes les plus elevées
SELECT TOP 3 e.EmployeeID, e.FirstName, e.LastName, AVG(TotalRevenue) as AverageRevenuePerOrder
FROM Employees as e
JOIN Orders as o ON e.EmployeeID = o.EmployeeID
JOIN (
    SELECT od.OrderID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
    FROM OrderDetails as od
    GROUP BY od.OrderID
) as SubQuery ON o.OrderID = SubQuery.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY AverageRevenuePerOrder DESC;

-- Retrospective des ventes par employés (1996)

WITH EmployeeSales AS (
    SELECT
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE YEAR(o.OrderDate) = 1996
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT * FROM EmployeeSales;


-------------------------------
|-- Analyse de la clientèle --|
-------------------------------

-- Calculer le montant total dépensé par client
SELECT c.CustomerID, c.CompanyName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSpent
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails as od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName;

-- Identifier le top 5 des clients qui ont dépensé le plus

SELECT TOP 5 c.CustomerID, c.CompanyName, AVG(TotalOrderValue) as AverageOrderValue
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN (
    SELECT od.OrderID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalOrderValue
    FROM OrderDetails as od
    GROUP BY od.OrderID
) as SubQuery ON o.OrderID = SubQuery.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY AverageOrderValue DESC;

-- Affihcer la liste des commandes passées par client
WITH CustomerOrderCount AS (
    SELECT
        c.CustomerID,
        c.CompanyName,
        COUNT(o.OrderID) AS TotalOrders
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CompanyName
)
SELECT * FROM CustomerOrderCount;

-- Identifier les clients qui ont des commandes avec plusieurs employés

WITH CustomerEmployeeInteractions AS (
    SELECT
        c.CustomerID,
        c.CompanyName,
        COUNT(DISTINCT o.EmployeeID) AS EmployeeCount
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CompanyName
),
MultiEmployeeCustomers AS (
    SELECT * FROM CustomerEmployeeInteractions WHERE EmployeeCount > 1
)
SELECT * FROM MultiEmployeeCustomers;

-- Top 5 des clients selon la valeur total de commande
WITH OrderValues AS (
    SELECT
        c.CustomerID,
        c.CompanyName,
        o.OrderID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS OrderValue
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CompanyName, o.OrderID
),
CustomerMinOrderValues AS (
    SELECT
        CustomerID,
        CompanyName,
        MIN(OrderValue) AS MinOrderValue
    FROM OrderValues
    GROUP BY CustomerID, CompanyName
)
SELECT TOP 5
    cmo.CustomerID,
    cmo.CompanyName,
    ov.OrderID,
    cmo.MinOrderValue AS OrderValue
FROM CustomerMinOrderValues cmo
JOIN OrderValues ov ON cmo.CustomerID = ov.CustomerID AND cmo.MinOrderValue = ov.OrderValue
ORDER BY cmo.MinOrderValue DESC;



---------------------------------
|-- Analyse des fournisssuers --|
---------------------------------

-- Total des produits fournis
SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) as TotalProductsSupplied
FROM Suppliers as s
JOIN Products as p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName;

-- Top 3 des fournisseurs avec le plus grand nombre de produits fournis
SELECT TOP 3 s.SupplierID, s.CompanyName, COUNT(p.ProductID) as TotalProductsSupplied
FROM Suppliers as s
JOIN Products as p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName
ORDER BY TotalProductsSupplied DESC;

-- Quantité total fournis par fournisseurs
SELECT s.SupplierID, s.CompanyName, SUM(p.Quantity) as TotalQuantitySupplied
FROM Suppliers as s
JOIN Products as p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName
ORDER BY TotalQuantitySupplied DESC;

-- Top 3 fournisseurs avec la plus grnade quantité de produits fournis
SELECT TOP 3 s.SupplierID, s.CompanyName, SUM(p.UnitsInStock) as TotalQuantitySupplied
FROM Suppliers as s
JOIN Products as p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName
ORDER BY TotalQuantitySupplied DESC;

----------------------------
|-- Analyse des produits --|
----------------------------

-- Calculer la quantité totale de produits vendus par catégorie
SELECT c.CategoryID, c.CategoryName, SUM(od.Quantity) as TotalQuantitySold
FROM Categories as c
JOIN Products as p ON c.CategoryID = p.CategoryID
JOIN OrderDetails as od ON p.ProductID = od.ProductID
GROUP BY c.CategoryID, c.CategoryName;

-- Trouver les 3 principales catégories ayant la plus grande quantité de produits vendus
SELECT TOP 3 c.CategoryID, c.CategoryName, SUM(od.Quantity) as TotalQuantitySold
FROM Categories as c
JOIN Products as p ON c.CategoryID = p.CategoryID
JOIN OrderDetails as od ON p.ProductID = od.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalQuantitySold DESC;

-- Calculer le chiffre d'affaires total généré par catégorie
SELECT c.CategoryID, c.CategoryName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
FROM Categories as c
JOIN Products as p ON c.CategoryID = p.CategoryID
JOIN OrderDetails as od ON p.ProductID = od.ProductID
GROUP BY c.CategoryID, c.CategoryName;

-- Trouver les 3 principales catégories ayant le chiffre d'affaires le plus élevé
SELECT TOP 3 c.CategoryID, c.CategoryName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalRevenue
FROM Categories as c
JOIN Products as p ON c.CategoryID = p.CategoryID
JOIN OrderDetails as od ON p.ProductID = od.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;

-- Top 10 des produits les plus chers (par prix unitaire)
WITH TopProducts AS (
    SELECT TOP 10
        p.ProductName,
        p.UnitPrice,
        c.CategoryName
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
    ORDER BY p.UnitPrice DESC
)
SELECT * FROM TopProducts;

-- Calculer la quantité totale de chaque produit vendu
WITH ProductQuantities AS (
    SELECT
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS TotalQuantity
    FROM Products p
    LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT * FROM ProductQuantities;




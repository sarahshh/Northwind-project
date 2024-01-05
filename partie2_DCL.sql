-- Equipe vente
CREATE LOGIN SalesUser WITH PASSWORD = 'QcAmKhsEKjVBpAU3';
CREATE USER SalesRep FOR LOGIN SalesUser;
GRANT SELECT ON Customers TO SalesRep;
GRANT SELECT ON Orders TO SalesRep;

DENY SELECT ON Employees TO SalesRep;


-- Equipe expédition
CREATE LOGIN ShippingUser WITH PASSWORD = 'xATXMKAB67svBAMl';
CREATE USER ShippingClerk FOR LOGIN ShippingUser;
GRANT SELECT ON Orders TO ShippingClerk;
GRANT SELECT ON Shippers TO ShippingClerk;

-- Equipe comptable
CREATE LOGIN AccountingUser WITH PASSWORD = 'QRIz0da7beE7UBrc';
CREATE USER Accountant FOR LOGIN AccountingUser;
GRANT SELECT ON Orders TO Accountant;
GRANT SELECT ON OrderDetails TO Accountant;

-- Equipe Manger
CREATE LOGIN ManagerUser WITH PASSWORD = '4i58qkQFJKQ8ayb6';
CREATE USER Manager FOR LOGIN ManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO Manager;
GRANT EXECUTE ON EmployeeSalesByCountry TO Manager;




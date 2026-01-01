use Northwind;

    SELECT  c.CustomerID, o.OrderID,
       ROW_NUMBER() OVER(PARTITION BY c.CustomerID 
                         ORDER BY o.OrderDate DESC) AS 'RowN'
    FROM dbo.Customers c
    INNER JOIN dbo.Orders o ON o.CustomerID = c.CustomerID

/* Check if SQL CLR is activated */
EXEC sp_configure 'clr enabled';

SELECT name, value, value_in_use
FROM sys.configurations
WHERE name = 'clr enabled';

/* Check if there exists any assemblies */
SELECT *
FROM sys.assemblies
WHERE is_user_defined = 1;

SELECT * FROM sys.dm_clr_properties

/* turn on SQL CLR: Required for clr strict security to be visible and configurable */
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;

/* allows unsigned assemblies to be loaded */
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;
GO

SELECT @@VERSION;

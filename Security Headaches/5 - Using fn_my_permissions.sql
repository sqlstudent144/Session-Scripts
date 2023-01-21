/* What permission do I have for xyz object? */
USE [😺&🐯&🐻o🙋];
GO
/*** Display my permissions. Note: As a sysadmin that's all of them. ***/
SELECT * FROM sys.fn_my_permissions(N'Emerald🏰', 'Object');
SELECT * FROM sys.fn_my_permissions(N'😺&🐯&🐻o🙋', 'Database');
GO

/*** Impersonate Scare🐦 so we can their permissions. ***/
EXECUTE AS USER = N'Scare🐦'
GO
SELECT * FROM sys.fn_my_permissions(N'Emerald🏰', 'Object');
SELECT * FROM sys.fn_my_permissions(N'😺&🐯&🐻o🙋', 'Database');
GO
/*** Revert to go back to my permissions so I can run sp_DBPermissions. ***/
REVERT;
GO

/*** Review the relevant principals. ***/
EXEC sp_DBPermissions NULL, N'Scare🐦';
EXEC sp_DBPermissions NULL, N'Flying🐒';

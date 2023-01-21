/* Why can't I drop this user? */
/*** Setup ***/
USE [😺&🐯&🐻o🙋];
GO
CREATE USER [Kenneth-Laptop\Dopey] FROM LOGIN [Kenneth-Laptop\Dopey];
ALTER ROLE db_ddladmin ADD MEMBER [Kenneth-Laptop\Dopey]
GRANT SELECT ON SCHEMA::dbo TO [Kenneth-Laptop\Dopey] WITH GRANT OPTION;
GO
EXECUTE AS USER = 'Kenneth-Laptop\Dopey';
GO
CREATE SCHEMA [Dopeys]
	CREATE TABLE [AlsoDopeys] (Col1 INT);
GO
GRANT SELECT ON [Dopeys].[AlsoDopeys] TO [Scare🐦]
GRANT SELECT ON SCHEMA::dbo TO [Tin🌲👨]
REVERT;
GO
/*** Try to drop the user ***/
DROP USER [Kenneth-Laptop\Dopey]
GO
/*** Check Dopey out since we couldn't drop it. ***/
EXEC sp_DBPermissions NULL, 'Dopey'
GO
/*** If you don't want to use the GUI (I generally don't)
then this query will list all of the schemas an ID owns. ***/
SELECT * FROM sys.schemas WHERE principal_id = 
			(SELECT principal_id FROM sys.database_principals WHERE name like '%Dopey%')
GO
/*** Change the owner of the schema. Be warned this could 
change your permissions (see ownership chaining). If needed 
you could create a SQL Id/user without a login specifically 
to own the schema. Assuming it's needed of course. ***/
ALTER AUTHORIZATION ON SCHEMA::[Dopeys] TO dbo
GO
/*** Try to drop the user again. ***/
DROP USER [Kenneth-Laptop\Dopey]
GO
/*** List the permissions other than roles. ***/
EXEC sp_DBPermissions @Type = '[^R]'
GO
/*** Remove the permission granted by Dopey. Since multiple people
can grant the same permission to the same user I prefer to remove
the specific one I want. ***/
REVOKE SELECT ON SCHEMA::[dbo] FROM [Tin🌲👨] AS [Kenneth-Laptop\Dopey]; 
/*** If they don't have the permissions another way make sure to 
grant the permission back. We don't want [Tin🌲👨] calling to 
ask why they can't run queries. ***/
GRANT SELECT ON SCHEMA::[dbo] TO [Tin🌲👨];
GO
/*** Now we can drop the user! ***/
DROP USER [Kenneth-Laptop\Dopey]
/*** Cleanup **********************/
DROP TABLE [Dopeys].[AlsoDopeys];
DROP SCHEMA [Dopeys];
REVOKE SELECT ON SCHEMA::[dbo]  FROM [Tin🌲👨];
GO

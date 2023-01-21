/* General Overview */
/*** View all instance level permissions ***/
EXEC sp_SrvPermissions;
/*** View all instance level permissions for 
principals with the letters "Ken" in them. ***/
EXEC sp_SrvPermissions 'Ken';
/*** View all instance level permissions for 
principals with the letters "ken" in them. ***/
EXEC sp_SrvPermissions 'ken';
/*** Print out the queries used to view
all instance level permissions ***/
EXEC sp_SrvPermissions @Print = 1;
/*** View all permissions for the database StackOverflow2013 ***/
EXEC sp_DBPermissions 'StackOverflow2013';
/*** View all permissions for all of the active 
databases on the instance ***/
EXEC sp_DBPermissions 'All';

/* I need a list of all sysadmins on the instance. */
EXEC sp_SrvPermissions @Role = 'sysadmin';

/* Please backup the permissions for [😺&🐯&🐻o🙋]. */
EXEC sp_DBPermissions N'😺&🐯&🐻o🙋';
GO
USE [😺&🐯&🐻o🙋];
GO
/*** Exclude permissions created by MS ***/
EXEC sp_DBPermissions @IncludeMSShipped = 0;
GO
/*** Show only the drop and create scripts for the current DB ***/
EXEC sp_DBPermissions @Output = 'ScriptOnly';
GO
/*** Show only the create scripts for the current DB ***/
EXEC sp_DBPermissions @Output = 'CreateOnly';
GO
/*** Show the drop and create scripts for the DB StackOverflow2013 ***/
EXEC sp_DBPermissions 'StackOverflow2013',  @Output = 'ScriptOnly'
GO

/* I need a security report for 'StackOverflow2013' */
/*** Display principals for DB StackOverflow2013 with comma
delimited lists of roles and direct permissions for each ***/
EXEC sp_DBPermissions 'StackOverflow2013', @Output = 'Report';
GO
/*** Display principals for DB StackOverflow2013 with comma
delimited lists of roles and direct permissions for each.
Exclude principals created by MS. ***/
EXEC sp_DBPermissions 'StackOverflow2013', @Output = 'Report', @IncludeMSShipped = 0;
GO
/*** Display principals for the instance with coma delimited
lists of instance level roles and direct permissions for each. ***/
EXEC sp_SrvPermissions @Output = 'Report';
GO

/* Please copy all of the logins from this instance to that instance. */
/*** Display create/grant scripts for all permissions at the instance level ***/
EXEC sp_SrvPermissions @Output = 'CreateOnly';
GO
/*** Display permissions information at the instance level excluding 
certificates (type C) and anything created by MS. ***/
EXEC sp_SrvPermissions @IncludeMSShipped = 0, @Type = '[^C]';
GO
/*** Display create/grant scripts for permissions at the instance 
level excluding certificats (type C) (no scripts are generated for
permissions created by MS. ***/
EXEC sp_SrvPermissions @Output = 'CreateOnly', @Type = '[^C]';
GO

/* I'm copying the database [😺&🐯&🐻o🙋] and I need you to move the logins. */
/*** Display create/grant scripts for permissions at the instance 
level for any instance level principal that is used in the database 
😺&🐯&🐻o🙋 ***/
EXEC sp_SrvPermissions @DBName = N'😺&🐯&🐻o🙋', @Output = 'CreateOnly';
GO

/* Please copy all of the permissions from Scare🐦 to Tin🌲👨 */
EXEC sp_DBPermissions N'😺&🐯&🐻o🙋', N'Scare🐦', @Output = N'CreateOnly';
GO
/*** Generate create/grant scripts for Scare🐦 in the database 
😺&🐯&🐻o🙋 then replace "Scare🐦" with "Tin🌲👨". Note:
This only works from SQL Id to SQL Id or AD Id/Group to AD id/Group ***/
EXEC sp_DBPermissions N'😺&🐯&🐻o🙋', N'Scare🐦', @Output = N'CreateOnly', @CopyTo = N'Tin🌲👨';
GO
/* While we are at it does Scare🐦 have permissions in any other databases? */
/*** Display permissions for Scare🐦 in all databases ***/
EXEC sp_DBPermissions N'All', @LoginName = N'Scare🐦'
GO
/*** Display create/grant and drop/revoke scripts for Scare🐦 
in all databases. Note: Because we ran this for databases there
is a USE in front of each piece of code to make sure it's run in
the right database. ***/
EXEC sp_DBPermissions N'All', N'Scare🐦', @Output = 'ScriptOnly'
GO

/*** Generate create/grant scripts for Scare🐦 in all databases ***/
EXEC sp_DBPermissions N'All', N'Scare🐦', @Output = N'CreateOnly', @CopyTo = N'Tin🌲👨';
GO

/* Dealing with Orphans */
/*** Setup ***/
CREATE LOGIN [Kenneth-Laptop\Sleepy] FROM WINDOWS;
CREATE USER [Kenneth-Laptop\Sleepy] FROM LOGIN [Kenneth-Laptop\Sleepy];
DROP LOGIN [Kenneth-Laptop\Sleepy];
CREATE LOGIN Sleepy WITH PASSWORD = 'Sleepy@1';
CREATE USER [Sleepy] FROM LOGIN [Sleepy];
DROP LOGIN [Sleepy];

/*** Find orphaned users. ***/
EXEC sp_DBPermissions @ShowOrphans = 1

/*** Cleanup ***/
DROP LOGIN [Kenneth-Laptop\Sleepy];
DROP LOGIN [Sleepy];
DROP USER [Kenneth-Laptop\Sleepy];
DROP USER [Sleepy];

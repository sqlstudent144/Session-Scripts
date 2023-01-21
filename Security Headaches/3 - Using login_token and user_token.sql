/* List AD groups and roles that I'm a member of */
SELECT * FROM sys.login_token;
GO
/*** Because I'm sysadmin the user level view doesn't show much ***/
SELECT * FROM sys.user_token;
GO
/* List AD groups that I'm using to get access to anything in this instance */
SELECT * FROM sys.login_token WHERE principal_id > 0;
GO

/* List AD groups that you're using to get access to this database */
/*** You can't impersonate a group. ***/
EXECUTE AS LOGIN = 'Kenneth-Laptop\Miner'; 
/*** You can impersonate SQL users and AD users. ***/
EXECUTE AS LOGIN = 'Kenneth-Laptop\Dopey';
GO
/*** All groups and instance level roles that Dopey is a member of. ***/
SELECT * FROM sys.login_token ;
GO
/*** All instance level roles that Dopey is a member of,
but just the groups that are used in this instance. ***/
SELECT * FROM sys.login_token WHERE principal_id > 0;
GO
/*** All groups that Dopey is a member of and DB level roles  
he has for the current DB. ***/
SELECT * FROM sys.user_token ;
GO
/*** Let's try again but for a different database. ***/
USE StackOverflow2013;
GO
SELECT * FROM sys.user_token ;
GO
/*** Only display the roles and groups for Dopey that
are used in the current database. ***/
SELECT * FROM sys.user_token WHERE principal_id > 0;
GO
/*** You can't REVERT if you've changed databases. ***/
REVERT;
GO
/*** You have to go back to the original DB where you 
impersonated the ID before you can revert. ***/
USE master;
REVERT;
GO

/* Blick and Snick are new hires and need the same permissions as 
Grumpy in StackOverflow2013. */
USE StackOverflow2013
GO
/*** Let's look at Grumpy's permissions first ***/
EXEC sp_DBPermissions NULL, 'Grumpy';
GO
/*** Now impersonate Grump. Everything after this command
(until we REVERT) is run as if it was run by Grumpy. ***/
EXECUTE AS USER = 'Kenneth-Laptop\Grumpy';
GO
/*** Check out Grumpy's roles and groups. ***/
SELECT * FROM sys.user_token ;
/*** Narrow it down to just to the roles and the groups 
specific to the database. ***/
SELECT * FROM sys.user_token WHERE principal_id > 0;
GO
/*** Back to being me so I can run the next step. ***/
REVERT;
GO
/*** Check out the permissions granted to the associated groups. ***/
EXEC sp_DBPermissions NULL, 'Miner';
EXEC sp_DBPermissions NULL, 'Dwarf';
GO
EXEC sp_DBPermissions 'All', 'Miner';
EXEC sp_DBPermissions 'All', 'Dwarf';
GO
/* I've got a new hire Flick and they are joining the same team as Sneezy and Sleepy
   and need the same permissions they have. */
/*** Load the permissions for Sneezy into a temp table. ***/
EXECUTE AS USER = 'Kenneth-Laptop\Sneezy';
SELECT DISTINCT name, type INTO #Sneezy FROM sys.user_token WHERE principal_id > 0;
REVERT
GO
/*** Load the permissions for Sleepy into a temp table. ***/
EXECUTE AS USER = 'Kenneth-Laptop\Sleepy';
SELECT DISTINCT name, type INTO #Sleepy FROM sys.user_token WHERE principal_id > 0;
REVERT
GO
/*** Compare the two temp tables to see which groups 
both people are a member of. ***/
SELECT name, type FROM #Sneezy
INTERSECT
SELECT name, type FROM #Sleepy;
GO
/*** Cleanup ***/
DROP TABLE #Sneezy;
DROP TABLE #Sleepy;
GO
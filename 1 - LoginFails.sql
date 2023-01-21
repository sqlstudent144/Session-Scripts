/*I can't log in, I'm getting this error: Login failed for user ''.
Flying🐒
Scare🐦- SimplePassword@1
MySQLId - MySQLId
*/


/* Simple script to check a SQL authenticated login 
and unlock it if it's locked.*/
IF LOGINPROPERTY('SQLID','islocked') = 1
BEGIN
    ALTER LOGIN SQLID WITH CHECK_POLICY=OFF;
    ALTER LOGIN SQLID WITH CHECK_POLICY=ON;
END
GO
/* -------------------------------------------------------
Check the default database of this id.*/
SELECT * FROM sys.server_principals WHERE name = 'MySQLId'

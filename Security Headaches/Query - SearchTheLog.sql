IF OBJECT_ID('tempdb.dbo.#LogInfo') IS NOT NULL
	DROP TABLE #LogInfo;

DECLARE @searchstring1 nvarchar(500) = '';
DECLARE @searchstring2 nvarchar(500) = '';
DECLARE @Limit int = 1;

----------------------------------------------------------------------
-- This part of the code was found here: 
-- https://ask.sqlservercentral.com/questions/99484/number-of-error-log-files.html
  
DECLARE @FileList AS TABLE (
    subdirectory NVARCHAR(4000) NOT NULL
    ,DEPTH BIGINT NOT NULL
    ,[FILE] BIGINT NOT NULL
);
  
DECLARE @ErrorLog NVARCHAR(4000), @ErrorLogPath NVARCHAR(4000);
SELECT @ErrorLog = CAST(SERVERPROPERTY(N'errorlogfilename') AS NVARCHAR(4000));
SELECT @ErrorLogPath = SUBSTRING(@ErrorLog, 1, LEN(@ErrorLog) - CHARINDEX(N'\', REVERSE(@ErrorLog))) + N'\';

  
INSERT INTO @FileList
EXEC xp_dirtree @ErrorLogPath, 0, 1;

DECLARE @NumberOfLogfiles INT;
SET @NumberOfLogfiles = (SELECT COUNT(*) FROM @FileList WHERE [@FileList].subdirectory LIKE N'ERRORLOG%');
-- SELECT @NumberOfLogfiles;
If @Limit IS NOT NULL AND @NumberOfLogfiles > @Limit
    SET @NumberOfLogfiles = @Limit
----------------------------------------------------------------------
  
CREATE TABLE #LogInfo (
    LogDate datetime, 
    ProcessInfo nvarchar(500), 
    ErrorText nvarchar(max))
  
DECLARE @p1 INT = 0
  
WHILE @p1 < @NumberOfLogfiles
BEGIN
    -- P1 is the file number starting at 0
    DECLARE 
    @p2 INT = 1, 
    -- P2 1 for SQL logs, 2 for SQL Agent logs
    @p3 NVARCHAR(255) = @searchstring1, 
    -- P3 is a value to search on
    @p4 NVARCHAR(255) = @searchstring2
    -- P4 is another search value
  
BEGIN TRY
    INSERT INTO #LogInfo 
    EXEC sys.xp_readerrorlog @p1,@p2,@p3,@p4 
END TRY
BEGIN CATCH
    PRINT 'Error occurred processing file ' + cast(@p1 as varchar(10))
END CATCH
  
SET @p1 = @p1 + 1
END

SELECT * FROM #LogInfo 
WHERE ProcessInfo NOT IN ('Backup')
and ErrorText LIKE N'%MySQLId%'
-- and errortext not like '%succeeded%'
-- and logdate between '2022-01-12 17:00' and '2022-01-12 17:30'
ORDER BY LogDate DESC

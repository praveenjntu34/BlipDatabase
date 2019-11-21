DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'BlipDev'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

--SELECT @SQL 
EXEC(@SQL)

drop DATABASE BlipDev
CREATE DATABASE BlipDev
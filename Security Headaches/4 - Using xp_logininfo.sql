/* Who are the members of this AD group? */
USE master;
GO
EXEC xp_logininfo N'Kenneth-Laptop\Dwarf', 'members';
GO

/*** Similar to what we did previously. Create temp tables
to store the group members for Dwarf and Miner. ***/
CREATE TABLE #Dwarf (name sysname, type varchar(10), privilage varchar(10), mapped_name sysname, permission_path sysname);
CREATE TABLE #Miner (name sysname, type varchar(10), privilage varchar(10), mapped_name sysname, permission_path sysname);

/*** Load the members of Dwarf into a temp table ***/
INSERT INTO #Dwarf
EXEC xp_logininfo N'Kenneth-Laptop\Dwarf', 'members';

/*** Load the members of Miner into a temp table ***/
INSERT INTO #Miner
EXEC xp_logininfo N'Kenneth-Laptop\Miner', 'members';

/*** Who's in both groups ***/
SELECT name FROM #Dwarf
INTERSECT
SELECT name FROM #Miner;

/*** Who's in #Dwarf but not #Miner ***/
SELECT name FROM #Dwarf
EXCEPT
SELECT name FROM #Miner;

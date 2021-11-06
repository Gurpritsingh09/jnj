/*
 === GRANT SELECT PERMISSION FOR APP TEAM ===
*/
SET @appteampermissionquery = CONCAT('GRANT SELECT on ', @dbname,'.* to "',@appteam,'"');
PREPARE appteampermissionstmt from @appteampermissionquery;
EXECUTE appteampermissionstmt;
DEALLOCATE PREPARE appteampermissionstmt;

/*
 === GRANT SELECT PERMISSION FOR APP TEAM ===
*/
SET @appteampermissionquery = CONCAT('GRANT SELECT on dsepdicomdbqa2.* to "',@appteam,'"');
PREPARE appteampermissionstmt2 from @appteampermissionquery;
EXECUTE appteampermissionstmt2;
DEALLOCATE PREPARE appteampermissionstmt2;

/*
 === GRANT ALL PERMISSION FOR APP DB USER ===
*/
SET @appdbuserpermissionquery = CONCAT('GRANT ALL on ', @dbname,'.* to "',@dbuser,'"');
PREPARE appdbuserpermissionstmt from @appdbuserpermissionquery;
EXECUTE appdbuserpermissionstmt;
DEALLOCATE PREPARE appdbuserpermissionstmt;

SET @appdbuserpermissionquery = CONCAT('GRANT ALL on dsepdicomdbqa2.* to "',@dbuser,'"');
PREPARE appdbuserpermissionstmt2 from @appdbuserpermissionquery;
EXECUTE appdbuserpermissionstmt2;
DEALLOCATE PREPARE appdbuserpermissionstmt2;
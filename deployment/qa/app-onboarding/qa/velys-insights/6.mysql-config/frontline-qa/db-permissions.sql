/*
 === GRANT ALL PERMISSION FOR APP TEAM ===
*/
SET @appteampermissionquery = CONCAT('GRANT SELECT on ', @dbname,'.* to "',@appteam,'"');
PREPARE appteampermissionstmt from @appteampermissionquery;
EXECUTE appteampermissionstmt;
DEALLOCATE PREPARE appteampermissionstmt;

/*
 === GRANT ALL PERMISSION FOR APP DB USER ===
*/
SET @appdbuserpermissionquery = CONCAT('GRANT ALL on frontline_qa.* to "',@dbuser,'"');
PREPARE appdbuserpermissionstmt from @appdbuserpermissionquery;
EXECUTE appdbuserpermissionstmt;
DEALLOCATE PREPARE appdbuserpermissionstmt;

SET @appdbuserpermissionquery = CONCAT('GRANT ALL on frontline_model_qa.* to "',@dbuser,'"');
PREPARE appdbuserpermissionstmt from @appdbuserpermissionquery;
EXECUTE appdbuserpermissionstmt;
DEALLOCATE PREPARE appdbuserpermissionstmt;


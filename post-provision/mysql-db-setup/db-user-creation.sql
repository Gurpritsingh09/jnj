/*
 === CREATE DATABASE FOR APP TEAM
*/
SET @dbcreationquery = CONCAT('create database IF NOT EXISTS ',@dbname);
PREPARE dbstmt from @dbcreationquery;
EXECUTE dbstmt;
DEALLOCATE PREPARE dbstmt;
/*
 === CREATE USER FOR APP TEAM
*/
SET @usercreationquery = CONCAT('CREATE user IF NOT EXISTS "', @dbuser,'" IDENTIFIED by "', @password, '"');
PREPARE userstmt from @usercreationquery;
EXECUTE userstmt;
DEALLOCATE PREPARE userstmt;

/*
 === CREATE AADUSER FOR APP TEAM
*/
SET @aadusercreationquery = CONCAT('CREATE aaduser IF NOT EXISTS "', @aaduser, '"');
PREPARE useradstmt from @aadusercreationquery;
EXECUTE useradstmt;
DEALLOCATE PREPARE useradstmt;

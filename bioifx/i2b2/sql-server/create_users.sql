/* Create Databases */
CREATE DATABASE i2b2demodata;
CREATE DATABASE i2b2hive;
CREATE DATABASE i2b2imdata;
CREATE DATABASE i2b2metadata;
CREATE DATABASE i2b2pm;
CREATE DATABASE i2b2workdata;
CREATE DATABASE omop;
GO

/* OMOP User */
USE omop;
GO
CREATE LOGIN omop WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER omop;
GO
CREATE USER omop FOR LOGIN omop;
GRANT ALL TO omop;
GO


/* CRC Data User */
USE i2b2demodata;
GO
CREATE LOGIN i2b2demodata WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2demodata;
GO
CREATE USER i2b2demodata FOR LOGIN i2b2demodata;
GRANT ALL TO i2b2demodata;
GO

/* Hive Data User */
USE i2b2hive;
GO
CREATE LOGIN i2b2hive WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2hive;
GO
CREATE USER i2b2hive FOR LOGIN i2b2hive;
GRANT ALL TO i2b2hive;
GO

/* IM Data User */
USE i2b2imdata;
GO
CREATE LOGIN i2b2imdata WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2imdata;
GO
CREATE USER i2b2imdata FOR LOGIN i2b2imdata;
GRANT ALL TO i2b2imdata;
GO

/* Meta Data User */
USE i2b2metadata;
GO
CREATE LOGIN i2b2metadata WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2metadata;
GO
CREATE USER i2b2metadata FOR LOGIN i2b2metadata;
GRANT ALL TO i2b2metadata;
GO

/* PM Data User */
USE i2b2pm;
GO
CREATE LOGIN i2b2pm WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2pm;
GO
CREATE USER i2b2pm FOR LOGIN i2b2pm;
GRANT ALL TO i2b2pm;
GO

/* Work Data User */
USE i2b2workdata;
GO
CREATE LOGIN i2b2workdata WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER i2b2workdata;
GO
CREATE USER i2b2workdata FOR LOGIN i2b2workdata;
GRANT ALL TO i2b2workdata;
GO

QUIT

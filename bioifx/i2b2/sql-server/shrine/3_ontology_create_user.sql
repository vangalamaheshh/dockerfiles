/* login with SQLSERVER admin creds and create shrine_ont user and grant permissions */
/* shrine_ont User */
CREATE DATABASE shrine_ont;
GO
USE shrine_ont;
GO
CREATE LOGIN shrine_ont WITH PASSWORD = 'Demou$er';
GO
ALTER SERVER ROLE sysadmin ADD MEMBER shrine_ont;
GO
CREATE USER shrine_ont FOR LOGIN shrine_ont;
GRANT ALL TO shrine_ont;
GO

QUIT

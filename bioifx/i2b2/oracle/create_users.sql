/*

*/
ALTER TABLESPACE SYSTEM ADD DATAFILE '/u01/app/oracle/oradata/XE/userdata03.dbf' SIZE 2000M;

-- CRC Data User
create user I2B2DEMODATA identified by demouser;
grant connect to I2B2DEMODATA;
grant all privileges to I2B2DEMODATA identified by demouser;
GRANT CONNECT TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2DEMODATA;
ALTER USER I2B2DEMODATA DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2DEMODATA;
GRANT CREATE TABLE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2DEMODATA WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2DEMODATA;
GRANT UNLIMITED TABLESPACE TO I2B2DEMODATA WITH ADMIN OPTION;


-- Hive Data User
create user I2B2HIVE identified by demouser;
grant connect to I2B2HIVE;
grant all privileges to I2B2HIVE identified by demouser;
GRANT CONNECT TO I2B2HIVE WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2HIVE WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2HIVE;
ALTER USER I2B2HIVE DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2HIVE;
GRANT CREATE TABLE TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2HIVE WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2HIVE WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2HIVE;
GRANT UNLIMITED TABLESPACE TO I2B2HIVE WITH ADMIN OPTION;

-- IM Data User
create user I2B2IMDATA identified by demouser;
grant connect to I2B2IMDATA;
grant all privileges to I2B2IMDATA identified by demouser;
GRANT CONNECT TO I2B2IMDATA WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2IMDATA;
ALTER USER I2B2IMDATA DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2IMDATA;
GRANT CREATE TABLE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2IMDATA WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2IMDATA WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2IMDATA;
GRANT UNLIMITED TABLESPACE TO I2B2IMDATA WITH ADMIN OPTION;

-- Meta Data User
create user I2B2METADATA identified by demouser;
grant connect to I2B2METADATA;
grant all privileges to I2B2METADATA identified by demouser;
GRANT CONNECT TO I2B2METADATA WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2METADATA WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2METADATA;
ALTER USER I2B2METADATA DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2METADATA;
GRANT CREATE TABLE TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2METADATA WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2METADATA WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2METADATA;
GRANT UNLIMITED TABLESPACE TO I2B2METADATA WITH ADMIN OPTION;

-- PM Data User
create user I2B2PM identified by demouser;
grant connect to I2B2PM;
grant all privileges to I2B2PM identified by demouser;
GRANT CONNECT TO I2B2PM WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2PM WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2PM;
ALTER USER I2B2PM DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2PM;
GRANT CREATE TABLE TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2PM WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2PM WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2PM;
GRANT UNLIMITED TABLESPACE TO I2B2PM WITH ADMIN OPTION;

-- Work Data User
create user I2B2WORKDATA identified by demouser;
grant connect to I2B2WORKDATA;
grant all privileges to I2B2WORKDATA identified by demouser;
GRANT CONNECT TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT RESOURCE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT SELECT_CATALOG_ROLE TO I2B2WORKDATA;
ALTER USER I2B2WORKDATA DEFAULT ROLE ALL;
GRANT CREATE PROCEDURE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE ROLE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE SEQUENCE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE SYNONYM TO I2B2WORKDATA;
GRANT CREATE TABLE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE TYPE TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT CREATE VIEW TO I2B2WORKDATA WITH ADMIN OPTION;
GRANT SELECT ANY DICTIONARY TO I2B2WORKDATA;
GRANT UNLIMITED TABLESPACE TO I2B2WORKDATA WITH ADMIN OPTION;

quit;

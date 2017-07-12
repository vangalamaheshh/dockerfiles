/*

*/
ALTER TABLESPACE SYSTEM ADD DATAFILE '/u01/app/oracle/oradata/XE/userdata03.dbf' SIZE 2000M;

-- CRC Data User
create user i2b2demodata identified by demouser;
grant connect to i2b2demodata;
grant all privileges to i2b2demodata identified by demouser;

-- Hive Data User
create user i2b2hive identified by demouser;
grant connect to i2b2hive;
grant all privileges to i2b2hive identified by demouser;

-- IM Data User
create user i2b2imdata identified by demouser;
grant connect to i2b2imdata;
grant all privileges to i2b2imdata identified by demouser;

-- Meta Data User
create user i2b2metadata identified by demouser;
grant connect to i2b2metadata;
grant all privileges to i2b2metadata identified by demouser;

-- PM Data User
create user i2b2pm identified by demouser;
grant connect to i2b2pm;
grant all privileges to i2b2pmdata identified by demouser;

-- Work Data User
create user i2b2workdata identified by demouser;
grant connect to i2b2workdata;
grant all privileges to i2b2workdata identified by demouser;

quit;

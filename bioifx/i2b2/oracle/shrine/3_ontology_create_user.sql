alter session set "_ORACLE_SCRIPT"=true; 
-- login with ORACLE admin creds and insert following rows
create user SHRINE_ONT identified by demouser;
grant create session, connect, resource to SHRINE_ONT;

-- i2b2metadata.table_access
grant all privileges to SHRINE_ONT;

quit;

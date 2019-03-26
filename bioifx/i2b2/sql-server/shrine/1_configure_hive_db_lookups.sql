/* login with i2b2hive creds and insert following rows using i2b2hive database */
insert into ONT_DB_LOOKUP
(C_DOMAIN_ID, C_PROJECT_PATH, C_OWNER_ID, C_DB_FULLSCHEMA, C_DB_DATASOURCE, C_DB_SERVERTYPE, C_DB_NICENAME)
VALUES
('i2b2demo','SHRINE/','@','shrine_ont.dbo','java:/OntologyShrineDS','SQLSERVER','SHRINE');

insert into CRC_DB_LOOKUP
(C_DOMAIN_ID, C_PROJECT_PATH, C_OWNER_ID, C_DB_FULLSCHEMA, C_DB_DATASOURCE, C_DB_SERVERTYPE, C_DB_NICENAME)
VALUES
( 'i2b2demo', '/SHRINE/', '@', 'i2b2demodata.dbo', 'java:/QueryToolDemoDS', 'SQLSERVER', 'SHRINE' );

GO
QUIT

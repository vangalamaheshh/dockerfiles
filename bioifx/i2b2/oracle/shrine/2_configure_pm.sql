alter session set "_ORACLE_SCRIPT"=true;
-- login with i2b2pm creds and insert following rows
-- Create user shrine/demouser
insert into PM_USER_DATA
(user_id, full_name, password, status_cd)
values
('SHRINE', 'shrine', '9117d59a69dc49807671a51f10ab7f', 'A');

-- TODO Override the ecommons requirement
-- http://open.med.harvard.edu/jira/browse/SHRINE-671
-- insert into PM_USER_PARAMS
-- (DATATYPE_CD, USER_ID, PARAM_NAME_CD, VALUE, CHANGEBY_CHAR, STATUS_CD)
-- values
-- ('T', 'shrine', 'ecommons_username', 'shrine', 'i2b2', 'A');

-- CREATE THE PROJECT for SHRINE
insert into PM_PROJECT_DATA
(project_id, project_name, project_wiki, project_path, status_cd)
values
('SHRINE', 'SHRINE', 'http://open.med.harvard.edu/display/SHRINE', '/SHRINE', 'A');

insert into PM_PROJECT_USER_ROLES
(PROJECT_ID, USER_ID, USER_ROLE_CD, STATUS_CD)
values
('SHRINE', 'SHRINE', 'USER', 'A');

insert into PM_PROJECT_USER_ROLES
(PROJECT_ID, USER_ID, USER_ROLE_CD, STATUS_CD)
values
('SHRINE', 'SHRINE', 'DATA_OBFSC', 'A');

-- captures information and registers the cells associated to the hive.
insert into PM_CELL_DATA
(cell_id, project_path, name, method_cd, url, can_override, status_cd)
values
('CRC_SHRINE', '/SHRINE', 'SHRINE Federated Query', 'REST', 'https://localhost:6443/shrine/rest/i2b2/', 1, 'A');

quit;

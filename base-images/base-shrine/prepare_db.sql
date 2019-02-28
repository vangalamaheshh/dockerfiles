create database shrine_query_history;
use shrine_query_history;
/* Working tables in shrine_query_history */
create table `problems` (`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`codec` TEXT NOT NULL,`stampText` TEXT NOT NULL,`summary` TEXT NOT NULL,`description` TEXT NOT NULL,`detailsXml` TEXT NOT NULL,`epoch` BIGINT NOT NULL);
create index `idx_epoch` on `problems` (`epoch`);

create table SHRINE_QUERY(
  id int not null auto_increment,
  local_id varchar(255) not null,
  network_id bigint not null,
  username varchar(255) not null,
  domain varchar(255) not null,
  query_name varchar(255) not null,
  query_expression text,
  date_created timestamp default current_timestamp,
  has_been_run boolean not null default 0,
  flagged boolean not null default 0,
  flag_message varchar(255) null,
  constraint query_id_pk primary key(id),
  index ix_SHRINE_QUERY_network_id (network_id),
  index ix_SHRINE_QUERY_local_id (local_id),
  index ix_SHRINE_QUERY_username_domain (username, domain),
  query_xml text
) engine=innodb default charset=latin1;
alter table SHRINE_QUERY change flag_message flag_message text;

create table QUERY_RESULT(
  id int not null auto_increment,
  local_id varchar(255) not null,
  query_id int not null,
  type enum('PATIENTSET','PATIENT_COUNT_XML','PATIENT_AGE_COUNT_XML','PATIENT_RACE_COUNT_XML','PATIENT_VITALSTATUS_COUNT_XML','PATIENT_GENDER_COUNT_XML','ERROR') not null,
  status enum('FINISHED', 'ERROR', 'PROCESSING', 'QUEUED') not null,
  time_elapsed int null,
  last_updated timestamp default current_timestamp,
  constraint QUERY_RESULT_id_pk primary key(id),
  constraint fk_QUERY_RESULT_query_id foreign key (query_id) references SHRINE_QUERY (id) on delete cascade
) engine=innodb default charset=latin1;

create table ERROR_RESULT(
  id int not null auto_increment,
  result_id int not null,
  message varchar(255) not null,
  CODEC varchar(256) not null default "Pre-1.20 Error",
  STAMP varchar(256) not null default "Unknown time and machine",
  SUMMARY text not null,
  PROBLEM_DESCRIPTION text not null,
  DETAILS text not null,
  constraint ERROR_RESULT_id_pk primary key(id),
  constraint fk_ERROR_RESULT_QUERY_RESULT_id foreign key (result_id) references QUERY_RESULT (id) on delete cascade
) engine=innodb default charset=latin1;


create table COUNT_RESULT(
  id int not null auto_increment,
  result_id int not null,
  original_count int not null,
  obfuscated_count int not null,
  date_created timestamp default current_timestamp,
  constraint COUNT_RESULT_id_pk primary key(id),
  constraint fk_COUNT_RESULT_QUERY_RESULT_id foreign key (result_id) references QUERY_RESULT (id) on delete cascade
) engine=innodb default charset=latin1;

create table BREAKDOWN_RESULT(
  id int not null auto_increment,
  result_id int not null,
  data_key varchar(255) not null,
  original_value int not null,
  obfuscated_value int not null,
  constraint BREAKDOWN_RESULT_id_pk primary key(id),
  constraint fk_BREAKDOWN_RESULT_QUERY_RESULT_id foreign key (result_id) references QUERY_RESULT (id) on delete cascade
) engine=innodb default charset=latin1;

create table PRIVILEGED_USER(
  id int not null auto_increment,
  username varchar(255) not null,
  domain varchar(255) not null,
  threshold int null, #Used to be not null. See SHRINE-1262
  override_date timestamp null,
  constraint priviliged_user_pk primary key(id),
  constraint ix_PRIVILEGED_USER_username_domain unique (username, domain)
) engine=innodb default charset=latin1;

/* Hub Query */
create table HUB_QUERY (
  NETWORK_QUERY_ID bigint not null,
    DOMAIN varchar(256) not null,
    USERNAME varchar(256) not null,
    CREATE_DATE timestamp not null default current_timestamp,
    QUERY_DEFINITION text not null,
  constraint hub_query_id_pk primary key(NETWORK_QUERY_ID),
    index ix_HUB_QUERY_username_domain (username, domain)
) engine=innodb default charset=latin1;

create table HUB_QUERY_RESULT (
  ID int not null auto_increment,
    NETWORK_QUERY_ID bigint not null,
    NODE_NAME varchar(255) not null,
    CREATE_DATE timestamp not null default current_timestamp,
    STATUS varchar(255) not null,
  constraint hub_query_result_id_pk primary key(ID),
  index ix_HUB_QUERY_RESULT_network_query_id (NETWORK_QUERY_ID),
  index ix_HUB_QUERY_RESULT_network_query_id_node_name (NETWORK_QUERY_ID, NODE_NAME)
) engine=innodb default charset=latin1;

CREATE TABLE AUDIT_ENTRY(
  AUDIT_ENTRY_ID INT NOT NULL AUTO_INCREMENT,
  PROJECT VARCHAR(254) NOT NULL,
  USERNAME VARCHAR(254) NOT NULL,
  DOMAIN_NAME varchar(254)NOT NULL,
  TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  QUERY_TEXT TEXT,
  QUERY_TOPIC VARCHAR(245),
  PRIMARY KEY(AUDIT_ENTRY_ID),
  INDEX `IDX_AUDIT_ENTRY_DOMAIN_USERNAME_QUERY_TOPIC`(DOMAIN_NAME, USERNAME, QUERY_TOPIC)
)engine=innodb default charset=latin1;create database stewardDB;
use stewardDB;
create table `users` (`userName` VARCHAR(254) NOT NULL PRIMARY KEY,`fullName` VARCHAR(254) NOT NULL,`isSteward` BOOLEAN NOT NULL);
create table `topics` (`id` INTEGER NOT NULL,`name` VARCHAR(254) NOT NULL,`description` TEXT NOT NULL,`createdBy` VARCHAR(254) NOT NULL,`createDate` BIGINT NOT NULL,`state` VARCHAR(254) NOT NULL,`changedBy` VARCHAR(254) NOT NULL,`changeDate` BIGINT NOT NULL);
create index `changeDateIndex` on `topics` (`changeDate`);
create index `changedByIndex` on `topics` (`changedBy`);
create index `createDateIndex` on `topics` (`createDate`);
create index `createdByIndex` on `topics` (`createdBy`);
create index `idIndex` on `topics` (`id`);
create index `stateIndex` on `topics` (`state`);
create index `topicNameIndex` on `topics` (`name`);
create table `queries` (`stewardId` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`id` BIGINT NOT NULL,`name` VARCHAR(254) NOT NULL,`researcher` VARCHAR(254) NOT NULL,`topic` INTEGER,`queryContents` TEXT NOT NULL,`stewardResponse` VARCHAR(254) NOT NULL,`date` BIGINT NOT NULL);
create index `dateIndex` on `queries` (`date`);
create index `externalIdIndex` on `queries` (`id`);
create index `queryNameIndex` on `queries` (`name`);
create index `researcherIdIndex` on `queries` (`stewardId`);
create index `stewardResponseIndex` on `queries` (`stewardResponse`);
create index `topicIdIndex` on `queries` (`topic`);
create table `userTopic` (`researcher` VARCHAR(254) NOT NULL,`topicId` INTEGER NOT NULL,`state` VARCHAR(254) NOT NULL,`changedBy` VARCHAR(254) NOT NULL,`changeDate` BIGINT NOT NULL);
create unique index `researcherTopicIdIndex` on `userTopic` (`researcher`,`topicId`);
create table `userAudit` (`researcher` VARCHAR(254) NOT NULL,`queryCount` INTEGER NOT NULL,`changeDate` BIGINT NOT NULL);create database qepAuditDB;
use qepAuditDB;
create table `queriesSent` (`shrineNodeId` TEXT NOT NULL,`userName` TEXT NOT NULL,`networkQueryId` BIGINT NOT NULL,`queryName` TEXT NOT NULL,`queryTopicId` TEXT,`queryTopicName` TEXT,`timeQuerySent` BIGINT NOT NULL);
create table `previousQueries` (`networkId` BIGINT NOT NULL,`userName` TEXT NOT NULL,`domain` TEXT NOT NULL,`queryName` TEXT NOT NULL,`expression` TEXT,`dateCreated` BIGINT NOT NULL,`deleted` BOOLEAN NOT NULL,`queryXml` TEXT NOT NULL,`changeDate` BIGINT NOT NULL);
create table `queryFlags` (`networkId` BIGINT NOT NULL,`flagged` BOOLEAN NOT NULL,`flagMessage` TEXT NOT NULL,`changeDate` BIGINT NOT NULL);
create table `queryResults` (`resultId` BIGINT NOT NULL,`networkQueryId` BIGINT NOT NULL,`instanceId` BIGINT NOT NULL,`adapterNode` TEXT NOT NULL,`resultType` TEXT,`size` BIGINT NOT NULL,`startDate` BIGINT,`endDate` BIGINT,`status` TEXT NOT NULL,`statusMessage` TEXT,`changeDate` BIGINT NOT NULL);
create table `queryBreakdownResults` (`networkQueryId` BIGINT NOT NULL,`adapterNode` TEXT NOT NULL,`resultId` BIGINT NOT NULL,`resultType` TEXT NOT NULL,`dataKey` TEXT NOT NULL,`value` BIGINT NOT NULL,`changeDate` BIGINT NOT NULL);
create table `queryResultProblemDigests` (`networkQueryId` BIGINT NOT NULL,`adapterNode` TEXT NOT NULL,`codec` TEXT NOT NULL,`stamp` TEXT NOT NULL,`summary` TEXT NOT NULL,`description` TEXT NOT NULL,`details` TEXT NOT NULL,`changeDate` BIGINT NOT NULL);

create index queryResultsChangeDateIndex on queryResults (changeDate);
create index queryResultsNetworkQueryIdIndex on queryResults (networkQueryId);
create index queryResultsAdapterNodeIndex on queryResults (adapterNode(255));

create index queryBreakdownResultsChangeDateIndex on queryBreakdownResults (changeDate);
create index queryBreakdownResultsNetworkQueryIdIndex on queryBreakdownResults (networkQueryId);
create index queryBreakdownResultsAdapterNodeIndex on queryBreakdownResults (adapterNode(255));

create index queryFlagsChangeDateIndex on queryFlags (changeDate);
create index queryFlagsNetworkQueryIdIndex on queryFlags (networkId);create database adapterAuditDB;
use adapterAuditDB;
/* Audit db tables in adapterAuditDB */
create table `queriesReceived` (`shrineNodeId` TEXT NOT NULL,`userName` TEXT NOT NULL,`networkQueryId` BIGINT NOT NULL,`queryName` TEXT NOT NULL,`topicId` TEXT,`topicName` TEXT,`timeQuerySent` BIGINT NOT NULL,`timeReceived` BIGINT NOT NULL);
create table `executionsStarted` (`networkQueryId` BIGINT NOT NULL,`queryName` TEXT NOT NULL,`timeExecutionStarted` BIGINT NOT NULL);
create table `executionsCompleted` (`networkQueryId` BIGINT NOT NULL,`replyId` BIGINT NOT NULL,`queryName` TEXT NOT NULL,`timeExecutionCompleted` BIGINT NOT NULL);
create table `resultsSent` (`networkQueryId` BIGINT NOT NULL,`replyId` BIGINT NOT NULL,`queryName` TEXT NOT NULL,`timeResultsSent` BIGINT NOT NULL);
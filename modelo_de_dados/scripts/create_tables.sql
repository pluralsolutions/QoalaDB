-- muda o schema, pois ser� executado como masterqoala
-- todas as tabelas dever�o ser criadas com owner QOALA
alter session set current_schema=qoala;

DROP TABLE "COMMENT" CASCADE CONSTRAINTS ;

DROP TABLE COMMENT_LOG CASCADE CONSTRAINTS ;

DROP TABLE DEVICE CASCADE CONSTRAINTS ;

DROP TABLE DEVICE_GEO_LOCATION CASCADE CONSTRAINTS ;

DROP TABLE DEVICE_GEO_LOCATION_LOG CASCADE CONSTRAINTS ;

DROP TABLE DEVICE_LOG CASCADE CONSTRAINTS ;

DROP TABLE INFO_COMPANY CASCADE CONSTRAINTS ;

DROP TABLE NET_ACCOUNT CASCADE CONSTRAINTS ;

DROP TABLE POST CASCADE CONSTRAINTS ;

DROP TABLE POST_LOG CASCADE CONSTRAINTS ;

DROP TABLE "USER" CASCADE CONSTRAINTS ;

DROP TABLE USER_LOG CASCADE CONSTRAINTS ;

CREATE TABLE "COMMENT"
  (
    ID_COMMENT INTEGER NOT NULL ,
    CONTENT CLOB NOT NULL ,
    CREATED_AT  DATE NOT NULL ,
    UPDATED_AT  DATE NOT NULL ,
    APPROVED_AT DATE ,
    DELETED_AT  DATE ,
    POST_ID     INTEGER NOT NULL ,
    USER_ID     INTEGER NOT NULL
  ) ;
ALTER TABLE "COMMENT" ADD CONSTRAINT COMMENT_PK PRIMARY KEY ( ID_COMMENT ) ;


CREATE TABLE COMMENT_LOG
  (
    ID_COMMENT_LOG INTEGER NOT NULL ,
    LOG CLOB NOT NULL ,
    COMMENT_ID INTEGER NOT NULL ,
    CREATED_AT DATE NOT NULL
  ) ;
ALTER TABLE COMMENT_LOG ADD CONSTRAINT COMMENT_LOG_PK PRIMARY KEY ( ID_COMMENT_LOG ) ;


CREATE TABLE DEVICE
  (
    ID_DEVICE        INTEGER NOT NULL ,
    ALIAS            VARCHAR2 (50) NOT NULL ,
    COLOR            VARCHAR2 (15) ,
    FREQUENCY_UPDATE INTEGER NOT NULL ,
    LAST_LONGITUDE FLOAT (9) ,
    LAST_LATITUDE FLOAT (9) ,
    ALARM      CHAR (1) ,
    USER_ID    INTEGER NOT NULL ,
    CREATED_AT DATE NOT NULL ,
    UPDATED_AT DATE NOT NULL
  ) ;
ALTER TABLE DEVICE ADD CONSTRAINT DEVICE_PK PRIMARY KEY ( ID_DEVICE ) ;


CREATE TABLE DEVICE_GEO_LOCATION
  (
    ID_DEVICE_GEO_LOCATION INTEGER NOT NULL ,
    DEVICE_ID              INTEGER NOT NULL ,
    VERIFIED_AT            DATE NOT NULL ,
    LATITUDE FLOAT (9) NOT NULL ,
    LONGITUDE FLOAT (9) NOT NULL
  ) ;
ALTER TABLE DEVICE_GEO_LOCATION ADD CONSTRAINT DEVICE_GEO_LOCATION_PK PRIMARY KEY ( ID_DEVICE_GEO_LOCATION ) ;


CREATE TABLE DEVICE_GEO_LOCATION_LOG
  (
    ID_DEVICE_GEO_LOCATION_LOG INTEGER NOT NULL ,
    LOG CLOB NOT NULL ,
    DEVICE_GEO_LOCATION_ID INTEGER NOT NULL ,
    CREATED_AT             DATE NOT NULL
  ) ;
ALTER TABLE DEVICE_GEO_LOCATION_LOG ADD CONSTRAINT DEVICE_GEO_LOCATION_LOG_PK PRIMARY KEY ( ID_DEVICE_GEO_LOCATION_LOG ) ;


CREATE TABLE DEVICE_LOG
  (
    ID_DEVICE_LOG INTEGER NOT NULL ,
    LOG CLOB NOT NULL ,
    DEVICE_ID  INTEGER NOT NULL ,
    CREATED_AT DATE NOT NULL
  ) ;
ALTER TABLE DEVICE_LOG ADD CONSTRAINT DEVICE_LOG_PK PRIMARY KEY ( ID_DEVICE_LOG ) ;


CREATE TABLE INFO_COMPANY
  ( KEY VARCHAR2 (20) , VALUE CLOB
  ) ;


CREATE TABLE NET_ACCOUNT
  (
    ACCESS_TOKEN_ID VARCHAR2 (255) NOT NULL ,
    USER_ID         INTEGER NOT NULL ,
    IDENTIFIER      VARCHAR2 (50) NOT NULL ,
    PROVIDER        VARCHAR2 (50) NOT NULL
  ) ;
ALTER TABLE NET_ACCOUNT ADD CONSTRAINT NET_ACCOUNT_PK PRIMARY KEY ( ACCESS_TOKEN_ID ) ;


CREATE TABLE POST
  (
    ID_POST INTEGER NOT NULL ,
    TITLE   VARCHAR2 (255 BYTE) NOT NULL ,
    CONTENT CLOB NOT NULL ,
    CREATED_AT   DATE NOT NULL ,
    UPDATED_AT   DATE NOT NULL ,
    PUBLISHED_AT DATE ,
    DELETED_AT   DATE ,
    USER_ID      INTEGER NOT NULL
  ) ;
ALTER TABLE POST ADD CONSTRAINT POST_PK PRIMARY KEY ( ID_POST ) ;


CREATE TABLE POST_LOG
  (
    ID_POST_LOG INTEGER NOT NULL ,
    LOG CLOB NOT NULL ,
    POST_ID    INTEGER NOT NULL ,
    CREATED_AT DATE NOT NULL
  ) ;
ALTER TABLE POST_LOG ADD CONSTRAINT POST_LOG_PK PRIMARY KEY ( ID_POST_LOG ) ;


CREATE TABLE "USER"
  (
    ID_USER    INTEGER NOT NULL ,
    NAME       VARCHAR2 (255) NOT NULL ,
    PASSWORD   VARCHAR2 (255) NOT NULL ,
    EMAIL      VARCHAR2 (255) NOT NULL ,
    PERMISSION INTEGER DEFAULT 1 NOT NULL ,
    CREATED_AT DATE NOT NULL ,
    UPDATED_AT DATE NOT NULL
  ) ;
ALTER TABLE "USER" ADD CONSTRAINT CK_USER_PERMISSION CHECK ( PERMISSION IN (1, 2, 3)) ;
ALTER TABLE "USER" ADD CONSTRAINT USER_PK PRIMARY KEY ( ID_USER ) ;


CREATE TABLE USER_LOG
  (
    ID_USER_LOG INTEGER NOT NULL ,
    LOG CLOB NOT NULL ,
    USER_ID    INTEGER NOT NULL ,
    CREATED_AT DATE NOT NULL
  ) ;
ALTER TABLE USER_LOG ADD CONSTRAINT USER_LOG_PK PRIMARY KEY ( ID_USER_LOG ) ;


ALTER TABLE COMMENT_LOG ADD CONSTRAINT COMMENT_LOG_COMMENT_FK FOREIGN KEY ( COMMENT_ID ) REFERENCES "COMMENT" ( ID_COMMENT ) ;

ALTER TABLE "COMMENT" ADD CONSTRAINT COMMENT_POST_FK FOREIGN KEY ( POST_ID ) REFERENCES POST ( ID_POST ) ;

ALTER TABLE "COMMENT" ADD CONSTRAINT COMMENT_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES "USER" ( ID_USER ) ;

ALTER TABLE DEVICE_GEO_LOCATION ADD CONSTRAINT DEVICE_GEO_LOCATION_DEVICE_FK FOREIGN KEY ( DEVICE_ID ) REFERENCES DEVICE ( ID_DEVICE ) ;

ALTER TABLE DEVICE_GEO_LOCATION_LOG ADD CONSTRAINT DEVICE_GEO_LOCATION_LOG_FK FOREIGN KEY ( DEVICE_GEO_LOCATION_ID ) REFERENCES DEVICE_GEO_LOCATION ( ID_DEVICE_GEO_LOCATION ) ;

ALTER TABLE DEVICE_LOG ADD CONSTRAINT DEVICE_LOG_DEVICE_FK FOREIGN KEY ( DEVICE_ID ) REFERENCES DEVICE ( ID_DEVICE ) ;

ALTER TABLE DEVICE ADD CONSTRAINT DEVICE_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES "USER" ( ID_USER ) ;

ALTER TABLE NET_ACCOUNT ADD CONSTRAINT NET_ACCOUNT_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES "USER" ( ID_USER ) ;

ALTER TABLE POST_LOG ADD CONSTRAINT POST_LOG_POST_FK FOREIGN KEY ( POST_ID ) REFERENCES POST ( ID_POST ) ;

ALTER TABLE POST ADD CONSTRAINT POST_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES "USER" ( ID_USER ) ;

ALTER TABLE USER_LOG ADD CONSTRAINT USER_LOG_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES "USER" ( ID_USER ) ;

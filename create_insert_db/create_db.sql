﻿CREATE DATABASE BAO_DIEN_TU; -- tạo cơ sở dữ liệu báo điện tử
USE BAO_DIEN_TU;

CREATE TABLE MANAGERS (
	ID_MNG SMALLINT auto_increment NOT NULL PRIMARY KEY ,
	TEN VARCHAR(400),
	NAM_SINH YEAR 
);

CREATE TABLE REPOSTER (
	ID_REPOSTER SMALLINT auto_increment NOT NULL PRIMARY KEY,
	TEN VARCHAR(300) NOT NULL,
	NAM_SINH YEAR ,
	TO_CHUC VARCHAR(300) 
	-- BẢNG PHÓNG VIÊN 
);

CREATE TABLE USERS (
	ID_USER INT auto_increment NOT NULL  PRIMARY KEY ,
	ACCOUNT_NAME VARCHAR(400) NOT NULL,
	PASSWORDS INT NOT NULL,
	FACEBOOK_USER VARCHAR(400) ,
	EMAIL_USER VARCHAR (400),
    ID_MNG SMALLINT,
	FOREIGN KEY (ID_MNG) REFERENCES MANAGERS(ID_MNG)
);

CREATE TABLE POST (
	ID_POST INT auto_increment NOT NULL PRIMARY KEY ,
	TIEU_DE VARCHAR(400) NOT NULL,
	NOI_DUNG TEXT NOT NULL,
	IMAGES LONGBLOB ,
	-- TAC_GIA VARCHAR (20),
	LUOT_XEM SMALLINT ,
	XET_DUYET BIT NOT NULL,
	THOI_GIAN_DANG DATETIME ,
    NGUOI_DUYET SMALLINT,
    NGUOI_DANG SMALLINT,
	FOREIGN KEY (NGUOI_DUYET) REFERENCES MANAGERS(ID_MNG) ,
	FOREIGN KEY (NGUOI_DANG) REFERENCES REPOSTER(ID_REPOSTER)

);

CREATE TABLE SHARE (
	ID_SHARE INT auto_increment NOT NULL PRIMARY KEY ,
	TIME_SHARE DATETIME ,
    NGUOI_SHARE INT,
	FOREIGN KEY (NGUOI_SHARE) REFERENCES USERS(ID_USER) 
);

CREATE TABLE COMMENT (
	ID_COMMENT INT auto_increment NOT NULL PRIMARY KEY,
	TIME_COMMENT DATETIME ,
	NOI_DUNG TEXT ,
    NGUOI_COMMENT INT,
	FOREIGN KEY (NGUOI_COMMENT) REFERENCES USERS(ID_USER)
);

CREATE TABLE COMMENT_POST (
	ID_COMMENT INT NOT NULL, 
	ID_POST INT NOT NULL ,
	TIEU_DE VARCHAR(400),
	CONSTRAINT PK_COMMENT_POST PRIMARY KEY (ID_COMMENT,ID_POST)

 );


CREATE TABLE SHARE_POST(
	ID_SHARE INT  NOT NULL,
	ID_POST INT  NOT NULL,
	TIEU_DE VARCHAR(400),
	CONSTRAINT PK_SHARE_POST PRIMARY KEY (ID_SHARE,ID_POST)

);

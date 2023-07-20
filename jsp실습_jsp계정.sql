CREATE TABLE MEMBER(
    ID VARCHAR2(20) PRIMARY KEY,
    PWD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1),
    BIRTHDAY CHAR(6),
    EMAIL VARCHAR2(30),
    ZIPCODE CHAR(5),
    ADDRESS VARCHAR2(100),
    DETAILADDRESS VARCHAR2(50),
    HOBBY CHAR(5),
    JOB VARCHAR2(30)
);

CREATE TABLE POLLLIST(
    NUM NUMBER PRIMARY KEY,
    QUESTION VARCHAR2(200) NOT NULL,
    SDATE DATE,
    EDATE DATE,
    WDATE DATE,
    TYPE NUMBER DEFAULT 1 NOT NULL,
    ACTIVE NUMBER DEFAULT 1
);

CREATE SEQUENCE SEQ_POLL;

CREATE TABLE POLLITEM(
    LISTNUM NUMBER,
    ITEMNUM NUMBER DEFAULT 0,
    ITEM VARCHAR2(50),
    COUNT NUMBER DEFAULT 0,
    PRIMARY KEY(LISTNUM,ITEMNUM)
);

CREATE SEQUENCE SEQ_BOARD;

CREATE TABLE board (
   num number PRIMARY KEY,
   name varchar2(20) NOT NULL,
   subject varchar2(50) NOT NULL,
   content varchar2(4000) NOT NULL,
   pos number,
   ref number,
   depth number,
   regdate date,
   pass varchar2(15) NOT NULL,
   ip varchar2(15),
   count number,
   filename varchar2(30),
   filesize number
);

CREATE TABLE REPLY(
    RENO NUMBER PRIMARY KEY,
    CONTENT VARCHAR2(500),
    REF NUMBER,
    NAME VARCHAR2(20),
    REDATE DATE
);

CREATE SEQUENCE SEQ_REPLY;

INSERT INTO REPLY VALUES(SEQ_REPLY.NEXTVAL, '와우!!! 첫 댓글', 1, '김처음', '2023/05/01');
INSERT INTO REPLY VALUES(SEQ_REPLY.NEXTVAL, '2번째 댓글', 1, '박재미', '2023/05/04');
INSERT INTO REPLY VALUES(SEQ_REPLY.NEXTVAL, '유용한 곳이군요', 1, '이유용', '2023/05/11');

---------------------- 세미프로젝트 ----------------------

CREATE TABLE notes (
  id NUMBER PRIMARY KEY,
  content VARCHAR2(200)
);

CREATE TABLE BOARDNOTES (
   num number PRIMARY KEY,
   name varchar2(30) NOT NULL,
   subject varchar2(100) NOT NULL,
   content varchar2(4000) NOT NULL,
   pos number,
   ref number,
   depth number,
   regdate date,
   pass varchar2(15) NOT NULL,
   ip varchar2(15),
   count number,
   filename varchar2(100),
   filesize number
);

CREATE SEQUENCE SEQ_BOARDNOTES;
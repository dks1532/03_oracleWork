----------------------------------------------------------------
---------------------- BUCKETLIST TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE BUCKETLIST (
    CEO VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    PHONE VARCHAR2(20),
    FAX VARCHAR2(20),
    BUSINESS_NO VARCHAR2(20),
    EMAIL VARCHAR2(50),
    CPO VARCHAR2(20)
);

----------------------------------------------------------------
---------------------- HOST TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE HOST (
    HOST_NUM NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(100) NOT NULL,
    ACCOUNT_HOLDER VARCHAR2(30),
    ACCOUNT_BANK VARCHAR2(30),
    ACCOUNT_NUMBER VARCHAR2(30),
    HOST_INTRO VARCHAR2(4000)
);

CREATE SEQUENCE SEQ_HOST;

----------------------------------------------------------------
---------------------- MEMBER TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE MEMBER (
    MEM_ID VARCHAR2(100) PRIMARY KEY,
    MEM_PWD VARCHAR2(100) DEFAULT NULL,
    MEM_NAME VARCHAR2(100) NOT NULL,
    BIRTHDATE VARCHAR2(20) DEFAULT NULL,
    MEM_PHOTO VARCHAR2(200) DEFAULT NULL,                       -- 사진은 회원가입후 마이페이지에서 받을 수 있음
    ENROLL_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')),  -- Y: 회원, N: 탈퇴
    MEM_PHONE CHAR(50) DEFAULT NULL,
    CHECK_HOST NUMBER DEFAULT 1 CHECK(CHECK_HOST IN(1,2,3)),    -- 1: 일반 2: 호스트 3: 관리자
    TOTAL_POINT NUMBER DEFAULT 0,
    LOGIN_TYPE NUMBER DEFAULT 1 CHECK(LOGIN_TYPE IN(1,2,3))     -- 1: 자체회원가입, 2: 네이버, 3: 카카오
);

----------------------------------------------------------------
---------------------- NOTICE TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE NOTICE (
    NOTICE_NO NUMBER PRIMARY KEY,
    TITLE VARCHAR2(100)  NOT NULL,
    CONTENT VARCHAR2(4000)  NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    COUNT NUMBER DEFAULT 0,
    FILENAME VARCHAR2(100),
    FILETYPE VARCHAR2(200),
    CHANGENAME VARCHAR2(100)
);

CREATE SEQUENCE SEQ_NOTICE;

----------------------------------------------------------------
---------------------- QNA TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE QNA (
    QNA_NO NUMBER PRIMARY KEY,
    ID VARCHAR2(50)  NOT NULL,
    TITLE VARCHAR2(100)  NOT NULL,
    CONTENT VARCHAR2(4000)  NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    COUNT NUMBER DEFAULT 0,
    FILENAME VARCHAR2(100),
    FILETYPE VARCHAR2(200),
    CHANGENAME VARCHAR2(100),
    REPLY_COUNT NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_QNA;

----------------------------------------------------------------
---------------------- REPLY TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE REPLY (
    REPLY_NO NUMBER PRIMARY KEY,
    QNA_NO NUMBER NOT NULL,
    CONTENT VARCHAR2(500)  NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_REPLY;

----------------------------------------------------------------
---------------------- FAQ TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE FAQ (
    FAQ_NO NUMBER PRIMARY KEY,
    QUESTION VARCHAR2(200)  NOT NULL,
    ANSWER VARCHAR2(1000)  NOT NULL
);

CREATE SEQUENCE SEQ_FAQ;

----------------------------------------------------------------
---------------------- ROOM TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE ROOM (
    ROOM_NO NUMBER PRIMARY KEY,
    CO_NO NUMBER  NOT NULL,
    NAME VARCHAR2(50) NOT NULL
);

----------------------------------------------------------------
---------------------- RESERVATION TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE RESERVATION (
    RE_NO VARCHAR2(30) PRIMARY KEY,
    MEM_ID VARCHAR2(100),
    LODG_ID NUMBER,
    CHECKIN VARCHAR2(20),
    CHECKOUT VARCHAR2(20),
    GUEST NUMBER,
    PAY NUMBER,
    FEE NUMBER,
    CLEAN NUMBER,
    SALE NUMBER,
    TOTAL_PRICE NUMBER,
    REGDATE DATE DEFAULT SYSDATE,
    REVIEW NUMBER DEFAULT 0,
    STATUS NUMBER DEFAULT 1,
    STAY NUMBER
);

CREATE SEQUENCE SEQ_RV;

----------------------------------------------------------------
---------------------- LODGING TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE LODGING (
	LODG_ID	NUMBER PRIMARY KEY,
    HOST_ID VARCHAR2(50) NOT NULL,
	CORPORATE_NUMBER VARCHAR2(12) NOT NULL,
	LODG_NAME VARCHAR2(100) NOT NULL,
	ADR_POST VARCHAR2(40),
	ADR_ROAD VARCHAR2(100),
	ADR_CITY VARCHAR2(30),
	ADR_GU VARCHAR2(50),
	ADR_DONG VARCHAR2(50),
	ADR_DETAIL VARCHAR2(60),
	LATI VARCHAR2(300),
	LONGIT VARCHAR2(300),
	LODG_PHONE VARCHAR2(13) NOT NULL,
	DESCRIPTION	VARCHAR2(500),
	LODG_PRICE NUMBER,
	CHECK_IN VARCHAR2(20),
	CHECK_OUT VARCHAR2(20),
	PER_MAX	NUMBER,
	ROOM_NUM NUMBER,
	BED_NUM	NUMBER,
	BATH_NUM NUMBER,
	CLEAN_PRICE	VARCHAR2(100),
	RATING NUMBER,
	STATUS NUMBER,
	TAG VARCHAR2(20),
    COUNT NUMBER DEFAULT 0,
    FOREIGN KEY (HOST_ID) REFERENCES MEMBER   
);

CREATE SEQUENCE SEQ_LODG;

----------------------------------------------------------------
---------------------- IMAGE TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE IMAGE (
    LODG_ID NUMBER NOT NULL,
    FILENAME VARCHAR2(300 BYTE),
    FILETYPE VARCHAR2(100 BYTE),
    CHANGENAME VARCHAR2(200 BYTE),
    FOREIGN KEY(LODG_ID) REFERENCES LODGING
);

----------------------------------------------------------------
---------------------- SERVICE TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE SERVIC (
    SERVIC_ID VARCHAR2(50) PRIMARY KEY,
    SERVIC_IMG VARCHAR2(300)
);

----------------------------------------------------------------
---------------------- FACILITY TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE FACILITY (
    SERVIC_ID VARCHAR2(50),
    LODG_ID NUMBER NOT NULL,
    FOREIGN KEY(SERVIC_ID) REFERENCES SERVIC,
    FOREIGN KEY(LODG_ID) REFERENCES LODGING
);

----------------------------------------------------------------
---------------------- WISHLIST TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE WISHLIST (
    MEM_ID VARCHAR2(100),
    LODG_ID NUMBER
);

----------------------------------------------------------------
---------------------- REVIEW TABLE --------------------------
----------------------------------------------------------------        
CREATE TABLE REVIEW (
    REVIEW_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(100) REFERENCES MEMBER,
    LODG_ID NUMBER REFERENCES LODGING,
    RATING NUMBER DEFAULT 5,
    MSG VARCHAR2(1000),
    REGDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_REVIEW;

----------------------------------------------------------------
---------------------- CHAT TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE CHAT (
    CHATROOM_ID NUMBER,
    LODG_ID NUMBER,
    HOST_ID VARCHAR2(100),
    MEM_ID VARCHAR2(100)
);

CREATE SEQUENCE SEQ_CHAT;

----------------------------------------------------------------
---------------------- MESSAGE TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE MESSAGE (
    MSG_ID NUMBER PRIMARY KEY,
    CHATROOM_ID NUMBER,
    SENDER VARCHAR2(100),
    CONTENT VARCHAR2(1000),
    REGDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_MESSAGE;

----------------------------------------------------------------
---------------------- PAYMENT TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE PAYMENT (
    IMP_UID VARCHAR2(60) PRIMARY KEY,
    MERCHANT_UID VARCHAR2(60),
    PAID_AMOUNT NUMBER,
    MEM_ID VARCHAR2(100) REFERENCES MEMBER,
    LODG_ID NUMBER REFERENCES LODGING,
    RE_NO VARCHAR2(30) REFERENCES RESERVATION
);
--------------------------------------------------------------------------------


-------------- insert문 -----------------

-- BUCKETLIST
INSERT INTO BUCKETLIST VALUES('홍길동', '서울 영등포구 선유동2로 57 이레빌딩 19F', '02-345-6789', '02-345-6780', '123-45-67890', 'bucketlist@bk.co.kr', '홍길동');

-- MEMBER
INSERT INTO MEMBER VALUES('test1@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍길동',	'991231',	'a.jpg',	'2023-07-19',	'Y',	'01044809041',	2,	1000000,	1);
INSERT INTO MEMBER VALUES('test2@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍일동',	'991231',	'a.jpg',	'2023-07-20',	'N',	'01011111111',	1,	2000000,	1);
INSERT INTO MEMBER VALUES('test3@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍이동',	'991231',	'a.jpg',	'2023-07-21',	'Y',	'01011111112',	2,	3000000,	1);
INSERT INTO MEMBER VALUES('test4@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍삼동',	'991231',	'a.jpg',	'2023-07-22',	'Y',	'01011111113',	1,	4000000,	1);
INSERT INTO MEMBER VALUES('test5@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍사동',	'991231',	'a.jpg',	'2023-07-23',	'Y',	'01011111114',	2,	5000000,	1);
INSERT INTO MEMBER VALUES('test6@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍오동',	'991231',	'a.jpg',	'2023-07-24',	'Y',	'01011111115',	1,	1000000,	1);
INSERT INTO MEMBER VALUES('test7@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍육동',	'991231',	'a.jpg',	'2023-07-25',	'Y',	'01011111116',	2,	2000000,	1);
INSERT INTO MEMBER VALUES('test8@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍칠동',	'991231',	'a.jpg',	'2023-07-26',	'Y',	'01011111117',	1,	3000000,	1);
INSERT INTO MEMBER VALUES('test9@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍팔동',	'991231',	'a.jpg',	'2023-07-27',	'Y',	'01011111118',	2,	4000000,	1);
INSERT INTO MEMBER VALUES('test10@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'홍구동',	'991231',	'a.jpg',	'2023-07-28',	'Y',	'01011111119',	1,	5000000,	1);
INSERT INTO MEMBER VALUES('test11@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'김길동',	'991231',	'a.jpg',	'2023-07-29',	'Y',	'01011111120',	2,	1000000,	1);
INSERT INTO MEMBER VALUES('test12@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'최길동',	'991231',	'a.jpg',	'2023-07-30',	'Y',	'01011111121',	1,	2000000,	1);
INSERT INTO MEMBER VALUES('test13@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'박길동',	'991231',	'a.jpg',	'2023-07-31',	'Y',	'01011111122',	2,	3000000,	1);
INSERT INTO MEMBER VALUES('test14@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'이길동',	'991231',	'a.jpg',	'2023-07-27',	'Y',	'01011111123',	1,	4000000,	1);
INSERT INTO MEMBER VALUES('test15@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'오길동',	'991231',	'a.jpg',	'2023-07-28',	'Y',	'01011111124',	2,	5000000,	1);
INSERT INTO MEMBER VALUES('test16@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'황길동',	'991231',	'a.jpg',	'2023-07-29',	'Y',	'01011111125',	1,	1000000,	1);
INSERT INTO MEMBER VALUES('test17@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'고길동',	'991231',	'a.jpg',	'2023-07-30',	'Y',	'01011111126',	2,	2000000,	1);
INSERT INTO MEMBER VALUES('test18@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'임길동',	'991231',	'a.jpg',	'2023-07-31',	'Y',	'01011111127',	1,	3000000,	1);
INSERT INTO MEMBER VALUES('test19@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'권길동',	'991231',	'a.jpg',	'2023-07-28',	'Y',	'01011111128',	2,	4000000,	1);
INSERT INTO MEMBER VALUES('test20@bl.com',	'$2a$10$bUBTHPxt1FLOq0p.E3M58e.sAeVSRSiiUiZ0stSySNx42SOedJcw6',	'임길동',	'991231',	'a.jpg',	'2023-07-29',	'Y',	'01011111129',	1,	5000000,	1);

-- HOST
INSERT INTO HOST VALUES(1,	'test1@bl.com',	'홍길동',	'신한은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(2,	'test3@bl.com',	'홍이동',	'국민은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(3,	'test5@bl.com',	'홍사동',	'신한은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(4,	'test7@bl.com',	'홍육동',	'국민은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(5,	'test9@bl.com',	'홍팔동',	'신한은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(6,	'test11@bl.com',	'김길동',	'국민은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(7,	'test13@bl.com',	'박길동',	'신한은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(8,	'test15@bl.com',	'오길동',	'국민은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(9,	'test17@bl.com',	'고길동',	'신한은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');
INSERT INTO HOST VALUES(10,	'test19@bl.com',	'권길동',	'국민은행',	'1112233333',	'안녕하세요 저는 호스트입니다. 호스트 소개 멘트를 작성합니다. 저희 숙소 많이 이용해주세요');

-- SERVIC
INSERT INTO SERVIC VALUES('amenity', '/resources/img/service/amenity.png');
INSERT INTO SERVIC VALUES('business', '/resources/img/service/business.png');
INSERT INTO SERVIC VALUES('nosmoking', '/resources/img/service/nosmoking.png');
INSERT INTO SERVIC VALUES('parking', '/resources/img/service/parking.png');
INSERT INTO SERVIC VALUES('roompc', '/resources/img/service/roompc.png');
INSERT INTO SERVIC VALUES('twinbed', '/resources/img/service/twinbed.png');
INSERT INTO SERVIC VALUES('vod', '/resources/img/service/vod.png');
INSERT INTO SERVIC VALUES('washingmachine', '/resources/img/service/washingmachine.png');
INSERT INTO SERVIC VALUES('wifi', '/resources/img/service/wifi.png');

-- FAQ
INSERT INTO FAQ VALUES(1,	'자주 묻는 질문입니다1',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1');
INSERT INTO FAQ VALUES(2,	'자주 묻는 질문입니다2',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다2');
INSERT INTO FAQ VALUES(3,	'자주 묻는 질문입니다3',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다3');
INSERT INTO FAQ VALUES(4,	'자주 묻는 질문입니다4',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다4');
INSERT INTO FAQ VALUES(5,	'자주 묻는 질문입니다5',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다5');
INSERT INTO FAQ VALUES(6,	'자주 묻는 질문입니다6',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다6');
INSERT INTO FAQ VALUES(7,	'자주 묻는 질문입니다7',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다7');
INSERT INTO FAQ VALUES(8,	'자주 묻는 질문입니다8',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다8');
INSERT INTO FAQ VALUES(9,	'자주 묻는 질문입니다9',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다9');
INSERT INTO FAQ VALUES(10,	'자주 묻는 질문입니다10',	'자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다1 자주 묻는 질문에 대한 답변입니다10');

-- NOTICE
INSERT INTO NOTICE VALUES(1,	'버킷리스트의 공지사항입니다1',	'버킷리스트의 공지사항 내용입니다1',	'2023-07-01',	100,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(2,	'버킷리스트의 공지사항입니다2',	'버킷리스트의 공지사항 내용입니다2',	'2023-07-02',	101,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(3,	'버킷리스트의 공지사항입니다3',	'버킷리스트의 공지사항 내용입니다3',	'2023-07-03',	102,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(4,	'버킷리스트의 공지사항입니다4',	'버킷리스트의 공지사항 내용입니다4',	'2023-07-04',	103,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(5,	'버킷리스트의 공지사항입니다5',	'버킷리스트의 공지사항 내용입니다5',	'2023-07-05',	104,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(6,	'버킷리스트의 공지사항입니다6',	'버킷리스트의 공지사항 내용입니다6',	'2023-07-06',	105,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(7,	'버킷리스트의 공지사항입니다7',	'버킷리스트의 공지사항 내용입니다7',	'2023-07-07',	106,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(8,	'버킷리스트의 공지사항입니다8',	'버킷리스트의 공지사항 내용입니다8',	'2023-07-08',	107,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(9,	'버킷리스트의 공지사항입니다9',	'버킷리스트의 공지사항 내용입니다9',	'2023-07-09',	108,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(10,	'버킷리스트의 공지사항입니다10',	'버킷리스트의 공지사항 내용입니다10',	'2023-07-10',	109,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(11,	'버킷리스트의 공지사항입니다11',	'버킷리스트의 공지사항 내용입니다11',	'2023-07-11',	110,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(12,	'버킷리스트의 공지사항입니다12',	'버킷리스트의 공지사항 내용입니다12',	'2023-07-12',	111,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(13,	'버킷리스트의 공지사항입니다13',	'버킷리스트의 공지사항 내용입니다13',	'2023-07-13',	112,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(14,	'버킷리스트의 공지사항입니다14',	'버킷리스트의 공지사항 내용입니다14',	'2023-07-14',	113,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');
INSERT INTO NOTICE VALUES(15,	'버킷리스트의 공지사항입니다15',	'버킷리스트의 공지사항 내용입니다15',	'2023-07-15',	114,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg');

-- QNA
INSERT INTO QNA VALUES(1,	'test1@bl.com',	'안녕하세요 질문있어요1',	'안녕하세요 질문 내용입니다1',	'2023-07-01',	100,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(2,	'test2@bl.com',	'안녕하세요 질문있어요2',	'안녕하세요 질문 내용입니다2',	'2023-07-02',	101,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(3,	'test3@bl.com',	'안녕하세요 질문있어요3',	'안녕하세요 질문 내용입니다3',	'2023-07-03',	102,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(4,	'test4@bl.com',	'안녕하세요 질문있어요4',	'안녕하세요 질문 내용입니다4',	'2023-07-04',	103,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(5,	'test5@bl.com',	'안녕하세요 질문있어요5',	'안녕하세요 질문 내용입니다5',	'2023-07-05',	104,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(6,	'test6@bl.com',	'안녕하세요 질문있어요6',	'안녕하세요 질문 내용입니다6',	'2023-07-06',	105,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(7,	'test7@bl.com',	'안녕하세요 질문있어요7',	'안녕하세요 질문 내용입니다7',	'2023-07-07',	106,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(8,	'test8@bl.com',	'안녕하세요 질문있어요8',	'안녕하세요 질문 내용입니다8',	'2023-07-08',	107,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(9,	'test9@bl.com',	'안녕하세요 질문있어요9',	'안녕하세요 질문 내용입니다9',	'2023-07-09',	108,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(10,	'test10@bl.com',	'안녕하세요 질문있어요10',	'안녕하세요 질문 내용입니다10',	'2023-07-10',	109,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(11,	'test11@bl.com',	'안녕하세요 질문있어요11',	'안녕하세요 질문 내용입니다11',	'2023-07-11',	110,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(12,	'test12@bl.com',	'안녕하세요 질문있어요12',	'안녕하세요 질문 내용입니다12',	'2023-07-12',	111,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(13,	'test13@bl.com',	'안녕하세요 질문있어요13',	'안녕하세요 질문 내용입니다13',	'2023-07-13',	112,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(14,	'test14@bl.com',	'안녕하세요 질문있어요14',	'안녕하세요 질문 내용입니다14',	'2023-07-14',	113,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	0);
INSERT INTO QNA VALUES(15,	'test15@bl.com',	'안녕하세요 질문있어요15',	'안녕하세요 질문 내용입니다15',	'2023-07-15',	114,	'local01.jpg',	'image/jpeg',	'20230719_020134935_755.jpg',	3);

-- REPLY
INSERT INTO REPLY VALUES(1, 15, '답변드립니다1', '23/07/19');
INSERT INTO REPLY VALUES(2, 15, '답변드립니다2', '23/07/19');
INSERT INTO REPLY VALUES(3, 15, '답변드립니다3', '23/07/19');

-- LODGING
INSERT INTO LODGING VALUES(1,	'test1@bl.com',	'1112233333',	'커플',	'00000',	'강원특별자치도 강릉시 가작로 6(교동)',	'강원',	'아무개구',	'아무개동',	'101동 101호',	'128.876301708',	'37.769181835',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	5.0,	1,	'couple',	10);
INSERT INTO LODGING VALUES(2,	'test3@bl.com',	'1112233334',	'가족',	'00000',	'경기 양평군 양동면 도소리길 16(삼산리)',	'경기',	'아무개구',	'아무개동',	'101동 102호',	'127.771417083',	'37.402824493',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	4.9,	2,	'family',	11);
INSERT INTO LODGING VALUES(3,	'test5@bl.com',	'1112233335',	'mt',	'00000',	'경남 창녕군 계성면 경남대로 3906-23(사리)',	'경남',	'아무개구',	'아무개동',	'101동 103호',	'128.514883088',	'35.479247957',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	4,	0,	'mt',	12);
INSERT INTO LODGING VALUES(4,	'test7@bl.com',	'1112233336',	'바다',	'00000',	'경북 경산시 감못둑길 20(갑제동)',	'경북',	'아무개구',	'아무개동',	'101동 104호',	'128.767035478',	'35.835058100',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	2,	2,	2,	10000,	4.7,	1,	'tag4',	13);
INSERT INTO LODGING VALUES(5,	'test9@bl.com',	'1112233337',	'힐링',	'00000',	'광주 광산구 가마길 2-21(명도동)',	'광주',	'아무개구',	'아무개동',	'101동 105호',	'126.701940977',	'35.171834033',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	1,	1,	1,	10000,	3,	1,	'tag5',	14);
INSERT INTO LODGING VALUES(6,	'test11@bl.com',	'1112233338',	'나홀로',	'00000',	'대구 북구 검단공단로 12(검단동, 안심귀가 로고젝터)',	'대구',	'아무개구',	'아무개동',	'101동 106호',	'128.618467972',	'35.907205810',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	2,	2,	2,	10000,	3.2,	1,	'tag6',	15);
INSERT INTO LODGING VALUES(7,	'test13@bl.com',	'1112233339',	'커플',	'00000',	'대전 동구 대전로 387(가오동)',	'대전',	'아무개구',	'아무개동',	'101동 107호',	'127.455958971',	'36.301473441',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	4.8,	1,	'couple',	16);
INSERT INTO LODGING VALUES(8,	'test15@bl.com',	'1112233340',	'가족',	'00000',	'부산 남구 무민사로 5(감만동)',	'부산',	'아무개구',	'아무개동',	'101동 108호',	'129.080369633',	'35.110943220',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	17);
INSERT INTO LODGING VALUES(9,	'test17@bl.com',	'1112233341',	'mt',	'00000',	'서울 강남구 가로수길 5(신사동)',	'서울',	'아무개구',	'아무개동',	'101동 109호',	'127.023144576',	'37.518220551',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	18);
INSERT INTO LODGING VALUES(10,	'test19@bl.com',	'1112233342',	'바다',	'00000',	'서울 강남구 가로수길 5(신사동)',	'서울',	'아무개구',	'아무개동',	'101동 110호',	'127.023144576',	'37.518220551',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	2,	2,	2,	10000,	0,	1,	'tag4',	19);
INSERT INTO LODGING VALUES(11,	'test1@bl.com',	'1112233343',	'힐링',	'00000',	'서울 강남구 가로수길 5(신사동)',	'서울',	'아무개구',	'아무개동',	'101동 111호',	'127.023144576',	'37.518220551',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	1,	1,	1,	10000,	0,	1,	'tag5',	20);
INSERT INTO LODGING VALUES(12,	'test3@bl.com',	'1112233344',	'나홀로',	'00000',	'서울 강남구 강남대로 238(도곡동, 스카이쏠라빌딩)',	'서울',	'아무개구',	'아무개동',	'101동 112호',	'127.034747655',	'37.484974830',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	2,	2,	2,	10000,	0,	1,	'tag6',	21);
INSERT INTO LODGING VALUES(13,	'test5@bl.com',	'1112233345',	'커플',	'00000',	'서울 강남구 개포로 202(개포동, 석인빌딩)',	'서울',	'아무개구',	'아무개동',	'101동 113호',	'127.044972766',	'37.478172723',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'couple',	22);
INSERT INTO LODGING VALUES(14,	'test7@bl.com',	'1112233346',	'가족',	'00000',	'서울 강서구 가로공원로 173(화곡동)',	'서울',	'아무개구',	'아무개동',	'101동 114호',	'126.835266168',	'37.537168444',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	23);
INSERT INTO LODGING VALUES(15,	'test9@bl.com',	'1112233347',	'mt',	'00000',	'서울 강서구 등촌로 105(등촌동, 대일고등학교)',	'서울',	'아무개구',	'아무개동',	'101동 115호',	'126.863403107',	'37.539488313',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	24);
INSERT INTO LODGING VALUES(16,	'test11@bl.com',	'1112233348',	'바다',	'00000',	'서울 강서구 등촌로51가길 26(등촌동, 영일고등학교)',	'서울',	'아무개구',	'아무개동',	'101동 116호',	'126.862207172',	'37.547621085',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	2,	2,	2,	10000,	0,	1,	'tag4',	25);
INSERT INTO LODGING VALUES(17,	'test13@bl.com',	'1112233349',	'힐링',	'00000',	'서울 강서구 허준로 227(가양동, 세현고등학교)',	'서울',	'아무개구',	'아무개동',	'101동 117호',	'126.863532003',	'37.560404578',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	1,	1,	1,	10000,	0,	1,	'tag5',	26);
INSERT INTO LODGING VALUES(18,	'test15@bl.com',	'1112233350',	'나홀로',	'00000',	'서울 강서구 화곡로 403(등촌동, 마포고등학교)',	'서울',	'아무개구',	'아무개동',	'101동 118호',	'126.852865479',	'37.560028773',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	2,	2,	2,	10000,	0,	1,	'tag6',	27);
INSERT INTO LODGING VALUES(19,	'test17@bl.com',	'1112233351',	'커플',	'00000',	'서울 구로구 구로동로 5(가리봉동)',	'서울',	'아무개구',	'아무개동',	'101동 119호',	'126.886910810',	'37.482403158',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'couple',	28);
INSERT INTO LODGING VALUES(20,	'test19@bl.com',	'1112233352',	'가족',	'00000',	'서울 금천구 가마산로 70(가산동)',	'서울',	'아무개구',	'아무개동',	'101동 120호',	'126.874318150',	'37.484893746',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	29);
INSERT INTO LODGING VALUES(21,	'test1@bl.com',	'1112233353',	'mt',	'00000',	'서울 금천구 가산디지털1로 1(가산동, 더루벤스밸리)',	'서울',	'아무개구',	'아무개동',	'101동 121호',	'126.887159717',	'37.466270719',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	30);
INSERT INTO LODGING VALUES(22,	'test3@bl.com',	'1112233354',	'바다',	'00000',	'서울 동대문구 서울시립대로 9(답십리동)',	'대전',	'아무개구',	'아무개동',	'101동 122호',	'127.044792502',	'37.572933548',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	2,	2,	2,	10000,	0,	1,	'tag4',	31);
INSERT INTO LODGING VALUES(23,	'test5@bl.com',	'1112233355',	'힐링',	'00000',	'서울 성동구 가람길 125(송정동)',	'서울',	'아무개구',	'아무개동',	'101동 123호',	'127.057741953',	'37.554058554',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	1,	1,	1,	10000,	0,	1,	'tag5',	32);
INSERT INTO LODGING VALUES(24,	'test7@bl.com',	'1112233356',	'나홀로',	'00000',	'서울 성동구 서울숲길 20(성수동1가)',	'서울',	'아무개구',	'아무개동',	'101동 124호',	'127.039724774',	'37.547953091',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	2,	2,	2,	10000,	0,	1,	'tag6',	33);
INSERT INTO LODGING VALUES(25,	'test9@bl.com',	'1112233357',	'커플',	'00000',	'서울 양천구 가로공원로 66(신월동)',	'서울',	'아무개구',	'아무개동',	'101동 125호',	'126.823213743',	'37.534959995',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'couple',	34);
INSERT INTO LODGING VALUES(26,	'test11@bl.com',	'1112233358',	'가족',	'00000',	'서울 양천구 목동서로 15(목동, 한가람고등학교)',	'부산',	'아무개구',	'아무개동',	'101동 126호',	'126.884091730',	'37.537445372',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	35);
INSERT INTO LODGING VALUES(27,	'test13@bl.com',	'1112233359',	'mt',	'00000',	'서울 양천구 목동중앙남로 27(목동, 강서고등학교.영도중학교)',	'서울',	'아무개구',	'아무개동',	'101동 127호',	'126.866003164',	'37.535863557',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	36);
INSERT INTO LODGING VALUES(28,	'test15@bl.com',	'1112233360',	'바다',	'00000',	'서울 양천구 목동중앙로 88(목동, 신목중학교)',	'서울',	'아무개구',	'아무개동',	'101동 128호',	'126.873134631',	'37.536661571',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	2,	2,	2,	10000,	0,	1,	'tag4',	37);
INSERT INTO LODGING VALUES(29,	'test17@bl.com',	'1112233361',	'힐링',	'00000',	'서울 은평구 갈현로 181(갈현동)',	'서울',	'아무개구',	'아무개동',	'101동 129호',	'126.911835832',	'37.614201812',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	1,	1,	1,	10000,	0,	1,	'tag5',	38);
INSERT INTO LODGING VALUES(30,	'test19@bl.com',	'1112233362',	'나홀로',	'00000',	'서울 종로구 북촌로 31-6(가회동)',	'서울',	'아무개구',	'아무개동',	'101동 130호',	'126.984534783',	'37.579664295',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	2,	2,	2,	10000,	0,	1,	'tag6',	39);
INSERT INTO LODGING VALUES(31,	'test1@bl.com',	'1112233363',	'커플',	'00000',	'서울 종로구 북촌로 31-6(가회동)',	'서울',	'아무개구',	'아무개동',	'101동 131호',	'126.984534783',	'37.579664295',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'couple',	40);
INSERT INTO LODGING VALUES(32,	'test3@bl.com',	'1112233364',	'가족',	'00000',	'서울 종로구 북촌로 40(가회동, MG새마을금고(가회지점))',	'서울',	'아무개구',	'아무개동',	'101동 132호',	'126.985205458',	'37.580310763',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	41);
INSERT INTO LODGING VALUES(33,	'test5@bl.com',	'1112233365',	'mt',	'00000',	'울산 북구 가대서길 25(가대동)',	'울산',	'아무개구',	'아무개동',	'101동 133호',	'129.310928489',	'35.604141499',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	42);
INSERT INTO LODGING VALUES(34,	'test7@bl.com',	'1112233366',	'바다',	'00000',	'인천 서구 가경주로 10(가정동)',	'인천',	'아무개구',	'아무개동',	'101동 134호',	'126.673597315',	'37.514240655',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	130000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'tag4',	43);
INSERT INTO LODGING VALUES(35,	'test9@bl.com',	'1112233367',	'힐링',	'00000',	'전남 강진군 강진읍 강진공단길 8(서성리)',	'전남',	'아무개구',	'아무개동',	'101동 135호',	'126.758382914',	'34.631067549',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	140000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'tag5',	44);
INSERT INTO LODGING VALUES(36,	'test11@bl.com',	'1112233368',	'나홀로',	'00000',	'전북 고창군 고수면 가협길 12(은사리)',	'전북',	'아무개구',	'아무개동',	'101동 136호',	'126.707792136',	'35.379006091',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	150000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'tag6',	45);
INSERT INTO LODGING VALUES(37,	'test13@bl.com',	'1112233369',	'커플',	'00000',	'제주특별자치도 제주시 한림읍 가린내길 8(금악리)',	'제주',	'아무개구',	'아무개동',	'101동 137호',	'126.307423721',	'33.361824113',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	100000,	'13:00',	'09:00',	2,	1,	1,	1,	10000,	0,	1,	'couple',	46);
INSERT INTO LODGING VALUES(38,	'test15@bl.com',	'1112233370',	'가족',	'00000',	'충남 계룡시 계룡대로 239(금암동)',	'충남',	'아무개구',	'아무개동',	'101동 138호',	'127.259622644',	'36.268268669',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	110000,	'13:00',	'09:00',	3,	2,	2,	2,	10000,	0,	1,	'family',	47);
INSERT INTO LODGING VALUES(39,	'test17@bl.com',	'1112233371',	'mt',	'00000',	'충북 괴산군 감물면 감물로 7(오성리)',	'충북',	'아무개구',	'아무개동',	'101동 139호',	'127.868182736',	'36.837429828',	'0102223333',	'숙소설명을 입력해주세요 쾌적한 숙소 안녕하세요 반갑습니다',	120000,	'13:00',	'09:00',	4,	1,	1,	1,	10000,	0,	1,	'mt',	48);

-- FACILITY
INSERT INTO FACILITY VALUES(	'amenity',	1);
INSERT INTO FACILITY VALUES(	'business',	1);
INSERT INTO FACILITY VALUES(	'nosmoking',	1);
INSERT INTO FACILITY VALUES(	'parking',	1);
INSERT INTO FACILITY VALUES(	'roompc',	1);
INSERT INTO FACILITY VALUES(	'twinbed',	1);
INSERT INTO FACILITY VALUES(	'wifi',	1);
INSERT INTO FACILITY VALUES(	'vod',	1);
INSERT INTO FACILITY VALUES(	'washingmachine',	1);
INSERT INTO FACILITY VALUES(	'amenity',	2);
INSERT INTO FACILITY VALUES(	'parking',	2);
INSERT INTO FACILITY VALUES(	'roompc',	2);
INSERT INTO FACILITY VALUES(	'wifi',	2);
INSERT INTO FACILITY VALUES(	'vod',	2);
INSERT INTO FACILITY VALUES(	'washingmachine',	2);
INSERT INTO FACILITY VALUES(	'amenity',	3);
INSERT INTO FACILITY VALUES(	'nosmoking',	3);
INSERT INTO FACILITY VALUES(	'parking',	3);
INSERT INTO FACILITY VALUES(	'roompc',	3);
INSERT INTO FACILITY VALUES(	'wifi',	3);
INSERT INTO FACILITY VALUES(	'vod',	3);
INSERT INTO FACILITY VALUES(	'washingmachine',	3);
INSERT INTO FACILITY VALUES(	'amenity',	4);
INSERT INTO FACILITY VALUES(	'business',	4);
INSERT INTO FACILITY VALUES(	'roompc',	4);
INSERT INTO FACILITY VALUES(	'twinbed',	4);
INSERT INTO FACILITY VALUES(	'wifi',	4);
INSERT INTO FACILITY VALUES(	'vod',	4);
INSERT INTO FACILITY VALUES(	'washingmachine',	4);
INSERT INTO FACILITY VALUES(	'business',	5);
INSERT INTO FACILITY VALUES(	'nosmoking',	5);
INSERT INTO FACILITY VALUES(	'parking',	5);
INSERT INTO FACILITY VALUES(	'wifi',	5);
INSERT INTO FACILITY VALUES(	'vod',	5);
INSERT INTO FACILITY VALUES(	'washingmachine',	5);
INSERT INTO FACILITY VALUES(	'amenity',	6);
INSERT INTO FACILITY VALUES(	'parking',	6);
INSERT INTO FACILITY VALUES(	'roompc',	6);
INSERT INTO FACILITY VALUES(	'twinbed',	6);
INSERT INTO FACILITY VALUES(	'wifi',	6);
INSERT INTO FACILITY VALUES(	'vod',	6);
INSERT INTO FACILITY VALUES(	'washingmachine',	6);
INSERT INTO FACILITY VALUES(	'amenity',	7);
INSERT INTO FACILITY VALUES(	'nosmoking',	7);
INSERT INTO FACILITY VALUES(	'parking',	7);
INSERT INTO FACILITY VALUES(	'twinbed',	7);
INSERT INTO FACILITY VALUES(	'vod',	7);
INSERT INTO FACILITY VALUES(	'washingmachine',	7);
INSERT INTO FACILITY VALUES(	'amenity',	8);
INSERT INTO FACILITY VALUES(	'business',	8);
INSERT INTO FACILITY VALUES(	'nosmoking',	8);
INSERT INTO FACILITY VALUES(	'parking',	8);
INSERT INTO FACILITY VALUES(	'roompc',	8);
INSERT INTO FACILITY VALUES(	'twinbed',	8);
INSERT INTO FACILITY VALUES(	'wifi',	8);
INSERT INTO FACILITY VALUES(	'vod',	8);
INSERT INTO FACILITY VALUES(	'washingmachine',	8);
INSERT INTO FACILITY VALUES(	'washingmachine',	9);
INSERT INTO FACILITY VALUES(	'amenity',	10);
INSERT INTO FACILITY VALUES(	'nosmoking',	11);
INSERT INTO FACILITY VALUES(	'parking',	12);
INSERT INTO FACILITY VALUES(	'roompc',	13);
INSERT INTO FACILITY VALUES(	'wifi',	14);
INSERT INTO FACILITY VALUES(	'vod',	15);
INSERT INTO FACILITY VALUES(	'washingmachine',	16);
INSERT INTO FACILITY VALUES(	'amenity',	17);
INSERT INTO FACILITY VALUES(	'business',	18);
INSERT INTO FACILITY VALUES(	'roompc',	19);
INSERT INTO FACILITY VALUES(	'twinbed',	20);
INSERT INTO FACILITY VALUES(	'wifi',	21);
INSERT INTO FACILITY VALUES(	'vod',	22);
INSERT INTO FACILITY VALUES(	'washingmachine',	23);
INSERT INTO FACILITY VALUES(	'business',	24);
INSERT INTO FACILITY VALUES(	'nosmoking',	25);
INSERT INTO FACILITY VALUES(	'parking',	26);
INSERT INTO FACILITY VALUES(	'wifi',	27);
INSERT INTO FACILITY VALUES(	'vod',	28);
INSERT INTO FACILITY VALUES(	'washingmachine',	29);
INSERT INTO FACILITY VALUES(	'amenity',	30);
INSERT INTO FACILITY VALUES(	'washingmachine',	31);
INSERT INTO FACILITY VALUES(	'business',	32);
INSERT INTO FACILITY VALUES(	'nosmoking',	33);
INSERT INTO FACILITY VALUES(	'parking',	34);
INSERT INTO FACILITY VALUES(	'wifi',	35);
INSERT INTO FACILITY VALUES(	'vod',	36);
INSERT INTO FACILITY VALUES(	'washingmachine',	37);
INSERT INTO FACILITY VALUES(	'amenity',	38);
INSERT INTO FACILITY VALUES(	'washingmachine',	39);

-- IMAGE
INSERT INTO IMAGE VALUES(	'1',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'1',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'1',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'1',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'1',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'2',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'2',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'2',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'2',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'2',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'3',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'3',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'3',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'3',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'3',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'4',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'4',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'4',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'4',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'4',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'5',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'5',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'5',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'5',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'5',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'6',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'6',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'6',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'6',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'6',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'7',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'7',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'7',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'7',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'7',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'8',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'8',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'8',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'8',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'8',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'9',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'9',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'9',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'9',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'9',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'10',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'10',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'10',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'10',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'10',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'11',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'11',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'11',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'11',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'11',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'12',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'12',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'12',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'12',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'12',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'13',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'13',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'13',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'13',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'13',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'14',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'14',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'14',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'14',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'14',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'15',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'15',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'15',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'15',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'15',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'16',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'16',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'16',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'16',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'16',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'17',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'17',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'17',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'17',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'17',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'18',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'18',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'18',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'18',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'18',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'19',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'19',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'19',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'19',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'19',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'20',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'20',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'20',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'20',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'20',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'21',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'22',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'23',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'24',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'25',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'26',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'27',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'28',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'29',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'30',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'31',	'room03.jpg',	'image/jpeg',	'20230719_021758101_275.jpg');
INSERT INTO IMAGE VALUES(	'32',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'33',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'34',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'35',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');
INSERT INTO IMAGE VALUES(	'36',	'room04.jpg',	'image/jpeg',	'20230719_021758102_144.jpg');
INSERT INTO IMAGE VALUES(	'37',	'room05.jpg',	'image/jpeg',	'20230719_021758103_979.jpg');
INSERT INTO IMAGE VALUES(	'38',	'room01.jpg',	'image/jpeg',	'20230719_021758097_321.jpg');
INSERT INTO IMAGE VALUES(	'39',	'room02.jpg',	'image/jpeg',	'20230719_021758099_842.jpg');


-- REVIEW
-- WISHLIST

-- RESERVATION
-- PAYMENT

-- CHAT
-- MESSAGE


commit;
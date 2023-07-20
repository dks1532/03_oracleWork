----------------------------------------------------------------
---------------------- MEMBER TABLE --------------------------
----------------------------------------------------------------
CREATE TABLE MEMBER (
    USER_ID VARCHAR2(30) PRIMARY KEY,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(15) NOT NULL,
    EMAIL VARCHAR2(100),
    BIRTHDAY DATE,
    PHONE CHAR(13),
    CREATE_DATE DATE DEFAULT SYSDATE,
    STATUS NUMBER DEFAULT 1 CHECK(STATUS IN(1, 0))
);

INSERT INTO MEMBER
VALUES ('admin', '1234', '관리자', 'admin@kh.or.kr', to_date('93-01-20','rr-mm-dd'), '010-1111-2222', DEFAULT, DEFAULT);

INSERT INTO MEMBER
VALUES ('user01', '1234', '홍길동', 'user01@kh.or.kr', to_date('03-11-15','rr-mm-dd'), '010-1111-2223', DEFAULT, DEFAULT);

INSERT INTO MEMBER
VALUES ('user02', '1234', '아무개', 'user02@kh.or.kr', to_date('07-10-25','rr-mm-dd'), '010-1111-2224', DEFAULT, DEFAULT);

commit;

----------------------------------------------------------------
---------------------- BOARD TABLE --------------------------
----------------------------------------------------------------

CREATE TABLE board(
    board_no number primary key,
    board_title varchar2(500) not null,
    board_writer varchar2(30) not null references member ON DELETE SET NULL,
    content varchar2(4000) not null,
    original_filename varchar2(256),
    change_filename varchar2(256),
    count number default 0,
    create_date date default sysdate
);

create sequence seq_board_no;

COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '게시글작성자아이디';
COMMENT ON COLUMN BOARD.CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN BOARD.CHANGE_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN BOARD.COUNT IS '조회수';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '게시글작성날짜';

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '첫번째 게시판 서비스를 시작하겠습니다.','admin', '안녕하세요. 첫 게시판입니다.', NULL, NULL, DEFAULT, '20230311');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '두번째 게시판 서비스를 시작하겠습니다.','user01','안녕하세요. 2 게시판입니다.', NULL, NULL, DEFAULT, '20230315');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '하이 에브리원 게시판 서비스를 시작하겠습니다.','user01', '안녕하세요. 3 게시판입니다', NULL, NULL, DEFAULT, '20230319');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '안녕.. 마이바티스는 처음이지?','user01', '안녕하세요. 첫 게시판입니다.', NULL, NULL, DEFAULT, '20230320');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '안녕. 제목1','user01', '안녕 내용1', NULL, NULL, DEFAULT, '20230323');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '페이징 처리때문에 샘플데이터 많이 넣어놓는다...','user01', '안녕하십니까', NULL, NULL, DEFAULT, '20230324');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL,'제목2','user01','내용2', NULL, NULL, DEFAULT, '20230325');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL,'제목3','user01','내용3' , NULL, NULL, DEFAULT, '20230326');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL,'제목4','user01','내용4', NULL, NULL, DEFAULT, '20230327');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '제목5','user01','내용5', NULL, NULL, DEFAULT, '20230328');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL,'제목6','user01','내용6', NULL, NULL, DEFAULT, '20230329');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '제목7','user01','내용7', NULL, NULL, DEFAULT, '20230401');

INSERT INTO BOARD
VALUES(SEQ_BOARD_NO.NEXTVAL, '마지막 게시판 시작하겠습니다.','user01', '안녕하세요. 마지막 게시판입니다.', NULL, NULL, DEFAULT, '20230403');
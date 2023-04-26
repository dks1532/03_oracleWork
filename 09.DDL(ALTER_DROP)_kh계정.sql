/*
    <ALTER>
    객체를 변경하는 구문
    
    [표현식]
    ALTER TABLE 테이블명 변경할내용;
    
    * 변경할 내용
      1) 컬럼 추가/수정/삭제
      2) 제약조건 추가/삭제 -> 수정을 불가(수정하고자 하면 삭제한 후 새로 추가)
      3) 컬럼명/제약조건명/테이블명 변경
*/
--  DEPT_COPY 테이블 만들기(DEPARTMENT테이블에서)
    CREATE TABLE DEPT_COPY
    AS SELECT *
         FROM DEPARTMENT;
         
-- 1) 컬럼 추가/수정/삭제
--  1.1 컬럼의 추가(ADD) : ADD 컬럼명 데이터타입 [DEFAULT 기본값]
--      CNAME컬럼 추가(VARCHAR2(20))
        ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
        
--      LNAME컬럼 추가(VARCHAR2(20)), 기본값 = 한국
        ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
        
--  1.2 컬럼 수정(MODIFY)
-->  데이터 타입 수정 : MODIFY 컬럼명 바꾸고자하는데이터타입
-->  DEFAULT값 수정 : MODIFY 컬럼명 DEFAULT 바꾸고자하는기본값

--   DEPT_COPY 테이블의 DEPT_ID의 CHAR(2) -> CHAR(3)으로 변경
      ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--   DEPT_COPY 테이블의 DEPT_ID의 CHAR(3) -> NUMBER로 변경
     ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
     -- 오류 발생 : 데이터값에 영문이 들어있음(영문->숫자변경 불가).
     -- 수정을 위해서는 데이터를 모두 지워야 변경가능
     
     ALTER TABLE EMPLOYEE_COPY MODIFY EMP_ID NUMBER;
    -- 오류 : 수정을 위해서는 데이터를 모두 지워야 변경가능

    ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
    -- 오류 : 컬럼의 값이 10BYTE를 넘는 값이 있음

-- DEPT_TITLE을 VARCHAR2(40)로 LOCATION_ID를 VARCHAR2(2)로 LNAME의 기본값으 '미국'으로 변경
--   다중변경 가능
ALTER TABLE DEPT_COPY
     MODIFY DEPT_TITLE VARCHAR2(40)
     MODIFY LOCATION_ID VARCHAR2(2)
     MODIFY LNAME DEFAULT '미국';

-- 1.3 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자하는컬럼명
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;

--    컬럼삭제는 다중삭제 안됨
ALTER TABLE DEPT_COPY
       DROP COLUMN DEPT_TITLE
       DROP COLUMN LNAME;

CREATE TABLE DEPT_COPY2
AS SELECT *
     FROM DEPT_COPY;

ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE; 
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
--> 오류 : 최소 한개의 컬럼은 존재해야됨

--------------------------------------------------------------------------------
/*
    2. 제약조건 추가/삭제
      2.1 제약조건 추가
      PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
      FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명 [(컬럼명)]
      UNIQUE : ADD UNIQUE(컬럼명)
      CHECK : ADD CHECK(컬럼에대한조건)
      NOT NULL : MODIFY 컬럼명 NULL|NOT NULL
      
      제약조건명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/
-- DEPT_COPY 테이블에 DEPT_ID에 PRIMARY KEY 추가
-- DEPT_COPY 테이블에 DEPT_TITLE에 UNIQUE 추가
-- DEPT_COPY 테이블에 LNAME에 NOT NULL과 제약조건명도 추가

ALTER TABLE DEPT_COPY
        ADD CONSTRAINT DID_PK PRIMARY KEY(DEPT_ID)
        ADD CONSTRAINT DTITLE_UQ UNIQUE(DEPT_TITLE)
     MODIFY LNAME CONSTRAINT LNAME_NN NOT NULL; 

--  2.2 제약조건 삭제 : DROP CONSTRAINT 제약조건 / MODIFY 컬럼명 NULL(NOT NULL 제약조건일 경우)
ALTER TABLE DEPT_COPY
       DROP CONSTRAINT DID_PK;
       
ALTER TABLE DEPT_COPY
       DROP CONSTRAINT DTITLE_UQ
     MODIFY LNAME NULL;  

--------------------------------------------------------------------------------
-- 3. 컬럼명/제약조건명/테이블명 변경(RENAME)
--   3.1 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
--       DEPT_TITLE => DEPT_NAME 컬럼명 변경
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--   3.2 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C008544 TO DID_NN;

--   3.3 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    <DROP>
    테이블 삭제
    
    [표현법]
    DROP TABLE 테이블명
*/
DROP TABLE DEPT_TEST;
-- 단, 어딘가에서 참조되고 있는 부모테이블은 함부로 삭제 안됨
-- 삭제하고자 한다면
-- 방법1. 자식테이블을 먼저 삭제한 후 부모테이블 삭제하는 방법
-- 방법2. 부모테이블만 삭제하는데 제약조건까지 같이 삭제하는 방법
--        DROP TABLE 테이블명 CASCADE CONSTRAINT;
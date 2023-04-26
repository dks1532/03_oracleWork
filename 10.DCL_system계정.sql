/*
    <DCL : DATA CONTROL LANGUAGE>
    데이터 제어 언어
    
    계정에게 시스템권한 또는 객체접근권한을 부여(GRANT) 하거나 회수(REVOKE)하는 구문
    
    > 시스템 권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
    > 객체접근 권한 : 특정 객체들을 조작할 수 있는 권한
*/
/*
    * 시스템권한 종류
    - CREATE SESSION : 접속할 수 있는 권한
    - CREATE TABLE : 테이블을 생성할 수 있는 권한
    - CREATE VIEW : 뷰를 생성할 수 있는 권한
    - CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    ...
*/
alter session set "_oracle_script" = true;

-- 1. SAMPLE/1234 계정 생성
CREATE USER SAMPLE IDENTIFIED BY 1234;

-- 2. 접속할 권한 CREATE SESSION권한 부여
GRANT CREATE SESSION TO SAMPLE;

-- 3. 테이블 생성할 수 있는 권한부여
GRANT CREATE TABLE TO SAMPLE;

-- 4. TABLESPACE할당
-- ALTER USER SAMPLE QUOTA 2M ON users;
alter user SAMPLE default tablespace users quota unlimited on users;

--------------------------------------------------------------------------------
/*
    * 객체에 대한 접근 권한 종류
    특정 객체에 접근하여 조작할 수 있는 권한
    
    권한종류
    SELECT      TABLE, VIEW, SEQUENCE
    INSERT      TABLE, VIEW
    UPDATE      TABLE, VIEW
    DELETE      TABLE, VIEW
    ...
    
    [표현식]
    GRANT 권한종류 ON 특정객체 TO 계정명;
    - GRANT 권한종류 ON 권한을 가지고 있는 USER.특정객체 TO 권한을줄USER;
*/

-- 5. SAMPLE계정에게 KH계정 EMPLOYEE테이블을 SELECT할 수 있는권한
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE계정에게 KH계정 DEPARTMENT테이블에 INSERT할 수 있는 권한
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-- 문) SAMPLE계정에게 KH계정 DEPARTMENT테이블에 SELECT할 수 있는 권한

-- 7. 권한 회수
--    REVOKE 회수할권한 FROM 계정명;
REVOKE SELECT ON KH.EMPLOYEE FROM SAMPLE;
REVOKE INSERT ON KH.DEPARTMENT FROM SAMPLE;
REVOKE SELECT ON KH.DEPARTMENT FROM SAMPLE;

--------------------------------------------------------------------------------
/*
    <롤(ROLE)>
    - 특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : CREATE, SESSION
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ...
    DBA : 시스템 및 객체 관리에 대한 모든 권한을 갖고 있는 롤
    
    GRANT CONNECT, RESOURCE TO 계정명;
    GRANT DBA TO 계정명;
*/
-- VIEW를 생성 할 수 있는 권한
GRANT CREATE VIEW TO KH;
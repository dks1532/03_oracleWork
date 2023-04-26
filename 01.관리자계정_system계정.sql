-- 한줄 주석 : 단축키 ctrl + /
/*
    여러줄 주석 : 단축키 alt + shift + c 
*/

-- 사용자 생성 : 실행시 단축키 ctrl + enter
create user c##test2 identified by 1234;

-- 이를 회피하는 방법 (c## 안붙여도 계정 생성 가능)
alter session set "_oracle_script" = true;

-- 앞으로 테이블을 생성하고 사용하려면 아래 3가지를 해야함
-- 1. kh 사용자 생성
create user kh identified by 1234;

-- 2. 권한부여
grant connect, resource to kh;

-- 3. 테이블스페이스 할당
-- alter user kh quota 30M on users;   -- 명시
alter user kh default tablespace users quota unlimited on users; -- 제한을 두지않고

-- 사용자 삭제
drop user c##test2;

-- 테이블이 존재할 경우 사용자 삭제
drop user c##test2 cascade;

-- 사용자 : ddl
-- 비밀번호 : 1234
alter session set "_oracle_script" = true;
create user ddl identified by 1234;
grant connect, resource to ddl;
alter user ddl default tablespace users quota unlimited on users;

-- 사용자 : workbook / 1234
alter session set "_oracle_script" = true;
create user workbook identified by 1234;
grant connect, resource to workbook;
alter user workbook default tablespace users quota unlimited on users;


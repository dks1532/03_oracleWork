alter session set "_oracle_script" = true;

CREATE USER jsp IDENTIFIED BY 1234;

GRANT CREATE SESSION TO jsp;

GRANT CREATE TABLE TO jsp;

GRANT CREATE SEQUENCE TO jsp;

alter user jsp default tablespace users quota unlimited on users;

------------------------- FINAL 계정 권한 -------------------------
alter session set "_oracle_script" = true;

CREATE USER finaltest IDENTIFIED BY 1234;

grant connect, resource to finaltest;

GRANT CREATE SESSION TO finaltest;

GRANT CREATE TABLE TO finaltest;

GRANT CREATE SEQUENCE TO finaltest;

alter user finaltest default tablespace users quota unlimited on users;
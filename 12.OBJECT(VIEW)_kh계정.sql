/*
    <VIEW 뷰>
    SELECT문을 저장해 둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 매번 기술할 필요가 없음)
    임시테이블 같은 존재(실제 데이터가 담겨있지 않음 => 논리적 테이블)
*/

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여 ,근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

--------------------------------------------------------------------------------
/*
    1. VIEW 생성방법
    
    [표현식]
    CREATE VIEW 뷰명
    AS 서브쿼리;
*/

CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE);

-- 한국, 러시아, 중국
SELECT EMP_NAME, NATIONAL_NAME
  FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '한국';
 
SELECT *
  FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '러시아'; 

SELECT *
  FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '중국'; 

-- 현재 사용자가 가지고 있는 모든 VIEW테이블 검색
SELECT * FROM USER_VIEWS;

------------------------------------------------------------------------------
/*
    * 뷰 컬럼에 별칭 부여
      서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있을 경우 반드시 별칭 지정해야됨
*/
-- VIEW는 기존에 같은 이름의 VIEW 존재할 경우 덮어쓸 수 있음
-- CREATE OR REPLACE VIEW 

-- 모든 사원의 사번, 이름, 직급명, 성별(남/여), 근무년수를 조회하여 VIEW(VW_EMP_JOB)를 생성
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID
        , EMP_NAME
        , JOB_NAME
        , DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

SELECT * FROM VW_EMP_JOB;

-- 아래와 같은 방식으로도 별칭 부여 가능
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)
AS SELECT EMP_ID
        , EMP_NAME
        , JOB_NAME
        , DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여')
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

SELECT 이름, 직급명, 성별
  FROM VW_EMP_JOB
 WHERE 성별 = '여';

SELECT *
  FROM VW_EMP_JOB
 WHERE 근무년수 >= 20;
 
 -- 뷰 삭제
 DROP VIEW VW_EMP_JOB; 
 
--------------------------------------------------------------------------------
-- 생성된 뷰를 이용하여 DML(INSERT, UPDATE, DELETE) 사용가능
-- 뷰를 통해서 조작하면 실제 데이터가 담겨있는 테이블에 반영됨

CREATE OR REPLACE VIEW VW_JOB
AS SELECT *
     FROM JOB;

-- 뷰를 통한 INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴');

-- 뷰를 통한 UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8';  

-- 뷰를 통한 DELETE
DELETE 
  FROM VW_JOB 
 WHERE JOB_CODE = 'J8';
 
/*
    * 단, DML명령어로 조작이 불가능한 경우가 더 많음
    
    1) 뷰에 정의되어 있지 않은 컬럼을 조작하려고 할 때
    2) 뷰에 정의되어 있지 않은 컬럼 이더라도 베이스테이블 상에 NOT NULL제약조건이 지정되어 있는 경우
    3) 산술연산식 또는 함수식으로 정의되어있는 경우
    4) 그룹함수나 GROUP BY절이 포함된 경우
    5) DISTINCT 구문이 포함되어 있는 경우
    6) JOIN을 이용하여 여러 테이블을 연결시켜놓은 경우
*/

-- 1) 뷰에 정의되어 있지 않은 컬럼을 조작하려고 할 때
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
     FROM JOB;

-- INSERT 오류
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8','인턴');

-- UPDATE 오류
UPDATE VW_JOB
   SET JOB_NAME = '인턴'
 WHERE JOB_CODE = 'J7';  

-- DELETE 오류
DELETE
  FROM VW_JOB
 WHERE JOB_NAME = '사원';

-- 2) 뷰에 정의되어 있지 않은 컬럼 이더라도 베이스테이블 상에 NOT NULL제약조건이 지정되어 있는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME
     FROM JOB;

-- INSERT 오류
INSERT INTO VW_JOB VALUES('인턴');  
-- 실제 베이스테이블에 INSERT시(NULL,'인턴') 추가 JOB_CODE는 PRIMARY KEY여서 NULL값을 넣으면 안됨

-- UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_NAME = '사원'; 

ROLLBACK;

-- DELETE(외래키로 제약조건이 있으면 자식이 쓰고있는 값은 삭제불가)
DELETE
  FROM VW_JOB
 WHERE JOB_NAME = '사원';  

DELETE
  FROM VW_JOB
 WHERE JOB_NAME = '대표'; 
 
ROLLBACK; 

-- 3) 산술연산식 또는 함수식으로 정의되어있는 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉
     FROM EMPLOYEE;

-- INSERT 오류
INSERT INTO VW_EMP_SAL VALUES(400, '김상진', 3000000, 36000000);
-- 베이스테이블에는 연봉이라는 컬럼이 없음

-- UPDATE 오류(베이스테이블에 연봉컬럼 없음)
UPDATE VW_EMP_SAL
   SET 연봉 = 80000000
 WHERE EMP_ID = 200;

-- UPDATE 성공(베이스테이블에 SALARY컬럼 있음)
UPDATE VW_EMP_SAL
   SET SALARY = 3000000
 WHERE EMP_ID = 211;

-- DELETE성공(행 전체를 삭제하기 때문에 베이스테이블에 컬럼이 없어도 성공)
DELETE
  FROM VW_EMP_SAL
 WHERE 연봉 = 44400000; 

ROLLBACK;

-- 4) 그룹함수나 GROUP BY절이 포함된 경우
CREATE OR REPLACE VIEW VW_GROUPEMP
AS SELECT DEPT_CODE, SUM(SALARY) 합계, CEIL(AVG(SALARY)) 평균
     FROM EMPLOYEE
    GROUP BY DEPT_CODE;

-- INSERT 오류
INSERT INTO VW_GROUPEMP VALUES('D3',80000000, 7500000);

-- UPDATE 오류
UPDATE VW_GROUPEMP
   SET 합계 = 8000000
 WHERE DEPT_CODE = 'D1'; 

-- DELETE 오류
DELETE
  FROM VW_GROUPEMP
 WHERE 합계 = 3500000;

-- 5) DISTINCT 구문이 포함되어 있는 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
              FROM EMPLOYEE;

-- INSERT 오류
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE 오류
UPDATE VW_DT_JOB
   SET JOB_CODE = 'J8'
 WHERE JOB_CODE = 'J7';
 
-- DELETE 오류
DELETE FROM VW_DT_JOB WHERE JOB_CODE = 'J3';

-- 6) JOIN을 이용하여 여러 테이블을 연결시켜놓은 경우
CREATE OR REPLACE VIEW VW_JOIN
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID; 
     
-- INSERT 오류(베이스테이블을 동시에 2개의 테이블 수정 불가)
INSERT INTO VW_JOIN VALUES(300, '황미해', '총무부');

-- UPDATE 성공
UPDATE VW_JOIN
   SET EMP_NAME = '김새로'
 WHERE EMP_ID = 200; 

-- UPDATE(JOIN한 테이블과 맞지 않음. 조심해야됨)
UPDATE VW_JOIN
   SET DEPT_TITLE = '총무부'
 WHERE EMP_ID = 200;

ROLLBACK;

-------------------------------------------------------------------------------
/*
    * VIEW옵션
    
    [상세표현식] 
    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE : 기존에 동일한 뷰가 있을 경우 갱신시키고, 존재하지 않으면 새로 생성함
    2) FORCE | NOFORCE
      > FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 함
      > NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이어야한 뷰가 생성됨(생략시 기본값)
    3) WITH CHECK OPTION  : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML 가능하도록 함
    4) WITH READ ONLY : 뷰에 대해 조회만 가능(DML문 수행 불가)
*/

-- 2) FORCE | NOFORCE
--    >> NOFORCE(기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW VM_EMP
AS SELECT NCODE, NMANE, NCONTENT
     FROM NN;

--    >> FORCE
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT NCODE, NMANE, NCONTENT
     FROM NN;

SELECT * FROM VW_EMP;

-- NN테이블을 생성해야만 그때부터 VIEW 활용가능
CREATE TABLE NN(
    NCODE NUMBER
  , NMANE VARCHAR2(20)
  , NCONTENT VARCHAR2(50)
);

SELECT * FROM VW_EMP;

-- 3) WITH CHECK OPTION
-- WITH CHECK OPTION 안쓰고
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
     FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
-- 200번 사원의 급여를 2000000으로 변경
UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;  
-- 9명 -> 8명으로 VIEW의 행이 변경됨

ROLLBACK;

-- WITH CHECK OPTION 쓰고
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
     FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;   

-- 200번 사원의 급여를 2000000으로 변경
UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;
-- 오류 : 서브쿼리에 기술한 조건에 부합하지 않기 때문에 변경 불가

UPDATE VW_EMP
   SET SALARY = 4000000
 WHERE EMP_ID = 200;

-- 4) WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
     FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;    

-- INSERT, UPDATE, DELETE 모두 안됨
DELETE FROM VW_EMP WHERE EMP_ID = 200;
/*
    <SEQUENCE>
    자동으로 번호 발생시켜주는 역할을 하는 객체
    정수값을 순차적으로 일정값씩 증가시키면서 생성해줌
    
    EX) 회원번호, 사원번호, 게시글번호, ....
*/
/*
    1. 시퀀스 객체 생성
    
    [표현식]
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자]       --> 처음 발생시킬 시작값 지정(기본값 1)
    [INCREMENT BY 숫자]         --> 몇 씩 증가시킬것인지(기본값 1)
    [MAXVALUE 숫자]             --> 최대값 지정 (기본값 큼)
    [MINVALUE 숫자]             --> 최소값 지정 (기본값 1)
    [CYCLE | NOCYCLE]          --> 값 순환 여부 지정 (기본값 NOCYCLE)
    [NOCACHE | CACHE]          --> 캐시 메모리 할당(기본값 CACHE 20)
    
    * 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
                  매번 호출될때 마다 새롭게 번호를 생성하는것이 아니라
                  캐시메모리 공간에 미리 생성된 값들을 가져다 쓸 수 있음(속도가 빨라짐)
                  접속이 해제되면 => 캐시메모리에 미리 만들어 둔 값들은 사라짐
*/

CREATE SEQUENCE SEQ_TEST;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. 시퀀스 사용
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 성공적으로 수행한 NEXTVAL의 값)   
    시퀀스명.NEXTVAL : 시퀀스값에 일정값을 증가시켜서 발생된 값                     
                      현재 시퀀스 값에서 INCREMENT BY값 만큼 증가된 값
                      == 시퀀스명.CURRVAL + INCREMENT BY값
*/
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 300사용
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;  -- 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 300+5= 305 사용
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 305+5 = 310 사용
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 310+5 = 315 사용못함( MAXVALUE를 310으로 했기 때문에 오류)
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;  -- 310

CREATE SEQUENCE SEQ_EMPNO3
START WITH 300
INCREMENT BY 5
MAXVALUE 310
CYCLE
NOCACHE;

SELECT SEQ_EMPNO3.NEXTVAL FROM DUAL;  -- 300사용
SELECT SEQ_EMPNO3.NEXTVAL FROM DUAL;  -- 300+5= 305 사용
SELECT SEQ_EMPNO3.NEXTVAL FROM DUAL;  -- 305+5 = 310 사용
SELECT SEQ_EMPNO3.NEXTVAL FROM DUAL;  -- MINVALUE값으로 순환 (기본값 1)
SELECT SEQ_EMPNO3.NEXTVAL FROM DUAL;

CREATE SEQUENCE SEQ_EMPNO4
START WITH 300
INCREMENT BY 5
MINVALUE 300
MAXVALUE 310
CYCLE
NOCACHE;

SELECT SEQ_EMPNO4.NEXTVAL FROM DUAL;  -- 300사용
SELECT SEQ_EMPNO4.NEXTVAL FROM DUAL;  -- 300+5= 305 사용
SELECT SEQ_EMPNO4.NEXTVAL FROM DUAL;  -- 305+5 = 310 사용
SELECT SEQ_EMPNO4.NEXTVAL FROM DUAL;  -- MINVALUE값으로 순환(300)
SELECT SEQ_EMPNO4.NEXTVAL FROM DUAL;

/*
    3. 시퀀스 구조 변경
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 숫자]         --> 몇 씩 증가시킬것인지(기본값 1)
    [MAXVALUE 숫자]             --> 최대값 지정 (기본값 큼)
    [MINVALUE 숫자]             --> 최소값 지정 (기본값 1)
    [CYCLE | NOCYCLE]          --> 값 순환 여부 지정 (기본값 NOCYCLE)
    [NOCACHE | CACHE]          --> 캐시 메모리 할당(기본값 CACHE 20)
    
    * START WITH 변경 불가!!!
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310 + 10 = 320

-- 4. 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;

--------------------------------------------------------------------------------
-- 사원번호로 활용할 시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 400;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
      VALUES(SEQ_EID.NEXTVAL, '이개똥', '200312-3123456', 'J5', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
      VALUES(SEQ_EID.NEXTVAL, '최개똥', '211123-4123456', 'J1', '21/03/12');
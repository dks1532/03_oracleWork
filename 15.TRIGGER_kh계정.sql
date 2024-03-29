/*
    <TRIGGER>
    내가 지정한 테이블에 DML문에 의해 변경사항이 생겼을 때 자동으로 매번 실행할 내용을 미리 정의해 둘 수 있는 객체
    
    EX) 회원탈퇴시 기존의 회원테이블의 데이터 DELETE 후 곧바로 탈퇴된 회원만 따로 보관하는 테이블에 자동으로 INSERT처리
        신고횟수가 일정 수를 넘었을 때 묵시적으로 해당 회원을 자동으로 블랙리스트로 처리되도록
        입출고에 대한 데이터가 입고, 출고가 되었을 때 자동으로 재고수량을 수정 처리
        
    * 트리거 종류
    - SQL문의 실행시기에 따른 분류
        > BEFORE TRIGGER : 명시한 테이블에 이벤트가 발생되기 전에 트리거 실행
        > AFTER TRIGGER : 명시한 테이블에 이벤트가 발생한 후에 트리거 실행
    
    - SQL문에 의해 영향을 받는 각 행에 따른 분류
        > STATEMENT TRIGGER(문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
        > ROW TRIGGER(행 트리거) : 해당 SQL문 실행할 때마다 매번 트리거 실행
                                    (FOR EACH ROW 옵션 기술해야됨)
                                    > :OLD - 기존컬럼에 들어 있던 데이터
                                    > :NEW - 새로 들어온 데이터
                                    
    * 트리거 생성 구문
    [표현식]
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
    [FOR EACH ROW]
    [DECLARE 변수선언;]
    BEGIN
        실행내용
    [EXCEPTION 예외처리구문;]
    END;
    /
    
    * 트리거 삭제
    DROP TRIGGER 트리거이름;
*/

-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때마다 자동으로 메시지 출력하는 트리거 정의
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다');
END;
/

SET SERVEROUT ON;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES(700,'강호동','971120-1234567','J2',SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES(701,'딘딘','951226-1234567','J3',SYSDATE);

-- 상품 입고 및 출고가 되면 재고수량이 변경되도록 하는 예
-- 1. 상품에 대한 데이터를 보관할 테이블(TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,   -- 상품번호
    PNAME VARCHAR2(30) NOT NULL,    -- 상품명
    BRAND VARCHAR2(30) NOT NULL,    -- 브랜드명
    STOCK_QUANT NUMBER DEFAULT 0    -- 재고수량
);

--  상품번호에 넣을 시퀀스(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5;

--  샘플데이터
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시20', '삼성', DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰13', '애플', 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '홍미노트10', '샤오미', 20);

COMMIT;

-- 2. 입고테이블(TB_PROSTOCK)
CREATE TABLE TB_PROSTOCK(
    TCODE NUMBER PRIMARY KEY,           -- 입고번호
    PCODE NUMBER REFERENCES TB_PRODUCT, -- 상품번호
    TDATE DATE,                         -- 상품입고일
    STOCK_COUNT NUMBER NOT NULL,        -- 입고수량
    STOCK_PRICE NUMBER NOT NULL         -- 입고단가
);

-- 입고번호에 넣을 시퀀스(SEQ_TCODE)
CREATE SEQUENCE SEQ_TCODE;

-- 3. 판매테이블(TB_PROSALE)
CREATE TABLE TB_PROSALE (
    SCODE NUMBER PRIMARY KEY,        -- 판매번호
    PCODE NUMBER REFERENCES TB_PRODUCT, -- 상품번호
    SDATE DATE,                         -- 판매일
    SALE_COUNT NUMBER NOT NULL,         -- 판매수량
    SALE_PRICE NUMBER NOT NULL          -- 판매단가
);

-- 판매번호에 넣을 시퀀스(SEQ_TCODE)
CREATE SEQUENCE SEQ_SCODE;

-- 200번 상품 입고 10개
INSERT INTO TB_PROSTOCK
    VALUES(SEQ_TCODE.NEXTVAL, 200, SYSDATE, 10, 900000);
    
-- TB_PRODUCT테이블의 200번 상품의 재고수량을 10증가
UPDATE TB_PRODUCT
SET STOCK_QUANT = STOCK_QUANT + 10
WHERE PCODE = 200;

COMMIT;

-- 210번 상품이 오늘 날짜로 5개 출고
INSERT INTO TB_PROSALE
VALUES(SEQ_SCODE.NEXTVAL, 210, SYSDATE, 5, 500000);

UPDATE TB_PRODUCT
SET STOCK_QUANT = STOCK_QUANT - 5
WHERE PCODE = 210;
COMMIT;

-- 트리거 정의
-- TB_PROSTOCK 테이블에 입고(INSERT) 이벤트 발생시
/*
    - 해당 상품을 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT + 현재입고된 수량(INSERT시 STOCK_COUNT값)
    WHERE PCODE = 입고된상품의번호(INSERT시 PCODE값);
*/
CREATE OR REPLACE TRIGGER TRG_STOCK
AFTER INSERT ON TB_PROSTOCK
FOR EACH ROW
BEGIN
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT + :NEW.STOCK_COUNT
    WHERE PCODE = :NEW.PCODE;
END;
/

-- 205번 상품이 오늘날짜로 5개입고
INSERT INTO TB_PROSTOCK
    VALUES(SEQ_TCODE.NEXTVAL, 205, SYSDATE, 5, 1000000);

-- 210번 상품이 오늘날짜로 100개입고
INSERT INTO TB_PROSTOCK
    VALUES(SEQ_TCODE.NEXTVAL, 210, SYSDATE, 100, 300000);


-- TB_PROSALE테이블에 출고 INSERT이벤트 발생시 트리거
/*
    - 해당 상품을 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT - 현재출고된수량(INSSERT시 SALE_COUNT값)
    WHERE PCODE = 출고된상품번호(INSERT시 PCODE값);
*/
CREATE OR REPLACE TRIGGER TRG_SALE
AFTER INSERT ON TB_PROSALE
FOR EACH ROW
BEGIN
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT - :NEW.SALE_COUNT
    WHERE PCODE = :NEW.PCODE;
END;
/

INSERT INTO TB_PROSALE
VALUES(SEQ_SCODE.NEXTVAL, 200, SYSDATE, 5, 1100000);

INSERT INTO TB_PROSALE
VALUES(SEQ_SCODE.NEXTVAL, 210, SYSDATE, 50, 500000);

-- 출고시 재고수량이 부족할 경우 출고가 안되게하는 트리거
/*
    * 사용자 함수 예외처리
    RAISE_APPLICATION_ERROR([에러코드],[에러메시지])
    - 에러코드 : -20000 ~ -20999 사이의 코드
*/
CREATE OR REPLACE TRIGGER TRG_SALE
BEFORE INSERT ON TB_PROSALE
FOR EACH ROW
DECLARE
    SCOUNT NUMBER;
BEGIN
    SELECT STOCK_QUANT
    INTO SCOUNT
    FROM TB_PRODUCT
    WHERE PCODE = :NEW.PCODE;
    
    IF(SCOUNT >= :NEW.SALE_COUNT)
        THEN
            UPDATE TB_PRODUCT
            SET STOCK_QUANT = STOCK_QUANT - :NEW.SALE_COUNT
            WHERE PCODE = :NEW.PCODE;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, '재고수량 부족으로 판매할 수 없음');
    END IF;
END;
/

INSERT INTO TB_PROSALE
VALUES(SEQ_SCODE.NEXTVAL, 200, SYSDATE, 10, 1100000);

-- 입고수량을 수정할 때 트리거
CREATE OR REPLACE TRIGGER TRG_UPDATE
AFTER UPDATE ON TB_PROSTOCK
FOR EACH ROW
BEGIN
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT - :OLD.STOCK_COUNT + :NEW.STOCK_COUNT
    WHERE PCODE = :NEW.PCODE;
END;
/

UPDATE TB_PROSTOCK
SET STOCK_COUNT = 50
WHERE TCODE = 3;

-- TB_PROSTOCK 테이블에서 삭제 트리거
CREATE OR REPLACE TRIGGER TRG_DELETE
AFTER DELETE ON TB_PROSTOCK
FOR EACH ROW
BEGIN
    UPDATE TB_PRODUCT
    SET STOCK_QUANT = STOCK_QUANT - :OLD.STOCK_COUNT
    WHERE PCODE = :NEW.PCODE;
END;
/

--------------------------------- 입출력을 한 테이블에 저장
--  하나의 트리거로 입/출력 발생시 모두 할 수 있도록

-- 4. 상품의 입출고 테이블(TB_PRODETAIL)
CREATE TABLE TB_PRODETAIL (
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT,
    DDATE DATE,
    AMOUNT NUMBER NOT NULL,  -- 입출고수량
    STATUS VARCHAR2(6) CHECK(STATUS IN ('입고', '출고'))
);
-- 시퀀스
CREATE SEQUENCE SEQ_DCODE;

-- 입출력시 트리거 생성
CREATE OR REPLACE TRIGGER TRG_PRO
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- 상품이 '입고'이면 => 재고수량 증가
    IF(:NEW.STATUS = '입고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK_QUANT = STOCK_QUANT + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- 상품이 '출고'이면 => 재고수량 감소
    IF(:NEW.STATUS = '출고')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK_QUANT = STOCK_QUANT - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

INSERT INTO TB_PRODETAIL
VALUES(SEQ_SCODE.NEXTVAL, 210, SYSDATE, 10, '입고');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_SCODE.NEXTVAL, 210, SYSDATE, 10, '출고');

-- 수정시 트리거

-- 삭제시 트리거

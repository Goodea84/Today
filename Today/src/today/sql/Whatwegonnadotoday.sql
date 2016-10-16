--DROP TABLE

DROP TABLE CUSTOMER CASCADE CONSTRAINTS;


--DROP SEQUENCE
DROP SEQUENCE CUST_SEQ;

--CREATE TABLE
CREATE TABLE CUSTOMER
(
	-- 사용자 아이디(key)
	CUST_ID number(2) NOT NULL,
	-- 이메일
	EMAIL varchar2(20 char) NOT NULL UNIQUE,
	-- 사용자 이름
	NAME varchar2(10 char) NOT NULL,
	-- 비밀번호
	PASSWORD varchar2(10 char) NOT NULL UNIQUE,
	-- 주소
	ADDRESS varchar2(20),
	-- 전화번호
	PHONE varchar2(15),
	PRIMARY KEY (CUST_ID)
);


--계정 테이블


--CARD 테이블

--아이템 테이블

--CREATE SEQUENCE
CREATE SEQUENCE CUST_SEQ;


--INCERT CUSTOMER
insert into CUSTOMER values(cust_seq.nextval,'aaa@aaa.aaa','jhs','aaa','서울시','01011111111');
insert into CUSTOMER values(cust_seq.nextval,'bbb@bbb.bbb','ksh','bbb','경기도','01022222222');

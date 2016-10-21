--DROP TABLE

DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE FriendList CASCADE CONSTRAINTS;

--DROP SEQUENCE
DROP SEQUENCE CUST_SEQ;
DROP SEQUENCE FRIEND_SEQ;

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
	
	CUST_IMAGE varchar2(150),
	
	PRIMARY KEY (CUST_ID)
);
--계정 테이블


CREATE TABLE FriendList
(
	-- 친구리스트아이디(key)
	FRIENDLIST_ID number(2) NOT NULL,
	-- 내사용자아이디
	MYCUST_ID number(2) NOT NULL,
	-- 친구사용자 아이디
	FRIENDCUST_ID number(2),
	PRIMARY KEY (FRIENDLIST_ID)
);

-- 친구 목록 테이블


--CARD 테이블

--아이템 테이블


/* Create Foreign Keys */

ALTER TABLE FriendList
	ADD FOREIGN KEY (FRIENDCUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE FriendList
	ADD FOREIGN KEY (MYCUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;



--CREATE SEQUENCE
CREATE SEQUENCE CUST_SEQ;
CREATE SEQUENCE FRIEND_SEQ;

--INCERT CUSTOMER
insert into CUSTOMER values(cust_seq.nextval,'aaa@aaa.aaa','jhs','aaa','서울시','01011111111','friendimg/one.jpg');
insert into CUSTOMER values(cust_seq.nextval,'bbb@bbb.bbb','ksh','bbb','경기도','01022222222','friendimg/two.jpg');
insert into CUSTOMER values(cust_seq.nextval,'ccc@ccc.ccc','ccc','ccc','경기도','01033333333','friendimg/three.jpg');
insert into CUSTOMER values(cust_seq.nextval,'ddd@ddd.ddd','ddd','ddd','경기도','01044444444','friendimg/four.jpg');
insert into CUSTOMER values(cust_seq.nextval,'eee@eee.eee','eee','eee','경기도','01055555555','friendimg/five.jpg');

insert into FriendList values(friend_seq.nextval,1,2);
insert into FriendList values(friend_seq.nextval,2,1);
insert into FriendList values(friend_seq.nextval,1,3);
insert into FriendList values(friend_seq.nextval,3,1);
insert into FriendList values(friend_seq.nextval,1,4);
insert into FriendList values(friend_seq.nextval,4,1);
insert into FriendList values(friend_seq.nextval,1,5);
insert into FriendList values(friend_seq.nextval,5,1);
--DROP TABLE

DROP TABLE CardList CASCADE CONSTRAINTS;
DROP TABLE FriendList CASCADE CONSTRAINTS;
DROP TABLE IMAGE CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE CARD CASCADE CONSTRAINTS;
DROP TABLE ITEM CASCADE CONSTRAINTS;

--DROP SEQUENCE
DROP SEQUENCE CUST_SEQ;
DROP SEQUENCE FRIEND_SEQ;
DROP SEQUENCE CARDLIST_SEQ;
DROP SEQUENCE CARD_SEQ;
DROP SEQUENCE ITEM_SEQ;
DROP SEQUENCE IMAGE_SEQ;
DROP SEQUENCE REPLY_SEQ;


--CREATE TABLE
CREATE TABLE CardList
(
	-- 카드리스트아이디
	CARDLIST_ID number(2) NOT NULL,
	-- 사용자 아이디(key)
	CUST_ID number(2) NOT NULL,
	-- 카드아이디(key)
	CARD_ID number(2) NOT NULL,
	PRIMARY KEY (CARDLIST_ID)
);


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


CREATE TABLE CUSTOMER
(
	-- 사용자 아이디(key)
	CUST_ID number(2) NOT NULL,
	-- 이메일
	EMAIL varchar2(20) NOT NULL UNIQUE,
	-- 사용자 이름
	NAME varchar2(10) NOT NULL,
	-- 비밀번호
	PASSWORD varchar2(10) NOT NULL UNIQUE,
	-- 주소
	ADDRESS varchar2(20),
	-- 전화번호
	PHONE varchar2(15),
	-- 사용자이미지
	CUST_IMAGE varchar2(150),
	PRIMARY KEY (CUST_ID)
);


CREATE TABLE ITEM
(
	-- 아이템아이디
	ITEM_ID number(2) NOT NULL,
	-- 상호명
	title varchar2(50) NOT NULL,
	-- 좌표x
	ITEM_X number(20,10) NOT NULL,
	-- y좌표
	ITEM_Y number(20,10) NOT NULL,
	-- 주소
	address varchar2(80),
	-- 아이템전화번호
	phone varchar2(20),
	PRIMARY KEY (ITEM_ID)
);


CREATE TABLE IMAGE
(
	-- 이미지아이디
	IMAGE_ID number(2) NOT NULL,
	-- 사용자 아이디(key)
	CUST_ID number(2) NOT NULL,
	-- 아이템아이디
	ITEM_ID number(2) NOT NULL,
	-- 사진
	PHOTO varchar2(150),
	PRIMARY KEY (IMAGE_ID)
);


CREATE TABLE CARD
(
	-- 카드아이디(key)
	CARD_ID number(2) NOT NULL,
	-- 위치이름(ex.홍대)
	LOCA_NAME varchar2(30) NOT NULL,
	-- 아이템1
	ITEM1 number(2) NOT NULL,
	-- 아이템2
	ITEM2 number(2) NOT NULL,
	-- 아이템3
	ITEM3 number(2),
	-- 아이템4
	ITEM4 number(2),
	-- 아이템5
	ITEM5 number(2),
	-- 카드작성일
	CARD_DATE date,
	-- 추천
	RECOMMEND number(5) default 0,
	PRIMARY KEY (CARD_ID)
);


CREATE TABLE REPLY
(
	-- 댓글아이디
	REPLY_ID number(2) NOT NULL,
	-- 사용자 아이디(key)
	CUST_ID number(2) NOT NULL,
	-- 아이템아이디
	ITEM_ID number(2) NOT NULL,
	-- 내용
	CONTENT varchar2(200),
	-- 댓글작성일
	RE_DATE date,
	PRIMARY KEY (REPLY_ID)
);


/* Create Foreign Keys */

ALTER TABLE IMAGE
	ADD FOREIGN KEY (CUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE REPLY
	ADD FOREIGN KEY (CUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE FriendList
	ADD FOREIGN KEY (MYCUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE CardList
	ADD FOREIGN KEY (CUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE FriendList
	ADD FOREIGN KEY (FRIENDCUST_ID)
	REFERENCES CUSTOMER (CUST_ID)
;


ALTER TABLE CARD
	ADD FOREIGN KEY (ITEM5)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE REPLY
	ADD FOREIGN KEY (ITEM_ID)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE CARD
	ADD FOREIGN KEY (ITEM1)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE IMAGE
	ADD FOREIGN KEY (ITEM_ID)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE CARD
	ADD FOREIGN KEY (ITEM3)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE CARD
	ADD FOREIGN KEY (ITEM2)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE CARD
	ADD FOREIGN KEY (ITEM4)
	REFERENCES ITEM (ITEM_ID)
;


ALTER TABLE CardList
	ADD FOREIGN KEY (CARD_ID)
	REFERENCES CARD (CARD_ID)
;

--CREATE SEQUENCE
CREATE SEQUENCE CUST_SEQ;
CREATE SEQUENCE FRIEND_SEQ;
CREATE SEQUENCE CARDLIST_SEQ;
CREATE SEQUENCE CARD_SEQ;
CREATE SEQUENCE ITEM_SEQ;
CREATE SEQUENCE IMAGE_SEQ;
CREATE SEQUENCE REPLY_SEQ;


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

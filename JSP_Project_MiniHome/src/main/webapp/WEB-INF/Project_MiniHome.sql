CREATE SEQUENCE member_idx_seq;
CREATE TABLE member(
	idx NUMBER PRIMARY KEY, 
	userid varchar2(100) NOT NULL UNIQUE,
	password varchar2(100) NOT NULL,
	name varchar2(50) NOT NULL,
	birth DATE not NULL,
	gender char(1) CHECK(gender IN ('M','F')),
	email varchar2(100) NOT NULL,
	phone varchar2(20) NOT NULL,
	postcode varchar2(10) NOT NULL,
	addr1 varchar2(200) NOT NULL,
	addr2 varchar2(200) NOT NULL,
	use NUMBER check(use IN (0,1,2,3,4,5,6,7,8,9)),
	lev NUMBER check(lev IN (0,1,2,3,4,5,6,7,8,9)),
	introduce varchar2(1500)
);
INSERT INTO member VALUES
(member_idx_seq.nextval,'root','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'admin','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'master','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'webmaster','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'system','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'sys','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

INSERT INTO member VALUES
(member_idx_seq.nextval,'iptime','1234','최고관리자','1998-09-05','M','ithuman202204@gmail.com','010-1234-5678',' ',' ',' ',1,9,'');

SELECT * FROM member;

CREATE SEQUENCE friend_idx_seq;
CREATE TABLE friend(
	idx NUMBER REFERENCES MEMBER(idx) ON DELETE CASCADE, 
	userid varchar2(200),
	friendid varchar2(200)
);
SELECT * FROM friend;

CREATE SEQUENCE board_idx_seq;
CREATE TABLE miniBoard(
	idx NUMBER PRIMARY KEY,
	userid varchar(200) REFERENCES member(userid),
	category varchar2(100),
	password varchar2(500),
	subject varchar2(1000),
	content varchar2(3000),
	regdate timestamp DEFAULT sysdate
);

SELECT * FROM miniBoard ORDER BY idx DESC;
/* 댓글 */
CREATE SEQUENCE boardComment_idx_seq;
CREATE TABLE boardComment(
	idx NUMBER PRIMARY KEY,
	idx_ref NUMBER REFERENCES miniboard(idx) ON DELETE CASCADE,
	userid varchar2(100),
	password varchar2(200),
	content varchar2(2000),
	regdate timestamp DEFAULT sysdate
);

/* 한줄평 */
CREATE SEQUENCE simpleComment_idx_seq;
CREATE TABLE simpleComment(
	idx NUMBER PRIMARY KEY,
	userid varchar2(100) REFERENCES MEMBER(userid),
	commentid varchar2(100),
	password varchar2(200),
	content varchar2(2000),
	regdate timestamp DEFAULT sysdate
);

SELECT * FROM simpleComment;

CREATE SEQUENCE upfile_idx_seq;
CREATE TABLE miniUpfile(
	idx NUMBER PRIMARY KEY,
	idx_ref NUMBER REFERENCES miniboard(idx) ON DELETE CASCADE,
	ofile varchar2(1000),
	sfile varchar2(1000)
);

package kr.human.board.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
/*
CREATE TABLE miniBoard(
	idx NUMBER PRIMARY KEY,
	userid varchar(200) REFERENCES member(userid),
	category varchar2(100) NOT null,
	password varchar2(500),
	subject varchar2(1000),
	content varchar2(3000),
	regdate timestamp DEFAULT sysdate
)
 */
@Data
public class BoardVO {
	private int idx;
	private String category;
	private String userid;
	private String password;
	private String subject;
	private String content;
	private Date   regDate;
	
	private int mode;
	private List<UpfileVO> fileList;
	
	// 댓글의 정보를 저장할 변수 추가
	private int commentCount; // 목록보기에서는 갯수만 필요
	private List<BoardCommentVO> commentList; // 내용보기에서는 댓글들이 모두 필요
}

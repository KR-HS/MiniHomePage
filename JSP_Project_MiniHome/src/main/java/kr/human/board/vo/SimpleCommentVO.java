package kr.human.board.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
/*
CREATE TABLE miniComment(
	idx NUMBER PRIMARY KEY,
	idx_ref NUMBER REFERENCES miniboard(idx) ON DELETE CASCADE,
	userid varchar2(100),
	password varchar2(200),
	content varchar2(2000),
	regdate timestamp DEFAULT sysdate
)
 */
@Data
public class SimpleCommentVO {
	private int idx;
	private String userid;
	private String commentid;
	private String password;
	private String content;
	private Date   regDate;
	
	private String mode;
}

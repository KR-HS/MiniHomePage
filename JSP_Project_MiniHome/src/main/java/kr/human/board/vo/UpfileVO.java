package kr.human.board.vo;

import lombok.Data;

/*
CREATE TABLE upfile(
	idx NUMBER PRIMARY KEY,
	idx_ref NUMBER NOT NULL, -- 원본글번호
	ofile varchar2(100) NOT NULL, -- 원본 파일명
	sfile varchar2(100) NOT NULL  -- 저장 파일명(랜덤)
);
 */
@Data
public class UpfileVO {
	private int idx;
	private int idx_ref;
	private String ofile; 
	private String sfile;
}
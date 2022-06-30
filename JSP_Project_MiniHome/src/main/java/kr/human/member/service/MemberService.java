package kr.human.member.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import kr.human.board.vo.BoardCommentVO;
import kr.human.member.vo.MemberVO;

public interface MemberService {
	// 저장(회원가입)
	void insert(MemberVO memberVO, String urlAddress);
	// 수정(정보수정)
	void update(MemberVO memberVO, String newPassword, HttpSession httpSession);
	// 삭제(회원탈퇴)
	void delete(MemberVO memberVO, HttpSession httpSession);
	// 목록보기(관리자) // 이름 검색(친구 찾기 리스트)
	List<MemberVO> selectList(String name,HttpSession httpSession);
	
	// 친구찾기(miniHome에 접속할때 정보 세션에 저장)
	MemberVO searchUser(String userid);
	
	// 아이디 찾기
	MemberVO searchUserid(String name, String phone);
	
	// 비번 찾기
	MemberVO searchPassword(String userid, String phone); 
	// 로그인
	boolean login(String userid, String password, HttpSession httpSession);
	// 로그아웃	
	void logout();
	// 인증하기
	boolean emailConfirm(String userid);
	// 아이디 중복확인
	int idCheck(String userid);
	// 자기소개 수정
	void updateIntroduce(MemberVO memberVO, String newIntroduce,HttpSession httpSession);
	
	// 한줄평 저장
	void commentInsert(BoardCommentVO vo);
	// 한줄평 수정
	void commentUpdate(BoardCommentVO vo);
	// 한줄평 삭제
	void commentDelete(BoardCommentVO vo);
}

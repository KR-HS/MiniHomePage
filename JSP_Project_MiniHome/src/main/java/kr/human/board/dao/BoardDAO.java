package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.BoardVO;

public interface BoardDAO {
	// 게시글 개수 세기
	int selectCount(SqlSession sqlSession,String userid) throws SQLException;
	// 카테고리별 게시글 개수 세기
	int selectCountByCategory(SqlSession sqlSession,HashMap<String,String> map) throws SQLException;
	// 게시글 1개 얻기
	BoardVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException;
	// 카테고리별 1개 얻기(음악, 프로필, 사진)
	BoardVO selectByCategory(SqlSession sqlSession, HashMap<String,String> map) throws SQLException;
	// 게시글 리스트 얻기
	List<BoardVO> selectList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException;
	// 최근글 리스트 얻기
	List<BoardVO> selectRecentList(SqlSession sqlSession, HashMap<String, String> map) throws SQLException;
	// 자유게시판 게시물 리스트 얻기
	public List<BoardVO> selectFList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException;
	// 갤러리 게시물 리스트 얻기
	public List<BoardVO> selectGList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException;
	// 게시글 저장
	void insert(SqlSession sqlSession, BoardVO fileBoardVO) throws SQLException;
	// 게시글 수정
	void update(SqlSession sqlSession, BoardVO fileBoardVO) throws SQLException;
	// 게시글 삭제
	void delete(SqlSession sqlSession, int idx) throws SQLException;
	// 최신글 idx얻기
	int selectMaxIdx(SqlSession sqlSession) throws SQLException;
}

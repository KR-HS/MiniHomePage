package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.BoardCommentVO;

public interface BoardCommentDAO {
		// 특정 게시물의 댓글의 개수 구하기
		int selectCount(SqlSession sqlSession,int idx_ref) throws SQLException;
		//특정 게시물의 댓글 리스트 구하기
		List<BoardCommentVO> selectList(SqlSession sqlSession,HashMap<String,Integer> map) throws SQLException;
		// 1개얻기
		BoardCommentVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException;
		// 저장
		void insert(SqlSession sqlSession,BoardCommentVO vo) throws SQLException;
		// 수정
		void update(SqlSession sqlSession,BoardCommentVO vo) throws SQLException;
		// 삭제
		void delete(SqlSession sqlSession,int idx) throws SQLException;
		// 특정 게시물의 댓글 모두 지우기
		void deleteByRef(SqlSession sqlSession,int idx_ref) throws SQLException;
}

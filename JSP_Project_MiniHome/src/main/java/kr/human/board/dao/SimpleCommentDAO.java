package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.SimpleCommentVO;

public interface SimpleCommentDAO {
		// 해당 아이디의 한중평의 개수 구하기
		int selectCount(SqlSession sqlSession,String userid) throws SQLException;
		//해당 아이디의 한줄평 리스트 구하기
		List<SimpleCommentVO> selectList(SqlSession sqlSession,HashMap<String,String> map) throws SQLException;
		// 1개얻기
		SimpleCommentVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException;
		// 저장
		void insert(SqlSession sqlSession,SimpleCommentVO vo) throws SQLException;
		// 수정
		void update(SqlSession sqlSession,SimpleCommentVO vo) throws SQLException;
		// 삭제
		void delete(SqlSession sqlSession,int idx) throws SQLException;
		// 지정 아이디의 한줄평 모두 지우기
		void deleteByUserid(SqlSession sqlSession,String userid) throws SQLException;
}

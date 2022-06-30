package kr.human.board.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.UpfileVO;


public interface UpFileDAO {
	//특정 게시글 첨부파일 개수얻기
	int selectCountByRef(SqlSession sqlSession, int idx_ref) throws SQLException;
	//특정 게시글 첨부파일 리스트 얻기
	List<UpfileVO> selectListByRef(SqlSession sqlSession,int idx_ref) throws SQLException;
	// 첨부파일 추가
	void insert(SqlSession sqlSession,UpfileVO upFileVO) throws SQLException;
	// 첨부파일 삭제
	void delete(SqlSession sqlSession, int idx) throws SQLException;
	// 첨부파일 1개 얻기
	UpfileVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException;
}

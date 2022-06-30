package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.BoardCommentVO;

public class BoardCommentDAOImpl implements BoardCommentDAO {
	//-----------------------------------------
		// 싱글톤
		private static BoardCommentDAO instance=new BoardCommentDAOImpl();
		private BoardCommentDAOImpl() {}
		public static BoardCommentDAO getInstance() {return instance;}
	//-------------------------------------
		@Override
		public int selectCount(SqlSession sqlSession, int idx_ref) throws SQLException {
			return sqlSession.selectOne("boardComment.selectCount",idx_ref);
		}
		@Override
		public List<BoardCommentVO> selectList(SqlSession sqlSession, HashMap<String,Integer> map) throws SQLException {
			return sqlSession.selectList("boardComment.selectList",map);
		}
		@Override
		public BoardCommentVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException {
			return sqlSession.selectOne("boardComment.selectByIdx",idx);
		}
		@Override
		public void insert(SqlSession sqlSession, BoardCommentVO vo) throws SQLException {
			sqlSession.insert("boardComment.insert",vo);
		}
		@Override
		public void update(SqlSession sqlSession, BoardCommentVO vo) throws SQLException {
			sqlSession.update("boardComment.update",vo);
		}
		@Override
		public void delete(SqlSession sqlSession, int idx) throws SQLException {
			sqlSession.delete("boardComment.delete",idx);
		}
		@Override
		public void deleteByRef(SqlSession sqlSession, int idx_ref) throws SQLException {
			sqlSession.delete("boardComment.deleteByRef",idx_ref);
		}
		
}

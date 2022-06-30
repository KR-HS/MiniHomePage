package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.SimpleCommentVO;

public class SimpleCommentDAOImpl implements SimpleCommentDAO{
	//-----------------------------------------
	// 싱글톤
	private static SimpleCommentDAO instance=new SimpleCommentDAOImpl();
	private SimpleCommentDAOImpl() {}
	public static SimpleCommentDAO getInstance() {return instance;}
	//-------------------------------------
	@Override
	public int selectCount(SqlSession sqlSession, String userid) throws SQLException {
		return sqlSession.selectOne("simpleComment.selectCount",userid);
	}
	@Override
	public List<SimpleCommentVO> selectList(SqlSession sqlSession, HashMap<String,String> map) throws SQLException {
		return sqlSession.selectList("simpleComment.selectList",map);
	}
	@Override
	public SimpleCommentVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException {
		return sqlSession.selectOne("simpleComment.selectByIdx",idx);
	}
	@Override
	public void insert(SqlSession sqlSession, SimpleCommentVO vo) throws SQLException {
		sqlSession.insert("simpleComment.insert",vo);
	}
	@Override
	public void update(SqlSession sqlSession, SimpleCommentVO vo) throws SQLException {
		sqlSession.update("simpleComment.update",vo);
	}
	@Override
	public void delete(SqlSession sqlSession, int idx) throws SQLException {
		sqlSession.delete("simpleComment.delete",idx);
	}
	@Override
	public void deleteByUserid(SqlSession sqlSession, String userid) throws SQLException {
		sqlSession.delete("simpleComment.deleteByUserid",userid);
	}

}

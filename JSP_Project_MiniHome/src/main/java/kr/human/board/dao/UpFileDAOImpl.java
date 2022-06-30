package kr.human.board.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.UpfileVO;

public class UpFileDAOImpl implements UpFileDAO{
	private static UpFileDAO instance = new UpFileDAOImpl();
	private UpFileDAOImpl() {
		;
	}
	public static UpFileDAO getInstance() {
		return instance;
	}
	//----------------------------------------------------------
	@Override
	public int selectCountByRef(SqlSession sqlSession, int idx_ref) throws SQLException {
		return sqlSession.selectOne("upFile.selectCountByRef", idx_ref);
	}
	@Override
	public List<UpfileVO> selectListByRef(SqlSession sqlSession, int idx_ref) throws SQLException {
		return sqlSession.selectList("upFile.selectListByRef", idx_ref);
	}
	@Override
	public void insert(SqlSession sqlSession, UpfileVO upFileVO) throws SQLException {
		sqlSession.insert("upFile.insert", upFileVO);
	}
	@Override
	public void delete(SqlSession sqlSession, int idx) throws SQLException {
		sqlSession.delete("upFile.delete", idx);		
	}
	@Override
	public UpfileVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException {
		return sqlSession.selectOne("upFile.selectByIdx", idx);
	}
	
}

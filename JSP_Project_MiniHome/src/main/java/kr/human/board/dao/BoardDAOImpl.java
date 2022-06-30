package kr.human.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.vo.BoardVO;

public class BoardDAOImpl implements BoardDAO {
	private static BoardDAO instance = new BoardDAOImpl();
	private BoardDAOImpl() {}
	public static BoardDAO getInstance() {
		return instance;
	}
	//-----------------------------------------------------------------------
	@Override
	public int selectCount(SqlSession sqlSession,String userid) throws SQLException {
		return sqlSession.selectOne("board.selectCount",userid);
	}
	@Override
	public int selectCountByCategory(SqlSession sqlSession, HashMap<String,String> map) throws SQLException {
		return sqlSession.selectOne("board.selectCountByCategory",map);
	}
	@Override
	public BoardVO selectByIdx(SqlSession sqlSession, int idx) throws SQLException {
		return sqlSession.selectOne("board.selectByIdx", idx);
	}
	@Override
	public List<BoardVO> selectList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException {
		return sqlSession.selectList("board.selectList", map);
	}
	@Override
	public List<BoardVO> selectRecentList(SqlSession sqlSession, HashMap<String, String> map) throws SQLException {
		return sqlSession.selectList("board.selectRecentList", map);
	}
	@Override
	public List<BoardVO> selectFList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException {
		return sqlSession.selectList("board.selectFList", map);
	}
	@Override
	public List<BoardVO> selectGList(SqlSession sqlSession, HashMap<String, Integer> map) throws SQLException {
		return sqlSession.selectList("board.selectGList", map);
	}
	@Override
	public void insert(SqlSession sqlSession, BoardVO fileBoardVO) throws SQLException {
		sqlSession.insert("board.insert", fileBoardVO);
	}
	@Override
	public void update(SqlSession sqlSession, BoardVO fileBoardVO) throws SQLException {
		sqlSession.update("board.update", fileBoardVO);
	}
	@Override
	public void delete(SqlSession sqlSession, int idx) throws SQLException {
		sqlSession.delete("board.delete", idx);
	}
	@Override
	public int selectMaxIdx(SqlSession sqlSession) throws SQLException {
		return sqlSession.selectOne("board.selectMaxIdx");
	}
	@Override
	public BoardVO selectByCategory(SqlSession sqlSession, HashMap<String, String> map) throws SQLException {
		return sqlSession.selectOne("board.selectByCategory",map);
	}

}

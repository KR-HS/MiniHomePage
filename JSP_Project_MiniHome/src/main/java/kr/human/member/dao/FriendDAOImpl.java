package kr.human.member.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.member.vo.FriendVO;

public class FriendDAOImpl implements FriendDAO {
	private static FriendDAO instance = new FriendDAOImpl();
	private FriendDAOImpl() {}
	public static FriendDAO getInstance(){
		return instance;
	}
	//-------------------------------------------------------------------------------
	@Override
	public void insert(SqlSession sqlSession, HashMap<String,String> map) throws SQLException {
		sqlSession.insert("friend.insert",map);
	}
	@Override
	public void delete(SqlSession sqlSession, HashMap<String,String> map) throws SQLException {
		sqlSession.delete("friend.delete", map);
	}
	@Override
	public List<FriendVO> selectByUserid(SqlSession sqlSession, String userid) throws SQLException {
		return sqlSession.selectList("friend.selectByUserid",userid);
	}
	@Override
	public int selectByFriendid(SqlSession sqlSession, String friendid) throws SQLException {
		return sqlSession.selectOne("friend.selectByFriendid",friendid);
	}
	@Override
	public int countFriend(SqlSession sqlSession, HashMap<String, String> map) throws SQLException {
		return sqlSession.selectOne("friend.countFriend",map);
	}
	
}

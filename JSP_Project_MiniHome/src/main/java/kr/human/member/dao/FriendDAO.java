package kr.human.member.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.member.vo.FriendVO;

public interface FriendDAO {
	// 저장
	void insert(SqlSession sqlSession, HashMap<String,String> map) throws SQLException;
	// 삭제
	void delete(SqlSession sqlSession, HashMap<String,String> map) throws SQLException;
	
	List<FriendVO> selectByUserid(SqlSession sqlSession, String userid) throws SQLException;
	
	int selectByFriendid(SqlSession sqlSession,String friendid) throws SQLException;
	
	int countFriend(SqlSession sqlSession,HashMap<String,String> map) throws SQLException;
}

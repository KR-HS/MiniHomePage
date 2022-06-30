package kr.human.member.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.session.SqlSession;

import kr.human.member.dao.FriendDAO;
import kr.human.member.dao.FriendDAOImpl;
import kr.human.member.vo.FriendVO;
import kr.human.mybatis.MybatisApp;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FriendServiceImpl implements FriendService{
	private static FriendService instance = new FriendServiceImpl();
	private FriendServiceImpl() {}
	public static FriendService getInstance(){
		return instance;
	}
	//-------------------------------------------------------------------------------
	@Override
	public void insert(String userid,String friendid) {
		log.info("FrinedServiceImpl의 insert호출 : {}", userid+", "+friendid);
		
		SqlSession sqlSession = null;
		FriendDAO friendDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			friendDAO = FriendDAOImpl.getInstance();
			//------------------------------------------------------------------
			HashMap<String,String> map = new HashMap<>();
			map.put("userid", userid);
			map.put("friendid", friendid);
			
			friendDAO.insert(sqlSession,map);
			//------------------------------------------------------------------
			sqlSession.commit();
		}catch (SQLException e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			if(sqlSession!=null) sqlSession.close();
		}

		
	}
	
	@Override
	public void delete(String userid, String friendid) {
		log.info("FriendServiceImpl의 delete호출 : {}", friendid);
		
		SqlSession sqlSession = null;
		FriendDAO friendDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			friendDAO= FriendDAOImpl.getInstance();
			//------------------------------------------------------------------
			HashMap<String,String> map = new HashMap<>();
			// DB에 저장을 하고
			map.put("userid", userid);
			map.put("friendid", friendid);
			if(friendDAO.selectByFriendid(sqlSession, friendid)>0) {
				// 삭제 수행
				friendDAO.delete(sqlSession,map);
			}
			//------------------------------------------------------------------
			sqlSession.commit();
		}catch (SQLException e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			if(sqlSession!=null) sqlSession.close();
		}
		
	}
	@Override
	public List<FriendVO> FriendList(String userid) {
		log.info("FriendServiceImpl의 FriendList호출 : {}", userid);
		List<FriendVO> list=null;
		
		SqlSession sqlSession = null;
		FriendDAO friendDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			friendDAO = FriendDAOImpl.getInstance();
			//------------------------------------------------------------------
			// 해당 아이디의 회원 정보를 읽어온다
			list =friendDAO.selectByUserid(sqlSession, userid);
			//------------------------------------------------------------------
			sqlSession.commit();
		}catch (SQLException e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			if(sqlSession!=null) sqlSession.close();
		}	
		
		log.info("FriendServiceImpl의 FriendList리턴 : {}", list);
		return list;
	}
	@Override
	public boolean isExist(String userid, String friendid) {
		log.info("FriendServiceImpl의 isExistt호출 : {}", userid+", "+friendid);
		boolean isExist=false;
		
		int count=0;
		SqlSession sqlSession = null;
		FriendDAO friendDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			friendDAO = FriendDAOImpl.getInstance();
			//------------------------------------------------------------------
			// 해당 아이디의 회원 정보를 읽어온다
			HashMap<String,String> map = new HashMap<>();
			map.put("userid", userid);
			map.put("friendid", friendid);
			count =friendDAO.countFriend(sqlSession, map);
			if(count!=0) {
				isExist=true;
			}
			//------------------------------------------------------------------
			sqlSession.commit();
		}catch (SQLException e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			if(sqlSession!=null) sqlSession.close();
		}	
		
		log.info("FriendServiceImpl의 isExist리턴 : {}", isExist);
		
		return isExist;
	}
	
	

}

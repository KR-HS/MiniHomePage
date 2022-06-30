package kr.human.member.service;

import java.util.List;


import kr.human.member.vo.FriendVO;

public interface FriendService {
	// 저장(친구추가)
	void insert(String userid,String friendid);
	// 삭제(친구삭제)
	void delete(String userid,String friendid);
	// 조회(친구 리스트)
	List<FriendVO> FriendList(String userid);
	
	boolean isExist(String userid, String friendid);
}

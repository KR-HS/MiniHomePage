package kr.human.board.service;

import java.util.List;

import kr.human.board.vo.BoardCommentVO;
import kr.human.board.vo.BoardVO;
import kr.human.board.vo.PagingVO;
import kr.human.board.vo.SimpleCommentVO;

public interface BoardService {
	// 1. 목록보기
//	PagingVO<BoardVO> selectList(int currentPage, int pageSize, int blockSize,String userid);
	// 1.1 자유게시판 목록
	PagingVO<BoardVO> selectFList(int currentPage, int pageSize, int blockSize,String userid);
	// 1.2 갤러리 목록
	PagingVO<BoardVO> selectGList(int currentPage, int pageSize, int blockSize,String userid);
	// 1.3 최근글 목록
	List<BoardVO> selectRecentList(String userid);
	
	// 2. 내용보기
	BoardVO selectByIdx(int idx);
	// 2.1 카테고리별 읽어오기
	BoardVO selectByCateogry(String userid, String category);
	// 3. 저장하기
	void insert(BoardVO fileBoardVO);
	// 4. 수정하기
	void update(BoardVO fileBoardVO, String path, String[] delfile);
	// 5. 삭제하기
	void delete(BoardVO fileBoardVO, String path);
	
	//댓글 리스트 가져오기
	PagingVO<BoardCommentVO> selectBoardCommentList(int currentPage,int pageSize,int blockSize,int idx_ref);
	// 댓글 저장
	void boardCommentInsert(BoardCommentVO vo);
	// 댓글 수정
	void boardCommentUpdate(BoardCommentVO vo);
	// 댓글 삭제
	void boardCommentDelete(BoardCommentVO vo);
	
	// 한줄평 목록 가져오기
	PagingVO<SimpleCommentVO> selectSimpleCommentList(int currentPage, int pageSize, int blockSize,String userid);
	// 한줄평 저장
	void simpleCommentInsert(SimpleCommentVO vo);
	// 한줄평 수정
	void simpleCommentUpdate(SimpleCommentVO vo);
	// 한줄평 삭제
	void simpleCommentDelete(SimpleCommentVO vo);
}

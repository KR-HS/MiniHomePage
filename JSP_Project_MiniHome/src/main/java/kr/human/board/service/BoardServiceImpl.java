package kr.human.board.service;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.board.dao.BoardCommentDAO;
import kr.human.board.dao.BoardCommentDAOImpl;
import kr.human.board.dao.BoardDAO;
import kr.human.board.dao.BoardDAOImpl;
import kr.human.board.dao.SimpleCommentDAO;
import kr.human.board.dao.SimpleCommentDAOImpl;
import kr.human.board.dao.UpFileDAO;
import kr.human.board.dao.UpFileDAOImpl;
import kr.human.board.vo.BoardCommentVO;
import kr.human.board.vo.BoardVO;
import kr.human.board.vo.PagingVO;
import kr.human.board.vo.SimpleCommentVO;
import kr.human.board.vo.UpfileVO;
import kr.human.mybatis.MybatisApp;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BoardServiceImpl implements BoardService {
	private static BoardService instance = new BoardServiceImpl();
	private BoardServiceImpl() {}
	public static BoardService getInstance() {
		return instance;
	}
	//----------------------------------------------------------------------
//	@Override
//	public PagingVO<BoardVO> selectList(int currentPage, int pageSize, int blockSize,String userid) {
//		log.info("BoardServiceImpl selectList 호출 : " + currentPage + ", " + pageSize + ", " + blockSize);
//		PagingVO<BoardVO> pagingVO = null;
//		SqlSession sqlSession = null;
//		BoardDAO BoardDAO = null;
//		UpFileDAO upFileDAO = null;
//		try {
//			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
//			BoardDAO = BoardDAOImpl.getInstance();
//			upFileDAO = UpFileDAOImpl.getInstance();
//			//--------------------------------------------------------------------
//			// 1. 전체 개수를 구한다.
//			int totalCount = BoardDAO.selectCount(sqlSession,userid);
//			
//			// 2. 페이지를 계산한다.
//			pagingVO = new PagingVO<BoardVO>(totalCount, currentPage, pageSize, blockSize);
//			log.info("페이지 계산 : "+pagingVO);
//			// 3. 글목록을 가져온다.
//			HashMap<String, Integer> map = new HashMap<>();
//			map.put("startNo", pagingVO.getStartNo());
//			map.put("endNo", pagingVO.getEndNo());
//			List<BoardVO> list = BoardDAO.selectList(sqlSession, map);
//			// 4. 각각의 글에 대하여 첨부파일 정보를 얻어서 넣자!!!
//			if(list!=null) {
//				for(BoardVO vo : list) {
//					List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, vo.getIdx());
//					vo.setFileList(fileList);
//				}
//			}
//			// 5. 글의 목록을 pageingVO에 넣어준다.
//			pagingVO.setList(list);
//			//--------------------------------------------------------------------
//			sqlSession.commit();
//			log.info("BoardServiceImpl selectList 커밋");
//		}catch (Exception e) {
//			sqlSession.rollback();
//			e.printStackTrace();
//		}finally {
//			sqlSession.close();
//		}
//		return pagingVO;
//	}
	@Override
	public PagingVO<BoardVO> selectFList(int currentPage, int pageSize, int blockSize,String userid) {
		log.info("BoardServiceImpl selectFList 호출 : " + currentPage + ", " + pageSize + ", " + blockSize+", "+userid);
		PagingVO<BoardVO> pagingVO = null;
		SqlSession sqlSession = null;
		BoardDAO BoardDAO = null;
		UpFileDAO upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			BoardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 전체 개수를 구한다.
			HashMap<String,String> hashmap=new HashMap<>();
			hashmap.put("userid", userid);
			hashmap.put("category", "Free");
			int totalCount = BoardDAO.selectCountByCategory(sqlSession,hashmap);
			log.info("BoardServiceImpl 자유게시판 글개수  : " + totalCount);
			
			// 2. 페이지를 계산한다.
			pagingVO = new PagingVO<BoardVO>(totalCount, currentPage, pageSize, blockSize);
			log.info("페이지 계산 : "+pagingVO);
			// 3. 글목록을 가져온다.
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<BoardVO> list = BoardDAO.selectFList(sqlSession, map);
			log.info("BoardDAO selectFList 호출 : " +list.size()+", "+pagingVO.getStartNo()+", "+pagingVO.getEndNo());
			// 4. 각각의 글에 대하여 첨부파일 정보를 얻어서 넣자!!!
			if(list!=null) {
				for(BoardVO vo : list) {
					List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, vo.getIdx());
					vo.setFileList(fileList);
				}
			}
			// 5. 글의 목록을 pageingVO에 넣어준다.
			pagingVO.setList(list);
			//--------------------------------------------------------------------
			sqlSession.commit();
			log.info("BoardServiceImpl selectFList 커밋");
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return pagingVO;
	}
	@Override
	public PagingVO<BoardVO> selectGList(int currentPage, int pageSize, int blockSize,String userid) {
		log.info("BoardServiceImpl selectGList 호출 : " + currentPage + ", " + pageSize + ", " + blockSize+", "+userid);
		PagingVO<BoardVO> pagingVO = null;
		SqlSession sqlSession = null;
		BoardDAO BoardDAO = null;
		UpFileDAO upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			BoardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 전체 개수를 구한다.
			HashMap<String,String> hashmap=new HashMap<>();
			hashmap.put("userid", userid);
			hashmap.put("category", "Gallery");
			int totalCount = BoardDAO.selectCountByCategory(sqlSession,hashmap);
			log.info("BoardServiceImpl 갤러리 글개수  : " + totalCount);
			
			// 2. 페이지를 계산한다.
			pagingVO = new PagingVO<BoardVO>(totalCount, currentPage, pageSize, blockSize);
			log.info("페이지 계산 : "+pagingVO);
			// 3. 글목록을 가져온다.
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<BoardVO> list = BoardDAO.selectGList(sqlSession, map);
			log.info("BoardDAO selectGList 호출 : " +list.size());
			// 4. 각각의 글에 대하여 첨부파일 정보를 얻어서 넣자!!!
			if(list!=null) {
				for(BoardVO vo : list) {
					List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, vo.getIdx());
					vo.setFileList(fileList);
				}
			}
			// 5. 글의 목록을 pageingVO에 넣어준다.
			pagingVO.setList(list);
			//--------------------------------------------------------------------
			sqlSession.commit();
			log.info("BoardServiceImpl selectGList 커밋");
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return pagingVO;
	}
	@Override
	public List<BoardVO> selectRecentList(String userid) {
		log.info("BoardServiceImpl selectRecentList 호출 : " +userid);
		SqlSession sqlSession = null;
		BoardDAO BoardDAO = null;
		List<BoardVO> list = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			BoardDAO = BoardDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 3. 글목록을 가져온다.
			HashMap<String, String> map = new HashMap<>();
			map.put("startNo", 1+"");
			map.put("endNo", 4+"");
			map.put("userid", userid);
			list = BoardDAO.selectRecentList(sqlSession, map);
			log.info("BoardDAO selectRecentList 호출 : " +list.size());
			
			// 5. 글의 목록을 pageingVO에 넣어준다.
			//--------------------------------------------------------------------
			sqlSession.commit();
			log.info("BoardServiceImpl selectRecentList 커밋 : "+list);
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
	@Override
	public BoardVO selectByIdx(int idx) {
		log.info("BoardServiceImpl selectByIdx 호출 : " + idx);
		BoardVO boardVO= null;
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardDAO boardDAO = null;
		UpFileDAO    upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			boardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 해당 글번호의 글을 가져온다.
			boardVO = boardDAO.selectByIdx(sqlSession, idx);
			// 2. 해당글이 존재하면 첨부파일의 정보를 가져온다.
			if(boardVO!=null) {
				List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, idx);
				boardVO.setFileList(fileList);
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		//----------------------------------------------------------------------------------
		log.info("BoardServiceImpl selectByIdx 리턴 : " + boardVO);
		return boardVO;
	}
	@Override
	public void insert(BoardVO boardVO) {
		log.info("BoardServiceImpl insert 호출 : " + boardVO);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardDAO boardDAO = null;
		UpFileDAO upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			boardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 원본글이 존재하면
			if(boardVO!=null) {
				// 2. 원본글을 저장한다.
				boardDAO.insert(sqlSession, boardVO);
				
				// 3. 첨부파일을 저장한다.
				if(boardVO.getFileList()!=null) { // 첨부파일이 있다면
					int idx_ref = boardDAO.selectMaxIdx(sqlSession); // 지금 저장한 글의 idx를 읽는다.
					for(UpfileVO vo : boardVO.getFileList()) {
						vo.setIdx_ref(idx_ref); // 원본글의 글번호를 넣는다.
						upFileDAO.insert(sqlSession, vo);
					}
				}
			}
			
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl insert 끝 : " + boardVO);
			sqlSession.close();
		}
		//----------------------------------------------------------------------------------
	}
	@Override
	public void update(BoardVO boardVO, String path, String[] delfile) {
		log.info("BoardServiceImpl update 호출 : " + boardVO + ", " + path + ", " + Arrays.toString(delfile));
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardDAO fileBoardDAO = null;
		UpFileDAO    upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			fileBoardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 원본글이 존재하면
			if(boardVO!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				BoardVO dbVO = fileBoardDAO.selectByIdx(sqlSession, boardVO.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(boardVO.getPassword())){
					// 원본글 수정
					fileBoardDAO.update(sqlSession, boardVO);
					// 원본글에 추가로 파일이 첨부가 되었다면 파일을 저장한다.
					if(boardVO.getFileList()!=null) { // 첨부파일이 있다면
						int idx_ref = boardVO.getIdx();
						for(UpfileVO vo : boardVO.getFileList()) {
							vo.setIdx_ref(idx_ref); // 원본글의 글번호를 넣는다.
							upFileDAO.insert(sqlSession, vo);
						}
					}
					// 4. 기존파일에 삭제를 선택했다면 기존에 업로드된 파일을 DB와 저장된 파일 자체를 지워준다.
					if(delfile!=null) {
						for(String idx : delfile) {
							try {
								// DB에서 1개를 가져온다.
								UpfileVO dbFileVO = upFileDAO.selectByIdx(sqlSession, Integer.parseInt(idx));
								if(dbFileVO!=null) {
									// DB에서 첨부파일 삭제
									upFileDAO.delete(sqlSession, Integer.parseInt(idx));
									// 서버에서 파일을 삭제
									File file = new File(path + File.separator + dbFileVO.getSfile());
									file.delete();
								}
								
							}catch (Exception e) {
								;
							}
						}
					}
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		//----------------------------------------------------------------------------------			
	}
	@Override
	public void delete(BoardVO boardVO, String path) {
		log.info("BoardServiceImpl delete 호출 : " + boardVO + ", " + path);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardDAO fileBoardDAO = null;
		UpFileDAO    upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			fileBoardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 원본글이 존재하면
			if(boardVO!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				BoardVO dbVO = fileBoardDAO.selectByIdx(sqlSession, boardVO.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(boardVO.getPassword())){
					
					// 원본글 삭제
					fileBoardDAO.delete(sqlSession, boardVO.getIdx());
					
					// 원본글의 첨부파일 목록을 가져온다.
					List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, boardVO.getIdx());
					// 첨부파일도 삭제해야 한다.
					if(fileList!=null) {
						for(UpfileVO upFileVO : fileList) {
							// DB의 첨부 삭제
							upFileDAO.delete(sqlSession, upFileVO.getIdx());
							// 서버에 저장된 파일 삭제
							File file = new File(path + File.separator + upFileVO.getSfile());
							file.delete();
						}
					}
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		//----------------------------------------------------------------------------------		
	}
	
	@Override
	public PagingVO<BoardCommentVO> selectBoardCommentList(int currentPage, int pageSize, int blockSize,int idx_ref) {
		log.info("BoardServiceImpl selectBoardCommentList 호출 : " + currentPage + ", " + pageSize + ", " + blockSize+", "+idx_ref);
		PagingVO<BoardCommentVO> pagingVO = null;
		SqlSession sqlSession = null;
		BoardCommentDAO commentDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = BoardCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 전체 개수를 구한다.

			int totalCount = commentDAO.selectCount(sqlSession,idx_ref);
			log.info("댓글 개수  : " + totalCount);
			
			// 2. 페이지를 계산한다.
			pagingVO = new PagingVO<BoardCommentVO>(totalCount, currentPage, pageSize, blockSize);
			log.info("페이지 계산 : "+pagingVO);
			// 3. 글목록을 가져온다.
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			map.put("idx_ref", idx_ref);
			List<BoardCommentVO> list = commentDAO.selectList(sqlSession, map);
			log.info("BoardCommentDAO selectList 호출 : " +list.size());
			// 5. 글의 목록을 pageingVO에 넣어준다.
			pagingVO.setList(list);
			//--------------------------------------------------------------------
			sqlSession.commit();
			log.info("BoardServiceImpl selectBoardCommentList 커밋");
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return pagingVO;
	}
	
	@Override
	public void boardCommentInsert(BoardCommentVO vo) {
		log.info("BoardServiceImpl boardCommentInsert 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = BoardCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				commentDAO.insert(sqlSession, vo);	
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl boardCommentInsert 끝 : " + vo);
			sqlSession.close();
		}
	}
	@Override
	public void boardCommentUpdate(BoardCommentVO vo) {
		log.info("BoardServiceImpl boardCommentUpdate 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = BoardCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				BoardCommentVO dbVO = commentDAO.selectByIdx(sqlSession, vo.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(vo.getPassword())){
					// 원본글 수정
					commentDAO.update(sqlSession, vo);
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl boardCommentUpdate 끝 : " + vo);
			sqlSession.close();
		}
		
	}
	@Override
	public void boardCommentDelete(BoardCommentVO vo) {
		log.info("BoardServiceImpl boardCommentDelete 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = BoardCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				BoardCommentVO dbVO = commentDAO.selectByIdx(sqlSession, vo.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(vo.getPassword())){
					// 원본글 삭제
					commentDAO.delete(sqlSession, vo.getIdx());
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl boardCommentDelete 끝 : " + vo);
			sqlSession.close();
		}
		
	}
	@Override
	public PagingVO<SimpleCommentVO> selectSimpleCommentList(int currentPage, int pageSize, int blockSize, String userid) {
		log.info("BoardServiceImpl selectSimpleCommentList 호출 : " + currentPage + ", " + pageSize + ", " + blockSize+", "+userid);
		PagingVO<SimpleCommentVO> pagingVO = null;
		SqlSession sqlSession = null;
		SimpleCommentDAO commentDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = SimpleCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			// 1. 전체 개수를 구한다.

			int totalCount = commentDAO.selectCount(sqlSession,userid);
			log.info("댓글 개수  : " + totalCount);
			
			// 2. 페이지를 계산한다.
			pagingVO = new PagingVO<SimpleCommentVO>(totalCount, currentPage, pageSize, blockSize);
			log.info("페이지 계산 : "+pagingVO);
			// 3. 글목록을 가져온다.
			HashMap<String,String> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("userid", userid);
			List<SimpleCommentVO> list = commentDAO.selectList(sqlSession, map);
			log.info("BoardDAO selectSimpleCommentList 호출 : " +list.size());
			// 5. 글의 목록을 pageingVO에 넣어준다.
			pagingVO.setList(list);
			//--------------------------------------------------------------------
			sqlSession.commit();
			log.info("BoardServiceImpl selectSimpleCommentList 커밋");
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return pagingVO;
	}
	
	@Override
	public void simpleCommentInsert(SimpleCommentVO vo) {
		log.info("BoardServiceImpl simpleCommentInsert 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		SimpleCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = SimpleCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				commentDAO.insert(sqlSession, vo);	
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl simpleCommentInsert 끝 : " + vo);
			sqlSession.close();
		}
		
	}
	
	@Override
	public void simpleCommentUpdate(SimpleCommentVO vo) {
		log.info("BoardServiceImpl simpleCommentUpdate 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		SimpleCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = SimpleCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				SimpleCommentVO dbVO = commentDAO.selectByIdx(sqlSession, vo.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(vo.getPassword())){
					// 원본글 수정
					commentDAO.update(sqlSession, vo);
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl simpleCommentUpdate 끝 : " + vo);
			sqlSession.close();
		}
		
	}
	
	@Override
	public void simpleCommentDelete(SimpleCommentVO vo) {
		log.info("BoardServiceImpl simpleCommentDelete 호출 : " + vo);
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		SimpleCommentDAO commentDAO = null; 
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			commentDAO = SimpleCommentDAOImpl.getInstance();
			//--------------------------------------------------------------------
			if(vo!=null) {
				// 2. DB에서 해당 글번호의 글을 읽어온다.
				SimpleCommentVO dbVO = commentDAO.selectByIdx(sqlSession, vo.getIdx());
				// 3. DB에 글이 있으면서 비번이 일치할때만 수정을 수행한다.
				if(dbVO!=null && dbVO.getPassword().equals(vo.getPassword())){
					// 원본글 삭제
					commentDAO.delete(sqlSession, vo.getIdx());
				}
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			log.info("BoardServiceImpl simpleCommentDelete 끝 : " + vo);
			sqlSession.close();
		}
		
	}
	@Override
	public BoardVO selectByCateogry(String userid, String category) {
		log.info("BoardServiceImpl selectByCategory 호출 : " + userid+", "+category);
		BoardVO boardVO= null;
		//------------------------------------------------------------
		SqlSession sqlSession = null;
		BoardDAO boardDAO = null;
		UpFileDAO upFileDAO = null;
		try {
			sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
			boardDAO = BoardDAOImpl.getInstance();
			upFileDAO = UpFileDAOImpl.getInstance();
			//--------------------------------------------------------------------
			HashMap<String, String> map= new HashMap<>();
			map.put("userid", userid);
			map.put("category", category);
			
			// 1. 해당 글번호의 글을 가져온다.
			boardVO = boardDAO.selectByCategory(sqlSession, map);
			// 2. 해당글이 존재하면 첨부파일의 정보를 가져온다.
			if(boardVO!=null) {
				List<UpfileVO> fileList = upFileDAO.selectListByRef(sqlSession, boardVO.getIdx());
				boardVO.setFileList(fileList);
			}
			//--------------------------------------------------------------------
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		//----------------------------------------------------------------------------------
		log.info("BoardServiceImpl selectByCategory 리턴 : " + boardVO);
		return boardVO;
	}
}

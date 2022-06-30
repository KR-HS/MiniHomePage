<%@page import="kr.human.board.service.BoardServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="board/board_include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="vo" class="kr.human.board.vo.BoardCommentVO"/>
	<jsp:setProperty property="*" name="vo"/>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		switch(vo.getMode()){
		case "insert":
			BoardServiceImpl.getInstance().boardCommentInsert(vo);	
			break;
		case "update":
			BoardServiceImpl.getInstance().boardCommentUpdate(vo);	
			break;
		case "delete":
			BoardServiceImpl.getInstance().boardCommentDelete(vo);
			break;
		}
		String category=request.getParameter("category");
		if(category.equals("Free")){
			response.sendRedirect("miniBoard_view.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize + "&idx=" + vo.getIdx_ref());
		}
		if(category.equals("Gallery")){
			response.sendRedirect("miniGallery_view.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize + "&idx=" + vo.getIdx_ref());
		}
	%>
</body>
</html>
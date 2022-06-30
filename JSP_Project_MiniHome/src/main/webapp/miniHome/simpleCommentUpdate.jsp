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
	<jsp:useBean id="vo" class="kr.human.board.vo.SimpleCommentVO"/>
	<jsp:setProperty property="*" name="vo"/>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		switch(vo.getMode()){
		case "insert":
			BoardServiceImpl.getInstance().simpleCommentInsert(vo);	
			break;
		case "update":
			BoardServiceImpl.getInstance().simpleCommentUpdate(vo);	
			break;
		case "delete":
			BoardServiceImpl.getInstance().simpleCommentDelete(vo);
			break;
		}
			response.sendRedirect("miniHome.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize);
	%>
</body>
</html>
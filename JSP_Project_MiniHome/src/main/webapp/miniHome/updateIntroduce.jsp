<%@page import="kr.human.member.vo.MemberVO"%>
<%@page import="java.util.UUID"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="memberVO" class="kr.human.member.vo.MemberVO"/>
	<%
		memberVO=(MemberVO)session.getAttribute("memberVO");
		// 새로운 자기소개글을 받는다.
		String introduce = request.getParameter("introduce");
		
	%>
	<%
		// 서비스를 호출하여 수정을 하고
		MemberServiceImpl.getInstance().updateIntroduce(memberVO, introduce, session);
		// 어디론가 간다.
		response.sendRedirect("miniMypage.jsp");
	%>
</body>
</html>
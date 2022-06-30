<%@page import="com.ibatis.sqlmap.engine.scope.SessionScope"%>
<%@page import="kr.human.member.vo.MemberVO"%>
<%@page import="kr.human.member.service.FriendServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.member.vo.FriendVO"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(request.getMethod().equals("GET")){
			response.sendRedirect(request.getContextPath());
			return;
		}
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		if(userid!=null && password!=null){
			// 서비스를 호출하여 로그인 처리를 한다.
			boolean isLogin = MemberServiceImpl.getInstance().login(userid, password, session);
			if(isLogin){
				response.sendRedirect(request.getContextPath());
				List<FriendVO> friend = FriendServiceImpl.getInstance().FriendList(userid);
				return;
			}else{
				request.setAttribute("error", "잘못된 정보입니다.");
				pageContext.forward("login.jsp");
				
			}
		}else{
			request.setAttribute("error", "잘못된 정보입니다.");
			pageContext.forward("login.jsp");
			return;
		}
	%>
</body>
</html>
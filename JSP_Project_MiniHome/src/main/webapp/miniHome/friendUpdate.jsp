<%@page import="kr.human.member.service.FriendServiceImpl"%>
<%@page import="kr.human.member.vo.FriendVO"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.vo.MemberVO"%>
<%@page import="kr.human.board.service.BoardServiceImpl"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- 사용자 정의 자바스크립트 함수를 추가한다. --%>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/miniHome.js"></script>
</head>
<body>
	<%
		if(request.getMethod().equals("GET")){
			response.sendRedirect(request.getContextPath());
			return;
		}
	
		MemberVO memberVO=(MemberVO)session.getAttribute("memberVO");
		String userid=(String)session.getAttribute("userid");
		String m =request.getParameter("m");
		String query="";
		switch(m){
			case "0":
				if(!FriendServiceImpl.getInstance().isExist(memberVO.getUserid(), userid)){
					FriendServiceImpl.getInstance().insert(memberVO.getUserid(),userid);
				}
				query="<script>history.back();</script>";
				break;
			case "1":
				FriendServiceImpl.getInstance().delete(memberVO.getUserid(),userid);
				query="<script>history.back();</script>";
				break;
		}
		
		
		out.println(query); // 페이지 이동
	%>

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
<style type="text/css">
	body {
	background-color:white;
	display: flex;
  	justify-content: center;
  	align-items: center;
  	min-height: 100vh;
	}
	.container{
	display:flex;
	flex-direction:column;
	flex-wrap:nowrap;
	justify-content:center;
	align-items:center;
	height:300px;
	width:500px;
	background-color:white;
	border: 1px solid lightgray;
	padding: 15px;
	border-radius: 0px;
	transition:background,color 0.5s ease-in-out;
	}
	
	.HomeBack {
	background-color: black;
	color: white;
	width: 240px;
	height: 54px;
	margin-top: 20px;
	border: 1px solid darkgrey;
	border-radius: 5px;
	}
	
	.HomeBack:hover{
		background-color:white;
		color:black;
	}
	
</style>
</head>
<body>
	<jsp:useBean id="memberVO" class="kr.human.member.vo.MemberVO"/>
	<jsp:setProperty property="*" name="memberVO"/>
	<%
		// String 을 날짜 형식으로 변경하여 넣는다.
		String birth = request.getParameter("birth1");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		memberVO.setBirth(sdf.parse(birth));
	%>
	<%
		// 서비스를 호출하여 저장을 하고
		String urlAddress = "http://"+request.getServerName()+":" +
	            	request.getServerPort()+ request.getContextPath() + "/confirm.jsp?fdagd=" + UUID.randomUUID();
		MemberServiceImpl.getInstance().insert(memberVO, urlAddress);
		// 어디론가 간다.
		/*
		out.println(memberVO.getEmail() + "로 인증메일이 발송되었습니다. 인증을 진행하시고 로그인하시기 바랍니다.<br>");
		out.println("<a href='" + request.getContextPath() + "'>홈으로</a><br>" );
		
		out.println(request.getRequestURI() + "<br>" );
		out.println(request.getRequestURL() + "<br>" );
		out.println(request.getContextPath() + "<br>" );
		out.println(request.getServerName() + "<br>" );
		out.println("http://"+request.getServerName()+":" + 
		            request.getServerPort()+ request.getContextPath() + "/confirm.jsp<br>" );
		*/
	%>
	<div class="container">
		<h3 align="center">
			${memberVO.getEmail()}로 인증메일이 발송되었습니다.<br>인증을 진행하시고 로그인하시기 바랍니다.
		</h3>
		
		<div>
			<input class="HomeBack" type="button" value="홈으로" onclick="location.href='index.jsp'">
		</div>
	</div>
</body>
</html>
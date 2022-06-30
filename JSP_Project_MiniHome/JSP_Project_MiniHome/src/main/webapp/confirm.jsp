<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	
	body{
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
	}
	.button{
		margin-left:10px;
		margin-right:10px;
		background-color: black;
		color: white;
		width: 150px;
		height: 45px;
		margin-top: 20px;
		border: 1px solid darkgrey;
		border-radius: 5px;
		font-weight:bolder;
		transition:background,color 0.5s ease-in-out;
	}
	.home{
		margin-right:20px;
	}
	
	.login,.insert{
		background-color: white;
		color: black;
	}
	.button:hover{
		background-color:black;
		color:white;
	}
	.home:hover{
		background-color:white;
		color:black;
	}

</style>
</head>
<body>
<%
	// 사용자 아이디를 읽는다.
	String userid = request.getParameter("userid");
	// 서비스를 호출하여 해당 아이디의 use(인증), lev(권한)값을 변경해주고
	boolean isConfirm = false;
	if(userid!=null){
		isConfirm = MemberServiceImpl.getInstance().emailConfirm(userid);
	}
	
%>
<% if(isConfirm){ %>
	<div class="container">
		<h3 align="center">반갑습니다. <%=userid %>님 인증에 성공하셨습니다.
		<br>즐거운 시간되시기 바랍니다.</h3>
		<div style="display:flex">
		<input type="button" class="button home" value="홈으로" onclick="location.href='index.jsp'">
		<input type="button" class="button login" value="로그인" onclick="location.href='login.jsp'">
		</div>
		<!--  
		<a href="${pageContext.request.contextPath }">홈</a>
		<a href="${pageContext.request.contextPath }/login.jsp">로그인</a>
		-->
	</div>
<% }else{ %>
	<div class="container">
		<h3 align="center"><%=userid %>님 인증에 실패하셨습니다.</h3>
		<div style="display:flex">
		<input type="button" class="button home" value="홈으로" onclick="location.href='index.jsp'">
		<input type="button" class="button insert" value="회원가입" onclick="location.href='insertForm.jsp'">
		</div>
		<!-- 
		<a href="${pageContext.request.contextPath }">홈</a>
		<a href="${pageContext.request.contextPath }/insertForm.jsp">회원가입</a>
		-->
	</div>
<% } %>
</body>
</html>
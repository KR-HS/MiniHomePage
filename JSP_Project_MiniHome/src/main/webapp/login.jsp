<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인화면</title>

<!--글꼴-->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Jua&family=Noto+Sans+KR:wght@100;400&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Inconsolata:wght@300&family=Jua&family=Noto+Sans+KR:wght@100;400&display=swap"
	rel="stylesheet">
<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/login.css" />
</head>

<body>
	<!-- top Area -->
	<!-- <header class="header">
		logo(Button)
		<nav class="logoArea">
			<a href="index.jsp">626</a>
		</nav>
	</header>
 -->
 	<!-- header부분 -->
	<jsp:include page="include/mainHeader.jsp">
		<jsp:param name="memberVO" value="${sessionScope.memberVO }"/>
	</jsp:include>
	
	<!-- 로그인 부분 -->
	<section class="middle_login" >
	<div>
		<form id='login_form' action="${pageContext.request.contextPath }/loginOk.jsp" method="post" class="form-horizontal">
			
			<%-- 로그아웃시 메세지 출력 --%>
			<c:if test="${not empty msg }">
				<div style="color: green;font-size: 15pt;">${msg }</div>
			</c:if>
						
			<div class="loginfont">로그인</div>

			<div class="idfont">아이디</div>
			<!-- 아이디 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="username" type="text" class="form-control"
					name="userid" placeholder="아이디를 입력하세요" required>
			</div>
			<div class="pwfont">비밀번호</div>
			<!-- 비밀번호 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="password" type="password" class="form-control"
					name="password" placeholder="비밀번호를 입력하세요" required>
			</div>
			<%-- 로그인 실패시 에러메세지 출력 --%>
			<c:if test="${not empty error }">
				<div style="margin-bottom:10px;	color: red;	font-size: 10pt; text-align:left">${error }</div>
			</c:if>


			<div>
				<table class="find">
					<tr>
					<td><a class='link' href="findUserid.jsp" >아이디 찾기</a></td>
					<td style="color:lightgray"> | </td>
					<td><a class='link' href="findPassword.jsp" >비밀번호 찾기</a></td>
					</tr>
				</table>
				<input class="loginbutton" type="submit" value="로그인하기"><br>
				<input class="join" type="button" value="회원가입" onclick="location.href='insertForm.jsp'">
			</div>

		</form>
	</div>
	</section>
</body>
</html>
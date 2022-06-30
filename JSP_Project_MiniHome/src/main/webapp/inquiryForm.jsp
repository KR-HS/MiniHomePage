<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>

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
	href="${pageContext.request.contextPath }/css/deleteForm.css" />
</head>

<body>
	<!-- top Area -->
	<header class="header">
		<!--logo(Button)-->
		<nav class="logoArea">
			<a href="login.jsp">626</a>
		</nav>
	</header>

	<section class="middle_login">

		<form id='login_form'
			action="${pageContext.request.contextPath }/deleteOk.jsp"
			method="post" class="form-horizontal">
			<%-- 로그인 실패시 에러메세지 출력 --%>
			<c:if test="${not empty error }">
				<div style="color: red; font-size: 15pt;">${error }</div>
			</c:if>
			<div class="loginfont">문의하기</div>

			<div class="idfont">아이디</div>
			<!-- 아이디 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="username" type="text" class="form-control" name="userid"
					placeholder="아이디를 입력하세요" required>
			</div>

			<div class="input-group">
				<textarea name="title" id="title" cols="100" rows="1" required
					placeholder="  제목" style="vertical-align: middle; margin: 5px auto"></textarea>
			</div>
			<div class="input-group">
				<textarea name="content" id="content" cols="100" rows="8" required
					placeholder="  내용" style="vertical-align: middle; margin: 5px auto"></textarea>
			</div>
			<input type="submit" class="loginbutton" value="문의하기">


		</form>

	</section>

</body>
</html>
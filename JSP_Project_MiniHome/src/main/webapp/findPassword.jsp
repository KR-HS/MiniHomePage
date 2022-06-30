<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>

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
	href="${pageContext.request.contextPath }/css/find.css" />

</head>

<body>
	<!-- top Area -->
	<jsp:include page="include/mainHeader.jsp"/>

	<!-- 로그인 부분 -->
	<section class="middle_login" >
	<div id="login_box">
		<form id='login_form' action="${pageContext.request.contextPath }/findPasswordOk.jsp" method="post" class="form-horizontal">
						
			<div class="loginfont">비밀번호 찾기</div>

			<div class="idfont">아이디</div>
			<!-- 아이디 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="username" type="text" class="form-control"
					name="userid" placeholder="사용자 이름 입력" required>
			</div>

			<div class="pwfont">전화번호</div>
			<!--전화번호 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="password" type="text" class="form-control"
					name="phone" placeholder="전화 번호 입력(ex. 010-000-0000)" required>
			</div>

			<%-- 로그인 실패시 에러메세지 출력 --%>
			<c:if test="${not empty error }">
				<div style="padding-left: 28px; margin-bottom:10px;	color: red;	font-size: 10pt; text-align:left">${error }</div>
			</c:if>
			
			<div id="login_bottom_box">

				<input class="loginbutton" type="submit" value="비밀번호 찾기"><br>
				<a href="${pageContext.request.contextPath}/login.jsp"><input class="join" type="button" value="로그인하기"></a>

			</div>

		</form>
	</div>
	</section>
</body>
</html>
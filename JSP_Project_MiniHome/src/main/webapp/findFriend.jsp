<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%session.removeAttribute("userid"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사용자 검색</title>

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
<style type="text/css">
.header{
    width:100%;
    height:100px;
    display:flex;
    position:relative;
}

/* 로고(Logo) */
.logoArea{
    top:23px;
    height:100px;
    width:100px;
    left: 50px;
    position: absolute;
}

.logoArea a{
    font-weight:border;
    font-size:40px;
    color:black;
    font-family: 'Abril Fatface', cursive;
    text-decoration : none;
}

/* 배너부분 회원정보*/
.index_form {
	position: absolute;
	margin-top:30px;
	right: 3%;
    width: 200px;
    height: 100px;
}

.indexfont {
	font-size: 13px;
	font-weight: bold;
}
</style>
</head>

<body>
	<!-- top Area -->
	<jsp:include page="include/mainHeader.jsp"/>

	<!-- 찾기 부분 -->
	<section class="middle_login" >
	<div id="login_box">
		<form id='login_form' action="findFriendOk.jsp" method="post" class="form-horizontal">
						
			<div class="loginfont">사용자 검색</div>

			<div class="idfont">친구 찾기</div>
			<!-- 아이디 데이터를 받아오는 input -->
			<div class="idpw">
				<input id="username" type="text" class="form-control"
					name="name" placeholder="사용자 이름 입력" required>
			</div>

			<%-- 로그인 실패시 에러메세지 출력 --%>
			<c:if test="${not empty error }">
				<div style="margin:0 0 10px 25px;	color: red;	font-size: 10pt; text-align:left">${error }</div>
			</c:if>
			<div id="login_bottom_box">
				<input class="loginbutton" type="submit" value="친구찾기"><br>
			</div>

		</form>
	</div>
	</section>
</body>
</html>
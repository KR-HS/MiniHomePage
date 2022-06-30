<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	session.removeAttribute("userid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Index</title>

<!-- 아이콘 -->
<!-- font-awesome5 -->
	<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
  <!-- font-awesome4 -->
   <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
  />	
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
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@900&display=swap" rel="stylesheet">
<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/index.css" />
<script type="text/javascript">

</script>
</head>
<body>
	<!-- header부분 -->
	<jsp:include page="include/mainHeader.jsp">
		<jsp:param name="userVO" value="${sessionScope.memberVO }"/>
	</jsp:include>
	
	<main class="main">
		<div class="main_wrapper">
			<div style="margin-top:50px;">
				<h1 align="center">MiniHome</h1>
				<p align="center">나만의 작은 홈페이지, 지금 만나보세요!</p>
				<div class="icons_wrapper">						
						<div class="icon_wrapper">
							<a href="#" 
								onclick="window.open('findFriend.jsp', '친구찾기','width=950, height=600, left=400, top=150,scrollbars= 0, toolbar=0, menubar=yes')"
							class="icon fa fa-search fa-2x" target="_blank"></a>
						</div>
						
						<div class="icon_wrapper" >
							<a href="https://www.facebook.com" class="icon fa fa-facebook-official fa-2x" target="_blank"></a>
						</div>
						
						<div class="icon_wrapper">
							<a href="https://www.twitter.com" class="icon fa fa-twitter fa-2x" target="_blank"></a>
						</div>
						
						<div class="icon_wrapper">
							<a href="https://www.instagram.com" class="icon fa fa-instagram fa-2x" target="_blank"></a>
						</div>
						
						<div class="icon_wrapper">
							<a href="inquiryForm.jsp" class="icon fa fa-envelope fa-2x" target="_blank"></a>
						</div>
						
				</div>

				<div style="text-align:center;padding:20px;">
					<c:if test="${empty sessionScope.memberVO }">
						<input class="start" type="button" value="로그인하기" onclick="location.href='login.jsp'">
					</c:if>
					
					<c:if test="${not empty sessionScope.memberVO }">
						<input class="start" type="button" value="시작하기" onclick="window.open('miniHome/miniHome.jsp?userid=${sessionScope.memberVO.getUserid()}', '나만의 미니홈페이지','width=950, height=600, left=400, top=150,scrollbars= 0, toolbar=0, menubar=yes')">
					</c:if>
				</div>
			</div>
		</div>
	</main>
	<!-- footer 부분 -->
	<jsp:include page="include/mainFooter.jsp"/>
</body>
</html>
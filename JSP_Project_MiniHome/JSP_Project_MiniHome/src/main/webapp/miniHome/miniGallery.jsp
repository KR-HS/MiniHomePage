<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome MiniHome</title>
<!-- font-awesome4 -->
   <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
  />
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />	
 <link rel="stylesheet" href="../css/miniGallery.css" />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dday").html(Dday()+"일");
		$("table th").eq(0).css("border-bottom", "1px dotted black")
		$("table th").eq(1).css("border-bottom", "1px dotted black")
		$("table th").eq(2).css("border-bottom", "1px dotted black")
		$("table th").eq(3).css("border-bottom", "1px dotted black")
	});
	
	function Dday(){
		var today = new Date();
		var dday ="<fmt:formatDate value='${sessionScope.memberVO.getBirth()}' pattern='yyyy/MM/dd'/>";
		var dday = new Date(dday);
		var gap = dday.getTime() -today.getTime();
		var result = Math.ceil(gap/(1000*60*60*24));
		result=result%365;
		if(result<0){
			result=365+result;
		}
		return result;

	}
</script>
<style type="text/css">
	table{
		border:1px solid gray;
	}
	table td{
		border:none;
	}
	
	table tr td{
		text-align:center;
	}
	.content_title{
		text-align:left;
	}
</style>
</head>
<body>
	<c:if test="${empty sessionScope.memberVO }">
		<% response.sendRedirect("../login.jsp");%>
	</c:if>

	<div class="background">
      <main>
        <jsp:include page="include/profile.jsp">
			<jsp:param name="memberVO" value="${sessionScope.memberVO }"/>
		</jsp:include>
        
        <section class="main-section">
          <div class="main-dot">
            <div class="main-paper">
              <div class="main-wrap">
           		<nav>
	               	<ul>
	                  	<li><a href="miniHome.jsp" onclick="callFunction()">홈</a></li>
						<li><a href="miniMypage.jsp" onclick="callFunction()">마이페이지</a></li>
						<li><a href="miniBoard.jsp" onclick="callFunction()">자유게시판</a></li>
						<li><a href="miniGallery.jsp" onclick="callFunction()">갤러리</a></li>
	               	</ul>
           		</nav>
                
                <div class="main">
                  <div class="post-wrap">
                    <div class="gallery">
                      <h2>갤러리</h2>
                      <div class="gallery-post-wrapper">
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<!--  -->
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<div class="gallery-post">
                      		<div class="gallery-post-content">
                   				<div class="gallery-post-pic"></div>
                   				<h5 align="center">제목입니다.</h5>
                   			</div>
                      	</div>
                      	
                      	<!--  -->
                      	
                      	
                      </div>
                    </div>
                  </div>
                </div>
                
              </div>
            </div>
          </div>
        </section>
      </main>
    </div>
</body>
</html>
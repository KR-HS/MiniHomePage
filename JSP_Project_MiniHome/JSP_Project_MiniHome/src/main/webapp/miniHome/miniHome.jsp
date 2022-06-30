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
 <link rel="stylesheet" href="../css/miniHome.css" />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dday").html(Dday()+"일");
		
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
                    <div class="recent-post">
                    <h2>최근 게시물</h2>
                      <p class="text-gallery">
                        <a href="#">맘에드는 아이템은 소망상자에 넣어보세요</a>
                      </p>
                      
                      <p class="text-board">
                      <a href="#">내 개성은 미니미로</a>
                      </p>
                      
                      <p class="text-gallery">
                      <a href="#">스킨, 메뉴효과 예약기능 좋아</a>
                      </p>
                      
                      <p class="text-board">
                      <a href="#">더욱 편리해진 사용중 아이템</a>
                      </p>
                    </div>
                  </div>
                  
                  <div class="mini-room-wrap">
                    <div class="nav-room-wrap">
                      <div class="nav-room">
                        <p>갤러리</p>
                      </div>
                    </div>
                    <img
                      class="img-miniroom"
                      src="./source/img/mini_room.gif"
                      alt="mini-room"
                    />
                  </div>
                  
                  <h2>한줄 다이어리</h2>
                  <div class="singleLine-say-section">
                    <input
                      type="text"
                      class="singleLine-say-section-title"
                      placeholder="가장 인상깊었던 일은 무엇인가요?"
                      style="border: 1px solid lightgray; padding: 5px; margin-left: 10px;"
                    />
                    <button 
	                class="singleLine-say-section-button"    
                    onclick="function()"
                    style="width: 70px;background-color: #A2E1DB;border-radius: 5px;border: 1px solid lightgray;">확인</button>
                  </div>
                  
                  <div class="singleLine-say-list">
                    <p>오늘은 슬펐다 </p>
                    <p>새다~ </p>
                    <p>ㅋㅋㅋㅋㅋㅋ </p>
                    <p>ㅋ </p>
                    <p>안녕 </p>
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
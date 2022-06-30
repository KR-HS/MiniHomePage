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
 <link rel="stylesheet" href="../css/miniMypage.css" />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dday").html(Dday()+"일");
	});
	
	function Dday(){
		var today = new Date();
		var dday ="<fmt:formatDate value='${sessionScope.memberVO.getBirth()}' pattern='yyyy/MM/dd'/>";
		var dday = new Date(dday);
		var gap = dday.getTime()-today.getTime();
		var result = Math.ceil(gap/(1000*60*60*24));
		result=result%365;
		if(result<0){
			result=365+result;
		}
		return result;

	}
	
	function formCheck(){
		var value = $("#introduce").val();
		if(value==null || value.trim().length==0){
			alert("한글자 이상 입력해주세요")
			$("#introduce").val("");
			$("#introduce").focus();
			return false;
		}
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
                    <div class="mypage">
                    	<h2>마이페이지</h2>
                      	<div class="myinfo-wrapper">
                      		<!-- 회원 이름, 프로필사진 -->
                      		<div class="myinfo">
                      			<div class="myinfo-pic"></div>
                      			<div class="myinfo-text-wrapper">
                      				<table class="myinfo-text-table">
                      					<tr>
                      					<td colspan="2">이름</td>
                      					<td colspan="5">${sessionScope.memberVO.getName()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">연락처</td>
                      					<td colspan="5">${sessionScope.memberVO.getPhone()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">메일주소</td>
                      					<td colspan="5">${sessionScope.memberVO.getEmail()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">성별</td>
                      					<td colspan="5">${sessionScope.memberVO.getGender()=="M"?"남성":"여성"}</td>
                      					</tr>
                      				</table>
                      			</div>
                      		</div>
                      	</div>
                      	
                      	<form action="updateIntroduce.jsp" method="post" onsubmit="return formCheck();">
	                      	<h2 align="left">자기소개</h2>
	                      	<input type="hidden" name="userid" value="${sessionScope.memberVO.getUserid() }" />
	                      	<textarea class="text" name="introduce" id="introduce" cols="100" rows="5" required 
	                      	placeholder="${sessionScope.memberVO.getIntroduce()=='' ? '탈퇴 이유를 남겨주세요' : sessionScope.memberVO.getIntroduce()}"></textarea>
	                      	<input type="submit" value="정보수정" id="submitBtn" >
                      	</form>
                      	
                      	<h2>총 게시물수</h2>
                      	<table class="countContent">
                      		<tr>
                      			<td class="countContent-category">총개수</td>
                      			<td class="countContent-counting">15개</td>
                      		</tr>
                      		<tr>
                      			<td class="countContent-category">자유게시판</td>
                      			<td class="countContent-counting">10개</td>
                      		</tr>
                      		<tr>
                      			<td class="countContent-category">갤러리</td>
                      			<td class="countContent-counting">5개</td>
                      		</tr>
                      		
                      		
                      	</table>
                      		
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
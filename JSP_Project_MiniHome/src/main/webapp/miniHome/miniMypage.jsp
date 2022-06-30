<%@page import="kr.human.member.service.FriendServiceImpl"%>
<%@page import="kr.human.member.vo.FriendVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.board.service.BoardServiceImpl"%>
<%@page import="kr.human.board.vo.BoardVO"%>
<%@page import="kr.human.board.vo.PagingVO"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	MemberVO userVO = MemberServiceImpl.getInstance().searchUser((String)session.getAttribute("userid"));
	request.setAttribute("userVO",userVO);
	
	BoardVO profile=BoardServiceImpl.getInstance().selectByCateogry(userVO.getUserid(), "Profile");
	request.setAttribute("profile",profile);
	
	BoardVO mypage=BoardServiceImpl.getInstance().selectByCateogry(userVO.getUserid(), "Mypage_pic");
	request.setAttribute("mypage",mypage);
	
	if(session.getAttribute("memberVO")!=null){
		MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
		List<FriendVO> friendList= FriendServiceImpl.getInstance().FriendList(memberVO.getUserid());
		request.setAttribute("friend",friendList);
	}
%>
<%@ include file="board/board_include.jsp"%>
<%	
	PagingVO<BoardVO> gallery = BoardServiceImpl.getInstance().selectGList(currentPage, pageSize, blockSize,userVO.getUserid());
	PagingVO<BoardVO> free = BoardServiceImpl.getInstance().selectFList(currentPage, pageSize, blockSize,userVO.getUserid());
	request.setAttribute("gallery",gallery);
	request.setAttribute("free",free);

%>
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
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<!-- css -->
 <link rel="stylesheet" href="../css/miniPage/miniMypage.css" />
 <link rel="stylesheet" href="../css/miniPage/miniHomeCommon.css" />
<!-- jquery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dday").html(Dday()+"일");
	});
	
	function Dday(){
		var today = new Date();
		var dday ="<fmt:formatDate value='${userVO.getBirth()}' pattern='yyyy/MM/dd'/>";
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
	h2{
		border-bottom:none;
	}
	
</style>
</head>
<body>
	<c:if test="${empty userVO}">	
		${response.sendRedirect("../findFriend.jsp")}
	</c:if>

	<div class="background">
      <main>
        <jsp:include page="include/profile.jsp">
			<jsp:param name="userVO" value="${userVO }"/>
			<jsp:param name="profile" value="${profile }"/>
		</jsp:include>
        
        <section class="main-section">
          <div class="main-dot">
            <div class="main-paper">
              <div class="main-wrap">
              	
				<h5 align="right" style="margin:0 20px 0 0; line-height:0;">
              		
              		<c:if test="${empty sessionScope.memberVO }">
	              		<a href="../login.jsp" style="margin-left:10px;">로그인하기</a>
              		</c:if>
              		
              		<c:if test="${not empty sessionScope.memberVO and sessionScope.memberVO.getUserid()!=userVO.getUserid()  }">
	              		<span style="margin-left:10px;">손님</span><span style="color:blue;">(로그인중)</span>
	              		<a href="../logout.jsp" style="margin-left:10px; color:red;">로그아웃하기</a>
	              		
              		</c:if>
              		
              		<c:if test="${not empty sessionScope.memberVO and sessionScope.memberVO.getUserid()==userVO.getUserid()  }">
	              		<span style="color:blue;">(로그인중)</span>
	              		<a href="../logout.jsp" style="margin-left:10px; color:red;">로그아웃하기</a>
              		</c:if>
              		
              		<a href="${pageContext.request.contextPath }" style="margin:0 0 0 10px;">
              			<i class="fa fa-home" aria-hidden="true" style="height:0; line-height:0;color:black;"></i>
              		</a>
              		
              		<c:if test="${not empty sessionScope.memberVO && not empty userVO && sessionScope.memberVO.getUserid()!=userVO.getUserid() }">
	              		<c:forEach var="fr" items="${friend}">
		              		<c:if test="${fr.friendid==userVO.getUserid()}">
		              			<c:set var="isFriend" value="true" />
		              		</c:if>
	              		</c:forEach>
              			<c:if test="${isFriend}">
		              		<a href="#" onclick='sendPost("friendUpdate.jsp",{"m": 1 })' style="margin:0 0 0 10px;">
		              			<i class="fa fa-heart" aria-hidden="true" style="height:0; line-height:0;color:red"></i>
		              		</a>
              			</c:if>
              			
              			<c:if test="${!isFriend }">
              				<a href="#" onclick='sendPost("friendUpdate.jsp",{"m": 0 })' style="margin:0 0 0 10px;">
		              			<i class="fa fa-heart" aria-hidden="true" style="height:0; line-height:0;color:black"></i>
		              		</a>
              			</c:if>
					</c:if>
              	</h5>
              	
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
                    	<h2>마이페이지
                    	<c:if test="${memberVO.getUserid()==userVO.getUserid()}">
		                  <c:if test="${empty mypage }">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_insert.jsp?category=Mypage_pic','마이페이지 정보저장', 'width=500,height=250,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon mypage_pic-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
		                  
		                  <c:if test="${not empty mypage}">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_update.jsp?category=Mypage_pic','마이페이지 정보수정', 'width=500,height=237,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon mypage_pic-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
	                 	 </c:if>
                    	</h2>
                    	
                      	<div class="myinfo-wrapper">
                      		<!-- 회원 이름, 프로필사진 -->
                      		<div class="myinfo">
                      			<c:if test="${empty mypage.fileList}">
                      			<img class="myinfo-pic" src="${pageContext.request.contextPath}/images/mypage_default.png"/>
                      			</c:if>
                      			
                      			<c:if test="${not empty mypage.fileList}">
                      			<img class="myinfo-pic" src="${pageContext.request.contextPath}/upload/${mypage.fileList[0].getSfile()}"/>
                      			
                      			</c:if>
                      			<div class="myinfo-text-wrapper">
                      				<table class="myinfo-text-table">
                      					<tr>
                      					<td colspan="2">이름</td>
                      					<td colspan="5">${userVO.getName()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">연락처</td>
                      					<td colspan="5">${userVO.getPhone()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">메일주소</td>
                      					<td colspan="5">${userVO.getEmail()}</td>
                      					</tr>
                      					
                      					<tr>
                      					<td colspan="2">성별</td>
                      					<td colspan="5">${userVO.getGender()=="M"?"남성":"여성"}</td>
                      					</tr>
                      				</table>
                      			</div>
                      		</div>
                      	</div>
                      	
                      	<form action="updateIntroduce.jsp" method="post" onsubmit="return formCheck();" accept-charset="utf-8">
	                      	<h2 align="left">자기소개</h2>
	                      	<input type="hidden" name="userid" value="${sessionScope.memberVO.getUserid() }" />
	                      	<textarea class="text" name="introduce" id="introduce" cols="100" rows="5" required
	                      	<c:if test="${userVO.getUserid()!=sessionScope.memberVO.getUserid() }">readonly</c:if>
	                      	placeholder="텍스트를 입력해주세요">${userVO.getIntroduce()!=' '?userVo.getIntroduce():''}</textarea>
	                      	<c:if test="${userVO.getUserid()==sessionScope.memberVO.getUserid() }">
	                      	<input type="submit" value="정보수정" id="submitBtn" >
                      		</c:if>
                      	</form>
                      	
                      	<h2>총 게시물수</h2>
                      	<table class="countContent">
                      		<tr>
                      			<td class="countContent-category">총개수</td>
                      			<td class="countContent-counting">${free.totalCount+gallery.totalCount }개</td>
                      		</tr>
                      		<tr>
                      			<td class="countContent-category">자유게시판</td>
                      			<td class="countContent-counting">${free.totalCount}개</td>
                      		</tr>
                      		<tr>
                      			<td class="countContent-category">갤러리</td>
                      			<td class="countContent-counting">${gallery.totalCount}개</td>
                      		</tr>
                      	</table>
                      	
                      	<br>
                      	
                      	<h2>친구 목록</h2>
                      	<ul class="friendList">
                      		<c:set var="count" value="0"/>
                      		<c:forEach var="fr" items="${friend}">
	                      		<li>
	                      			<span class="friendid"><c:out value="${fr.friendid}"/></span>
	                      			<span class="friendHome">
	                      				<a href="miniHome.jsp?userid=${fr.friendid}"><i class="fa fa-home" aria-hidden="true"></i></a>
	                      			</span>
	                      			<c:set var="count" value="${count+1 }"/>
	                      		</li>
	                      		<c:if test="${count%3==0 }">
	                      			<br>
	                      		</c:if>
                      		</c:forEach>
                      	</ul>
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
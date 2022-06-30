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
	
	if(session.getAttribute("memberVO")!=null){
		MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
		List<FriendVO> friendList= FriendServiceImpl.getInstance().FriendList(memberVO.getUserid());
		request.setAttribute("friend",friendList);
	}
%>
<%@ include file="board/board_include.jsp"%>

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
 <link rel="stylesheet" href="../css/miniPage/miniBoard.css" />
 <link rel="stylesheet" href="../css/miniPage/miniHomeCommon.css" />
<!-- jquery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/miniHome.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dday").html(Dday()+"일");
		$("table th").eq(0).css("border-bottom", "1px solid lightgray")
		$("table th").eq(1).css("border-bottom", "1px solid lightgray")
		$("table th").eq(2).css("border-bottom", "1px solid lightgray")
		$("table th").eq(3).css("border-bottom", "1px solid lightgray")

		
		$("#password").keyup(function() {
			var value = $(this).val();
			var pass=$("#userpw").val();
			
			if(value!=null){
				if(pass==value) {  
					$("#pwCheck").html("일치").css('color','green');
				} else{
					$("#pwCheck").html("불일치").css('color','red');
				}
			}
		});
	});
	
	function Dday(){
		var today = new Date();
		var dday ="<fmt:formatDate value='${userVO.getBirth()}' pattern='yyyy/MM/dd'/>";
		var dday = new Date(dday);
		var gap = dday.getTime() -today.getTime();
		var result = Math.ceil(gap/(1000*60*60*24));
		result=result%365;
		if(result<0){
			result=365+result;
		}
		return result;
	}
	
	function formCheck(){
		var value = $("#password").val();
		if(value==null || value.trim().length==0){
			alert('사용자 비빌번호는 반드시 입력해야 합니다.');
			$("#password").val("");
			$("#password").focus();
			return false;
		}
		if($("#pwCheck").html()!="일치"){
			alert('비밀번호가 일치하지 않습니다.');
			$("#password").val("");
			$("#pwCheck").text("");
			$("#password").focus();
			return false;
		}
		
		var value = $("#subject").val();
		if(value==null || value.trim().length==0){
			alert('제목은 반드시 입력해야 합니다.');
			$("#postCode").val("");
			$("#postCode").focus();
			return false;
		}
		var value = $("#content").val();
		if(value==null || value.trim().length==0){
			alert('내용은 반드시 입력해야 합니다.');
			$("#addr2").val("");
			$("#addr2").focus();
			return false;
		}
		
	}
	
	function appendFile(){
		if(count==maxCount){
			alert("첨부 파일은 최대 " + maxCount + "개까지만 가능합니다.");
			return;
		}
		count++;
		$("#fileBox").append($('<div id="file'+count+'"> <input type="file" class="fileItem" accept="image/*" name="file" id="file'+count+'" /> </div>'));
	}
</script>
<style type="text/css">
	table{
		width: 100%;
		margin: 0 5px;
		border: 2px solid #bfbfc8;
		border-radius: 15px
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
	#content{
		max-width:450px;
		min-width:450px;
	}
	#fileBox>div{
		text-align: left;
		margin: 10px 0 0 17px;
	}
	#userid{
		width:165px;
		background-color:lightgray;
	}
	#category, #password{
		width:165px;
	}
	#file-upload-button{
		width: 70px;
		border-radius: 5px;
		border: 1px solid lightgray;
	}
	.btn-outline-success{
		width: 70px;
		background-color: #87CEEB;
		border-radius: 5px;
		border: 1px solid lightgray;
	}
	.btn-outline-danger{
		width: 70px;
		background-color: lightpink;
		border-radius: 5px;
		border: 1px solid lightgray;
	}
	.item{
		font-size:20px;
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
                    <div class="freeBoard-wrap">
                      <form action="miniBoard_updateOk.jsp?userid=${userVO.getUserid() }" enctype="multipart/form-data"
							method="post" onsubmit="return formCheck();">
								<%-- 여기에서 몇개를 숨겨서 가지고 가자 --%>
								<input type="hidden" name="p" value="${p }" /> 
								<input type="hidden" name="s" value="${s }" /> 
								<input type="hidden" name="b" value="${b }" /> 
								<input type="hidden" name="m" value="1" />
								<input type="hidden" id="userpw" value="${sessionScope.memberVO.getPassword() }"/>
								
								<table>
									<tr>
										<td colspan="4" class="title">
											<h1 style="font-weight:900">갤러리 새글쓰기</h1>
										</td>
									</tr>
									
									<tr>
										<td class="item" >아이디</td>
										<td >
											<input type="text" name="userid" id="userid"
											required="required" value="${sessionScope.memberVO.getUserid()}" maxlength="30" readonly/>
										</td>
										<td class="item" style="width:80px;">비밀번호</td>
										<td>
											<input type="password" name="password" id="password" required="required" maxlength="30"style="width:165px;" />
										</td>
									</tr>
									
									<tr>
										<td>
											<label for="category" class="item">분류</label>
										</td>
										<td>
											<select id="category" name="category" onFocus="this.initialSelect = this.selectedIndex;"
											  onChange="this.selectedIndex = this.initialSelect;">
											    <option value="Free" >자유게시판</option>
											    <option value="Gallery" selected>갤러리</option>
											</select>
										</td>
										<td class="item" style="width:80px;"></td>
										<td ><div id="pwCheck" ></div></td>
									</tr>
									
									<tr>
										<td class="item">제목</td>
										<td colspan="3">
											<input type="text" name="subject"
											id="subject" required="required" size="90" maxlength="100" style="width:450px" />
										</td>
									</tr>
									
									<tr>
										<td class="item" valign="top">내용</td>
										<td colspan="3">
											<textarea name="content" id="content" cols="0" rows="3" placeholder="내용을 입력해주세요"></textarea>
										</td>
									</tr>
									
									<tr>
										<td class="item" valign="top" style="width:80px;">파일첨부</td>
										<td colspan="3">
											<div style="margin: 0 0 5px 17px; text-align:left;">
												<input type="button" value="   +   " onclick="appendFile()"	class="btn btn-outline-danger btn-sm" />
												<input type="button" value="   -   " onclick="removeFile()" class="btn btn-outline-danger btn-sm"/>
											</div>
											<div id="fileBox">
												<div id="file1" >
													<input type="file" name="file" id="file1" accept="image/*" required/>
												</div>
											</div>
										</td>
									</tr>

									<tr>
										<td colspan="4" style="border: none; text-align: right;">
											<div style="text-align:right; margin:0 20px 10px 0; padding:10px;">
											<input type="submit" value="저장" 	class="btn btn-outline-success btn-sm" />
											<input type="button" class="btn btn-outline-success btn-sm"
											onclick='sendPost("miniGallery.jsp",{"p":${p},"s":${s },"b":${b }})' value="목록" >
											</div>
										</td>
									</tr>
								</table>
								
						</form>
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
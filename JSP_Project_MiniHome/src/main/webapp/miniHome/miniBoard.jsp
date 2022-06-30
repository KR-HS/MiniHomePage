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
<%	
	PagingVO<BoardVO> pagingVO = BoardServiceImpl.getInstance().selectFList(currentPage, pageSize, blockSize,userVO.getUserid());
	request.setAttribute("pv", pagingVO);
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
		var obj = $("#name");
		if(obj.val()==null || obj.val().trim().length==0){
			alert("이름은 반드시 입력해야 합니다.");
			obj.val("");
			obj.focus();
			return false;
		}
		var obj = $("#password");
		if(obj.val()==null || obj.val().trim().length==0){
			alert("비밀번호는 반드시 입력해야 합니다.");
			obj.val("");
			obj.focus();
			return false;
		}
		var obj = $("#subject");
		if(obj.val()==null || obj.val().trim().length==0){
			alert("제목은 반드시 입력해야 합니다.");
			obj.val("");
			obj.focus();
			return false;
		}
		var obj = $("#content");
		if(obj.val()==null || obj.val().trim().length==0){
			alert("내용은 반드시 입력해야 합니다.");
			obj.val("");
			obj.focus();
			return false;
		}
	}
</script>
<style type="text/css">
	table{
		border:1px solid gray;
	}
	table a{
		color:black;
	}
	table td{
		border:none;
	}
	
	table tr td{
		text-align:center;
	}
	ul{
	  list-style:none;
	}
	.pagination{
	padding:0;
	}
	
	ul>li{
		font-size:25px;
	}

	h2{
	border:none;
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
                      <h2>자유게시판</h2>
                      <table class="freeBoard">
                      	<tr class="freeBoard-category">
                      		<th>No</th>
                      		<th width="60%">제목</th>
                      		<th>작성자</th>
                      		<th>등록일</th>
                      	</tr>
                      	
                      	<c:if test="${pv.totalCount==0 }">
							<tr>
								<td colspan="5" style="text-align: center;">등록된 글이 없습니다.</td>
							</tr>
						</c:if>
                      	
                      	<c:if test="${pv.totalCount>0 }">
							<c:if test="${not empty pv.list }">
								<%-- 시작 번호 계산 --%>
								<c:set var="no" value="${pv.totalCount - (pv.currentPage-1)*pv.pageSize }" />
									<c:forEach var="vo" items="${pv.list }">
										<tr>
											<td>${no }<c:set var="no" value="${no - 1 }" /></td>
											<td style="text-align: left;">
												<a href="#"	onclick='sendPost("miniBoard_view.jsp",{"p":${p } , "s": ${s }, "b":${b } , "idx":${vo.idx}})'>
													<c:out value="${vo.subject}" />
												</a> 
												
												<%-- 첨부 파일 개수를 출력해보자 --%>
												<c:if test="${not empty vo.fileList }">
													<c:forEach var="f" items="${vo.fileList }">
														<a href="#" onclick='sendPost("miniBoard_download.jsp",{"of":"${f.ofile }","sf":"${f.sfile}"});'>
															<i class="fa fa-file" aria-hidden="true" title="${f.ofile }" style="cursor: pointer;"></i>
														</a>
													</c:forEach>
												</c:if>
											</td>
											
											<td>
												<c:out value="${vo.userid }" />
											</td>
											
											<td>
												<fmt:formatDate value="${vo.regDate }" pattern="yy-MM-dd" />
											</td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="4" class="sub_title" style="text-align: center;">${pv.pageList}</td>
									</tr>
								</c:if>
							</c:if>
                      </table>
                      <c:if test="${sessionScope.memberVO.getUserid()==userVO.getUserid() }">
	                      <h4 align="right" style="margin-top:20px;">
							<button class="btn btn-outline-success btn-sm" 
							onclick='sendPost("miniBoard_insert.jsp",{"p":${p } , "s": ${s }, "b":${b } })'>새글쓰기</button>
						  </h4>
					  </c:if>
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
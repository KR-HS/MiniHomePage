<%@page import="kr.human.member.service.FriendServiceImpl"%>
<%@page import="kr.human.member.vo.FriendVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.board.vo.BoardCommentVO"%>
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
	// 1개 분량의 글을 얻어온다.
	BoardVO BoardVO = BoardServiceImpl.getInstance().selectByIdx(idx);
	if (BoardVO == null) { //해당글이 없다면
		String url="miniBoard.jsp";
		response.sendRedirect(url);
		return;
	}
	request.setAttribute("vo", BoardVO);
	
	PagingVO<BoardCommentVO> pagingCommentVO = BoardServiceImpl.getInstance().selectBoardCommentList(currentPage, pageSize, blockSize,idx);
	request.setAttribute("cv", pagingCommentVO);
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
	
	function sendPost(url, params) {
	    var form = document.createElement('form');
	    form.setAttribute('method', 'post'); //POST 메서드 적용
	   	if(url=='?'){
	   		url=document.location.href;
	   	}
	    form.setAttribute('action', url);	// 데이터를 전송할 url
	    document.charset = "utf-8";
	    for ( var key in params) {	// key, value로 이루어진 객체 params
	        var hiddenField = document.createElement('input');
	        hiddenField.setAttribute('type', 'hidden'); //값 입력
	        hiddenField.setAttribute('name', key);
	        hiddenField.setAttribute('value', params[key]);
	        form.appendChild(hiddenField);
	    }
	    document.body.appendChild(form);
	    form.submit();	// 전송~
	}
	
	function updateForm(idx){
		var userid = $("#c_userid" + idx).html();
		var content = $("#c_content" + idx).html();
		// alert(name + "\n" + content);
		$("#c_resetBtn").css('display','inline'); // 취소버튼 보이고
		$("#c_submitBtn").val('수정'); // 버튼의 내용을 변경하고
		$("#c_idx").val(idx)
		$("#c_mode").val("update");
		$("#c_userid").val(userid);
		$("#c_content").val(content);
		$("#c_password").focus();
	}
	function deleteForm(idx){
		var userid = $("#c_userid" + idx).html();
		var content = $("#c_content" + idx).html();
		// alert(name + "\n" + content);
		$("#c_resetBtn").css('display','inline'); // 취소버튼 보이고
		$("#c_submitBtn").val('삭제'); // 버튼의 내용을 변경하고
		$("#c_idx").val(idx)
		$("#c_mode").val("delete");
		$("#c_userid").val(userid);
		$("#c_content").val(content);
		$("#c_password").focus();
	}
	function resetForm(){
		$("#c_resetBtn").css('display','none'); // 취소버튼 숨기고
		$("#c_submitBtn").val('저장'); // 버튼의 내용을 변경하고
		$("#c_idx").val('0')
		$("#c_mode").val("insert");
		$("#c_userid").val("");
		$("#c_content").val("");
		$("#c_userid").focus();
	}
</script>
<style type="text/css">

	.freeboard-table{
		width: 100%;
		height:400px;
		border: 2px solid #bfbfc8;
		margin: 0 5px;
		border-radius: 15px;
	}
	table td{
		border:none;
	}
	.title h1{
		margin:0;
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
		border:1px solid gray;
	}
	#fileBox>div{
		text-align: left;
		margin: 10px 0 0 17px;
	}
	#file-upload-button{
		width: 70px;
		border-radius: 5px;
		border: 1px solid lightgray;
	}
	.btn-outline-success{
		width: 70px;
		background-color: lightblue;
		color:white;
		font-size:16px;
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
	.item-content{
		text-align:left; 
		font-weight:500;
		padding:0 0 10px 30px;
	}
	
	.comment-table{
		width:100%;
		height:auto;
	}
	#c_content{
		width:90%;
		max-height:150px;
		min-height:150px;
		margin-top:10px;
	}
	.comment-update-btn{
		border:none;
		margin:0 5px 0 30px;
		padding:0 15px 0 15px;
		border-radius:5px;
		background-color:skyblue;
		color:white;
	}
	.comment-delete-btn{
		border:none;
		margin:0 0 0 5px;
		padding:0 15px 0 15px;
		border-radius:5px;
		background-color:skyblue;
		color:white;
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
                      <table class="freeBoard-table">
							<tr>
								<td colspan="4" class="title">
									<h1 style="font-weight:900;">자유게시판 내용보기</h1>
								</td>
							</tr>
							
							<tr >
								<td class="item">아이디</td>
								<td colspan="3" class="item-content"><c:out value="${vo.userid }"></c:out></td>
							</tr>
							
							<tr>
								<td class="item">작성일</td>
								<td colspan="3" class="item-content"><fmt:formatDate value="${vo.regDate }"
								pattern="yyyy년 MM월 dd일(E요일) hh:mm:ss" /></td>
							</tr>
							
							<tr>
								<td class="item">제목</td>
								<td colspan="3" class="item-content"><c:out value="${vo.subject }"></c:out></td>
							</tr>
							
							<tr>
								<td class="item" >내용</td>
								<td colspan="3">
									<c:set var="content" value="${vo.content }" /> 
									<%-- 태그 무시 --%>
									<c:set var="content" value="${fn:replace(content,'<','&lt;') }" /> 
									<textarea name="content" id="content" cols="0" rows="9">${content }</textarea>
								</td>	
							</tr>
							
							<tr>
								<td class="item">첨부파일</td>
								<td colspan="3" class="item-content">
									<%-- 첨부 파일 개수를 출력해보자 --%>
									<c:if test="${not empty vo.fileList }">
										<c:forEach var="f" items="${vo.fileList }">
											<a href="#"	onclick='sendPost("miniBoard_download.jsp",{"of":"${f.ofile }","sf":"${f.sfile}"});'>
												<i class="fa fa-file" aria-hidden="true" style="cursor: pointer;"></i>
												${f.ofile }
											</a>
											<br/>
										</c:forEach>
									</c:if>
								</td>
							</tr>

							<tr>
								<td colspan="4" style="padding:0 30px 10px 0;border: none; text-align: right;">
								<c:if test="${sessionScope.memberVO.getUserid()==userVO.getUserid() }">
									<button class="btn btn-outline-success btn-sm"
									onclick='sendPost("miniBoard_update.jsp",{"p":${p},"s":${s },"b":${b },"idx":${idx },"hit":0})'>수정</button>
									<button class="btn btn-outline-success btn-sm"
									onclick='sendPost("miniBoard_delete.jsp",{"p":${p},"s":${s },"b":${b },"idx":${idx },"hit":0})'>삭제</button>
								</c:if>
								
								<c:if test="${vo.category == 'Free'}">
									<button class="btn btn-outline-success btn-sm"
									onclick='sendPost("miniBoard.jsp",{"p":${p},"s":${s },"b":${b }})'>목록</button>
								</c:if>
								
								<c:if test="${vo.category == 'Gallery'}">
									<button class="btn btn-outline-success btn-sm"
									onclick='sendPost("miniGallery.jsp",{"p":${p},"s":${s },"b":${b }})'>목록</button>
								</c:if>
								</td>
							</tr>
							</table>
							
							<br>
							
							<table class="comment-table">
								<tr>
									<td colspan="4">
										<h3 align="center" style="padding:10px 0 10px 0;font-weight:700;">댓글</h3>
									</td>
								</tr>
								
								<tr>
									<c:if test="${not empty sessionScope.memberVO }">
									<td colspan="4" style="border: none;text-align:left;padding:0 0 0 45px">
										<form action="boardCommentUpdate.jsp" method="post" onsubmit="return formCheck();">
											<input type="hidden" name="idx" value="0" id="c_idx">
											<input type="hidden" name="idx_ref" value="${vo.idx }" id="c_ref">
											<input type="hidden" name="p" value="${p }" id="c_p">
											<input type="hidden" name="s" value="${s }" id="c_s">
											<input type="hidden" name="b" value="${b }" id="c_b">
											<input type="hidden" name="mode" value="insert" id="c_mode">
											<input type="hidden" name="category" value="${vo.category}" id="c_ct">
											
											<input type="text" name="userid" id="c_userid" value="${sessionScope.memberVO.getUserid()}" readonly/>
											<input type="password" name="password" id="c_password" required="required" placeholder="비번입력"/>
											<br>
											<textarea rows="5" cols="0" name="content" id="c_content" placeholder="내용입력" required="required"></textarea>
											<div style="text-align: right; padding-right:50px;">
											<input type="submit" class="btn btn-outline-success btn-sm" value="저장" id="c_submitBtn"/>
											<input type="button" class="btn btn-outline-success btn-sm" value="취소" id="c_resetBtn" style="display: none;" onclick="resetForm()"/>
											</div>					
										</form>
									</td>
									</c:if>
									<c:if test="${empty sessionScope.memberVO }">
									<td>
										<h5 align="center" style="padding:10px 0 10px 0;font-weight:500; color:gray;line-height:0;">로그인 후 댓글기능을 이용하실수 있습니다.</h5>
									</td>
									</c:if>
								</tr>
								<tr>
									<td colspan="4" style="border: none; padding:20px 45px 5px 45px;margin-top:20px;">
										<c:if test="${cv.totalCount==0 }">
											<div style="padding:5px; text-align:center;margin-bottom: 5px;">등록된 댓글이 없습니다.</div>
										</c:if>
										<c:if test="${cv.totalCount>0 }">
											<c:forEach var="cvo" items="${cv.list }">
												<div style="padding:10px; border: 1px solid lightgray;margin-bottom: 5px;">
													<div style="padding:10px; border: none;background-color: #CCE5FF;text-align:left;">
														<span id="c_userid${cvo.idx }">${cvo.userid }</span> 님이
														<fmt:formatDate value="${cvo.regDate }" pattern="yy-MM-dd hh:mm:ss"/>에 남긴댓글
														<%-- 수정/삭제 버튼 달기 --%>
														<c:if test="${not empty sessionScope.memberVO }">
														<button onclick="updateForm(${cvo.idx})" class="comment-update-btn"> 수정 </button>
														<button onclick="deleteForm(${cvo.idx})" class="comment-delete-btn"> 삭제 </button>
														</c:if>
													</div>
													<div style="display: none;" id="c_content${cvo.idx }">${cvo.content }</div>
													<div style="padding:5px; border: none;text-align:left;">
														<c:set var="c" value="${cvo.content }"/>
														<c:set var="c" value="${fn:replace(c,'<','&lt;') }"/>
														<c:set var="c" value="${fn:replace(c,newLine,br) }"/>
														${c }
													</div>
												</div>
											</c:forEach>
										</c:if>
									</td>		
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
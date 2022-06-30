<%@page import="kr.human.member.vo.FriendVO"%>
<%@page import="kr.human.member.service.FriendServiceImpl"%>
<%@page import="kr.human.board.vo.SimpleCommentVO"%>
<%@page import="kr.human.board.vo.PagingVO"%>
<%@page import="kr.human.board.service.BoardServiceImpl"%>
<%@page import="kr.human.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	if(request.getParameter("userid")!=null){
		String userid  = request.getParameter("userid");
		session.setAttribute("userid", userid);
	}
	
	String userid=(String)session.getAttribute("userid");
	MemberVO userVO = MemberServiceImpl.getInstance().searchUser(userid);
	request.setAttribute("userVO",userVO);
	
	List<BoardVO> recentList = BoardServiceImpl.getInstance().selectRecentList(userid);
	request.setAttribute("recent", recentList);
	
	BoardVO profile=BoardServiceImpl.getInstance().selectByCateogry(userVO.getUserid(), "Profile");
	request.setAttribute("profile",profile);
	
	BoardVO travel=BoardServiceImpl.getInstance().selectByCateogry(userVO.getUserid(), "Travel_pic");
	request.setAttribute("travel",travel);
	
	BoardVO bgm=BoardServiceImpl.getInstance().selectByCateogry(userVO.getUserid(), "Bgm");
	request.setAttribute("bgm",bgm);
	
	if(session.getAttribute("memberVO")!=null){
		MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
		List<FriendVO> friendList= FriendServiceImpl.getInstance().FriendList(memberVO.getUserid());
		request.setAttribute("friend",friendList);
	}
%>
<%@ include file="board/board_include.jsp"%>
<%	
	PagingVO<SimpleCommentVO> commentVO = BoardServiceImpl.getInstance().selectSimpleCommentList(currentPage, pageSize, blockSize,userVO.getUserid());
	request.setAttribute("cv", commentVO);
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
<!-- css추가 -->
 <link rel="stylesheet" href="../css/miniPage/miniHome.css" />
 <link rel="stylesheet" href="../css/miniPage/miniHomeCommon.css" />
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

	
	$(function(){
		$(document).on("pageload",function(){
			  window.location.reload(true);
		});
		
		$("#dday").html(Dday()+"일");
		
		$("#comment").keyup(function() {
			var value = $(this).val();
			
			if(value.length>20){
				alert("최대 20자까지만 입력하실 수 있습니다.");
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
	
	function sendPost(url, params) {
	    var form = document.createElement('form');
	    form.setAttribute('method', 'post'); //POST 메서드 적용
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
	
	function formCheck(){
		var obj = $("#comment");
		if(obj.val()==null || obj.val().trim().length==0){
			alert("내용은 반드시 입력해야 합니다.");
			obj.val("");
			obj.focus();
			return false;
		}
	}
	
	function updateForm(idx){
		var content = $("#comment" + idx).html();
		// alert(name + "\n" + content);
		$("#resetBtn").css('display','inline'); // 취소버튼 보이고
		$("#submitBtn").val('수정'); // 버튼의 내용을 변경하고
		$("#idx").val(idx)
		$("#mode").val("update");
		$("#comment").val(content);
		$("#password").focus();
	}
	
	function deleteForm(idx){
		var content = $("#comment" + idx).html();
		// alert(name + "\n" + content);
		$("#resetBtn").css('display','inline'); // 취소버튼 보이고
		$("#submitBtn").val('삭제'); // 버튼의 내용을 변경하고
		$("#idx").val(idx)
		$("#mode").val("delete");
		$("#comment").val(content);
		$("#password").focus();
	}
	
	function resetForm(){
		$("#resetBtn").css('display','none'); // 취소버튼 숨기고
		$("#submitBtn").val('저장'); // 버튼의 내용을 변경하고
		$("#idx").val('0')
		$("#mode").val("insert");
		$("#password").val("");
		$("#comment").val("");
		$("#comment").focus();
	}
	
	function sendPost(url, params) {
	    var form = document.createElement('form');
	    form.setAttribute('method', 'post'); //POST 메서드 적용
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
</script>
</head>
<body oncontextmenu="return false" ondragstart="return false">
	<c:if test="${empty userVO}">	
		${response.sendRedirect("../findFriend.jsp")}
	</c:if>
	
	<div class="background">
      <main>
        <jsp:include page="include/profile.jsp">
			<jsp:param name="userVO" value="${userVO }"/>
			<jsp:param name="profile" value="${profile}"/>
			<jsp:param name="bgm" value="${bgm}"/>
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
              			<i class="fa fa-home" aria-hidden="true"></i>
              		</a>
              		
              		<c:if test="${not empty sessionScope.memberVO && not empty userVO && sessionScope.memberVO.getUserid()!=userVO.getUserid() }">
	              		<c:forEach var="fr" items="${friend}">
		              		<c:if test="${fr.friendid==userVO.getUserid()}">
		              			<c:set var="isFriend" value="true" />
		              		</c:if>
	              		</c:forEach>
              			<c:if test="${isFriend}">
		              		<a href="#" onclick='sendPost("friendUpdate.jsp",{"m": 1 })' style="margin:0 0 0 10px;">
		              			<i class="fa fa-heart" aria-hidden="true" style="color:red"></i>
		              		</a>
              			</c:if>
              			
              			<c:if test="${!isFriend }">
              				<a href="#" onclick='sendPost("friendUpdate.jsp",{"m": 0 })' style="margin:0 0 0 10px;">
		              			<i class="fa fa-heart" aria-hidden="true" style="color:black"></i>
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
                    <div class="recent-post">
                    <h2>최근 게시물</h2>
                    <c:if test="${empty recent }">
                    	<h4 align="center">최근 등록된 게시물이 없습니다.</h4>
                    	<br>
                    </c:if>
                    <c:if test="${not empty recent }">
	                    <c:forEach var="vo" items="${recent }">
	                    
	                      <p class="${vo.category}">
	                        <c:if test="${vo.category=='Free'}">
		                        <a href="#" onclick='sendPost("miniBoard_view.jsp",{"p": 1 , "s": 10, "b": 10 , "idx":${vo.idx}})'>
		                        ${vo.subject }
		                        </a>
	                        </c:if>
	                        
	                        <c:if test="${vo.category=='Gallery'}">
		                        <a href="#" onclick='sendPost("miniGallery_view.jsp",{"p": 1 , "s": 10, "b": 10 , "idx":${vo.idx}})'>
		                        ${vo.subject }
		                        </a>
	                        </c:if>
	                      </p>
	                    </c:forEach>
                    </c:if>
                    </div>
                  </div>
                  
                  <div class="mini-room-wrap">
                    <div class="nav-room">
                       <p>여행 사진
                       <c:if test="${memberVO.getUserid()==userVO.getUserid()}">
		                  <c:if test="${empty travel }">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_insert.jsp?category=Travel_pic','여행사진 정보저장', 'width=500,height=250,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon travel_pic-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
		                  
		                  <c:if test="${not empty travel}">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_update.jsp?category=Travel_pic','여행사진 정보수정', 'width=500,height=237,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon travel_pic-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
	                  </c:if>
	                  </p>
                    </div>
                    <c:if test="${not empty travel.fileList }">
                    <img 
                    	class="img-miniroom" 
                    	src="${pageContext.request.contextPath }/upload/${travel.fileList[0].getSfile()}"/>
                    </c:if>
                    
                    <c:if test="${empty travel.fileList }">
                    <img
                      class="img-miniroom"
                      src="${pageContext.request.contextPath }/images/travel_default.jpg"/>
                    </c:if>
                  </div>
                  <br>
                  <h2>방명록</h2>
                  <form action="simpleCommentUpdate.jsp" method="post" onsubmit="return formCheck();" accept-charset="utf-8">
					<input type="hidden" name="idx" value="0" id="idx">
					<input type="hidden" name="userid" value="${userVO.getUserid()}">
					<input type="hidden" name="commentid" value="${sessionScope.memberVO.getUserid()}">
                  	<input type="hidden" name="p" value="${p}" id="p">
                  	<input type="hidden" name="s" value="${s}" id="c">
                  	<input type="hidden" name="b" value="${b}" id="b">
                  	<input type="hidden" name="mode" value="insert" id="mode">
                  	
                  <div class="singleLine-say-section">
                    <input
                      type="text"
                      class="singleLine-say-section-title"
                      maxlength='20'
                      id="comment${cvo.idx }"
                      name="content"
                      placeholder="${userVO.getUserid()}님에게 한줄평을 남겨주세요! (20자 내외)"
                    />
                    
                    <c:if test="${not empty sessionScope.memberVO }">
                    <input
                      type="password"
                      class="singleLine-say-section-password"
                      id="password"
                      name="password"
                      placeholder="비밀번호 입력"
                    />
                    <br>
                    <input
                    type="submit"
	                class="singleLine-say-section-button insertBtn" 
	                id="submitBtn"  
	                value="저장" 
                    onclick="SimplecommentUpdate.jsp"/>
                    
                    <input
                    type="button"
                    class="singleLine-say-section-button cancelBtn"
                    value="취소"
                    id="resetBtn"
                    style="display: none;"
                    onclick="resetForm()"/>
                  	</c:if>
                  	
                  	<c:if test="${empty sessionScope.memberVO }">
                  	<span style="font-size:15px;font-weight:400;text-decoration:underline;">로그인후 이용 가능합니다</span>
                  	</c:if>
                  	<br>
                  </div>
                  </form>
                  <div class="singleLine-say-list">
                  	<c:if test="${cv.totalCount==0 }">
						<div style="padding:5px; text-align:center;margin-bottom: 5px;">등록된 한줄평이 없습니다.</div>
					</c:if>
					
					<c:if test="${cv.totalCount>0 }">
						<c:forEach var="cvo" items="${cv.list }">
							<c:set var="c" value="${cvo.content }"/>
							<c:set var="c" value="${fn:replace(c,'<','&lt;') }"/>
							<c:set var="c" value="${fn:replace(c,newLine,br) }"/>
							<div class="singleLine-say-list-item">
								<div style="display: none;" id="comment${cvo.idx }">${cvo.content }</div>
								${c }<br>
								<span class="singleLine-say-list-writer">
									<c:out value="(${cvo.commentid }님)"/>
								</span>	 
								<span class="singleLine-say-list-date">
									<fmt:formatDate value="${cvo.regDate }" pattern="yy-MM-dd hh:mm:ss"/>
								</span>
								<c:if test="${not empty sessionScope.memberVO }">
									<span>
										<button onclick="updateForm(${cvo.idx})" class="singleLine-say-section-button updateBtn"> 수정 </button>
										<button onclick="deleteForm(${cvo.idx})" class="singleLine-say-section-button deleteBtn"> 삭제 </button>
									</span>
								</c:if>
							</div>
						</c:forEach>
					</c:if>
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
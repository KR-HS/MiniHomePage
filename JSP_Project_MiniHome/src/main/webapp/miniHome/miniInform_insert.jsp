<%@page import="kr.human.board.service.BoardServiceImpl"%>
<%@page import="kr.human.board.vo.BoardVO"%>
<%@page import="kr.human.board.vo.PagingVO"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
MemberVO userVO = MemberServiceImpl.getInstance().searchUser((String) session.getAttribute("userid"));
request.setAttribute("userVO", userVO);

String category = request.getParameter("category");
request.setAttribute("category",category);
%>
<%@ include file="board/board_include.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- font-awesome4 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="../css/miniPage/miniBoard.css" />
<link rel="stylesheet" href="../css/miniPage/miniHomeCommon.css" />
<!-- jquery -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style type="text/css">
table {
	width: 100%;
	border: 2px solid #bfbfc8;
}

table td {
	border: none;
}

table tr td {
	text-align: center;
}

.content_title {
	text-align: left;
}
textarea{
	max-width: 300px;
	min-width: 300px;
	max-height: 50px;
	min-height:50px
}
#fileBox>div {
	text-align: left;
	margin: 10px 0 0 17px;
}

#userid {
	width: 165px;
	background-color: lightgray;
}

#category, #password {
	width: 165px;
}

#pwCheck {
	width: 100%;
	font-size: 15px;
	font-weight: 600;
}

#file-upload-button {
	width: 70px;
	border-radius: 5px;
	border: 1px solid lightgray;
}

.btn-outline-success {
	width: 70px;
	background-color: #87CEEB;
	border-radius: 5px;
	border: 1px solid lightgray;
}

.btn-outline-danger {
	width: 70px;
	background-color: lightpink;
	border-radius: 5px;
	border: 1px solid lightgray;
}

.item {
	font-size: 20px;
}
</style>
</head>
<body>
	<div style="text-align:center;vertical-align:center;">
		<form action="miniBoard_updateOk.jsp" enctype="multipart/form-data"
			method="post">
			<%-- ???????????? ????????? ????????? ????????? ?????? --%>
			<input type="hidden" name="m" value="1" />
			<input type="hidden" name="userid" value="${sessionScope.memberVO.getUserid() }" />
			<input type="hidden" name="password" id="password" value="${sessionScope.memberVO.getPassword() }" />
			<c:if test="${category!='Bgm' }">
			<input type="hidden" name="subject" id="subject" value="" />
			</c:if>
			<c:if test="${category!='Profile' }">
				<input type="hidden" name="content" id="content" value="" />
			</c:if>
			<table>
				<tr>
					<td colspan="4" class="title">
						<h1 style="font-weight: 900;">
							<c:if test="${category=='Profile' }">
								<c:set var="ct" value="?????????"/>
							</c:if>
							
							<c:if test="${category=='Bgm' }">
								<c:set var="ct" value="??????"/>
							</c:if>
							
							<c:if test="${category=='Mypage_pic' }">
								<c:set var="ct" value="?????????????????????"/>
							</c:if>
							
							<c:if test="${category=='Travel_pic' }">
								<c:set var="ct" value="????????????"/>
							</c:if>
							<c:out value="${ct}"/> ????????????
						</h1>
					</td>
				</tr>
				
				<tr>
					<td>
						<label for="category" class="item">??????</label>
					</td>
					<td style="text-align: left; padding-left: 22px;">
						<select
							id="category" name="category"
							onFocus="this.initialSelect = this.selectedIndex;"
							onChange="this.selectedIndex = this.initialSelect;">
								<option value="Free">???????????????</option>
								<option value="Gallery">?????????</option>
								<option value="${category}" selected><c:out value="${ct}"/></option>
						</select>
					</td>
				</tr>
				<c:if test="${category=='Bgm' }">
					<tr>
					<td class="item" valign="top">????????????</td>
					<td colspan="3" style="text-align: left; padding-left: 22px;">
						<input type="text" name="subject" id="subject" placeholder="??????????????? ??????????????????" required style="width:165px;"></input>
					</td>
				</tr>
				</c:if>
				<c:if test="${category=='Profile' }">
				<tr>
					<td class="item" valign="top">??????</td>
					<td colspan="3" style="text-align: left; padding-left: 22px;">
						<textarea name="content" id="content" cols="0" rows="9"	placeholder="????????? ??????????????????" required></textarea>
					</td>
				</tr>
				</c:if>
				
				<tr>
					<td class="item" valign="top" style="width: 80px;">
						<c:out value="${category=='Bgm'?'??????':'?????????'}"/>??????
					</td>
					<td colspan="3">
						<div id="fileBox">
							<div id="file1">
								<c:if test="${category!='Bgm'}">
								<input type="file" name="file" id="file" accept="image/*" />
								</c:if>
								
								<c:if test="${category=='Bgm'}">
								<input type="file" name="file" id="file" accept="audio/*" />
								</c:if>
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<td colspan="4" style="border: none; text-align: right;">
						<div style="text-align: right; margin: 0 20px 10px 0; padding: 10px;">
							<input type="submit" value="??????" 	class="btn btn-outline-success btn-sm" />
							<input type="button" class="btn btn-outline-success btn-sm" onclick='window.close()' value="??????">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
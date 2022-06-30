<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<header class="header">
		<!--logo(Button)-->
		<nav class="logoArea">
			<a href="index.jsp">MINI</a>
		</nav>
		
			<div class="index_form">
				<div class="indexfont">	
					<c:if test="${not empty memberVO }">
					<table>
						<tr>
							<td colspan="5" style="font-size:14px;">${memberVO.userid }(${memberVO.name })님 반갑습니다</td>
						</tr>
					
						<tr>
							<td><a href="updateForm.jsp" style="color:#888888; text-decoration-line: none;">정보수정</a></td>
							<td style="font-weight:lighter;">&nbsp;|&nbsp;</td>
							<td><a href="deleteForm.jsp" style="color:#888888; text-decoration-line: none;">회원탈퇴</a></td>
							<td style="font-weight:lighter;">&nbsp;|&nbsp;</td>
							<td><a href="logout.jsp" style="color:#888888; text-decoration-line: none;">로그아웃</a></td>
						</tr>
					</table>
					</c:if>
				</div>
			</div>
	</header>


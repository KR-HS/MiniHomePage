<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="profile-section">
	<div class="profile-dot">
    	<div class="profile-paper">
        	<div class="profile-wrap">
            	<div class="audio_wrapper">
              		<c:if test="${memberVO.getUserid()==userVO.getUserid()}">
			            <c:if test="${empty bgm}">
			            	<a href="#" 
			           		onclick="window.open('miniInform_insert.jsp?category=Bgm','브금 정보저장', 'width=500,height=250,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
			            	class="setting-icon bgm-setting">
			                <i class="fa fa-cog"></i>
			                </a>
			            </c:if>
			                  
			            <c:if test="${not empty bgm}">
			            	<a href="#" 
			                onclick="window.open('miniInform_update.jsp?category=Bgm','브금 정보수정', 'width=500,height=237,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
			                class="setting-icon bgm-setting">
			                <i class="fa fa-cog"></i>
			                </a>
			            </c:if>
	              	</c:if>
              	
              		<c:if test="${empty bgm.fileList }">
	              		<MARQUEE scrolldelay="200" >Charlie Puth - Thats Hilarious</MARQUEE>
	              		<audio src="${pageContext.request.contextPath }/music/Bgm_default.mp3" autoplay loop controls></audio>
              		</c:if>
              		
              		<c:if test="${not empty bgm.fileList }">
	              		<MARQUEE scrolldelay="200" >${bgm.getSubject() } - ${bgm.fileList[0].getOfile()}</MARQUEE>
	              		<audio src="${pageContext.request.contextPath }/upload/${bgm.fileList[0].getSfile()}" autoplay loop controls></audio>
              		</c:if>
              	</div>
                
                <div class="profile">
                	<div class="visitor-counter">
	                  <p class="text-total">프로필</p>
	                  <c:set var="memberVO" value="${sessionScope.memberVO }"/>
	                  <c:if test="${memberVO.getUserid()==userVO.getUserid()}">
		                  <c:if test="${empty profile }">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_insert.jsp?category=Profile','프로필 정보저장', 'width=500,height=250,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon profile-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
		                  
		                  <c:if test="${not empty profile}">
		                  <a href="#" 
		                  	  onclick="window.open('miniInform_update.jsp?category=Profile','프로필 정보수정', 'width=500,height=237,fullscreen=no,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no');return false;"
		                	  class="setting-icon profile-setting">
		                  	<i class="fa fa-cog"></i>
		                  </a>
		                  </c:if>
	                  </c:if>
                	</div>
                
                  <p class="text-dday-is">
                    생일까지 D-Day <i>🎉</i><span id="dday"></span>
                  </p>
                  
                  <c:if test="${empty profile.fileList }">
				  <img class="profileImg" src="${pageContext.request.contextPath }/images/profile_default.png"/>
				  </c:if>
				  
                  <c:if test="${not empty profile.fileList }">
                  <img class="profileImg" src="${pageContext.request.contextPath }/upload/${profile.fileList[0].getSfile()}"/>
				  </c:if>
				  
                  <div class="desc-wrap">
	                  <c:if test="${not empty profile.content }">
	                    <p class="text-desc">
	                    	<c:set var="content" value="${profile.content }" /> 
							<%-- 태그 무시 --%>
							<c:set var="content" value="${fn:replace(content,'<','&lt;') }" /> 
							${content}
	                    </p>
	                  </c:if>	
	                  <c:if test="${empty profile.content }">
	                  	<p class="text-desc">
	                  	신규회원입니다.<br>
	                  	(프로필 내용을 변경해주세요)
	                  	<p>
	                  </c:if>
                  </div>
                  
                  <div class="info-wrap">
                    <a class="info-name" href="#">${userVO.getName()}</a>
                    <a class="info-name etc" href="#">${userVO.getGender()=='M'? '♂️':'♀️' }
                    <fmt:formatDate value="${userVO.getBirth()}" pattern="yyyy/MM/dd"/>
                    </a>
                    <p class="text-email">${userVO.getEmail() }</p>
                  </div>
                </div>
                
              </div>
            </div>
          </div>
</section>
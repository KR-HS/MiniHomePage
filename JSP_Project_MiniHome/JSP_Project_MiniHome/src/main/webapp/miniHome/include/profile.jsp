<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<section class="profile-section">
	<div class="profile-dot">
		<div class="profile-paper">
			<div class="profile-wrap">
				<div class="audio_wrapper">
					<h4 align="center" style="height: 0">가수 - 노래제목</h4>
					<audio src="../css/music/bgm1.mp3" autoplay controls loop></audio>
				</div>


				<div class="profile">
					<div class="visitor-counter">
						<p class="text-total">13042</p>
						<a href=#><i class="fa-regular fa-gear"></i></a>
					</div>

					<p class="text-dday-is">
						생일까지 D-Day <i>🎉</i><span id="dday"></span>
					</p>

					<div class="profileImg"></div>
					<!-- <img
                    class="profile-img"
                    src="./source/img/profile.jpeg"
                    alt="profile"
                  /> -->

					<div class="desc-wrap">
						<p class="text-desc">
							사람좋은 사람들 <br /> 싸이월드<br /> ^-^
						</p>
					</div>

					<div class="info-wrap">
						<a class="info-name" href="#">${memberVO.getName()}</a> <a
							class="info-name etc" href="#">${memberVO.getGender()=='M'? '♂️':'♀️' }
							<fmt:formatDate value="${memberVO.getBirth()}"
								pattern="yyyy/MM/dd" />
						</a>
						<p class="text-email">${memberVO.getEmail() }</p>
						<!--  
                    <img src="./source/img/b+.png" alt="b+" />
                    <img src="./source/img/dotol.jpeg" alt="dotol" />
                  	-->
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
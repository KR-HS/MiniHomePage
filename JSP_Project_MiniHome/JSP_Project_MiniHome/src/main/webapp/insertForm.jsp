<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- 부트스트랩을 사용하기 위한 준비 시작 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>
<%-- 부트스트랩을 사용하기 위한 준비 끝 --%>
<%-- 다음 우편번호 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	$("#birth").datepicker({
		format : "yyyy-mm-dd", // 달력에서 클릭시 표시할 값 형식
		autoclose: true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
        clearBtn: true, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
        daysOfWeekHighlighted: [0], //강조 되어야 하는 요일 설정
        immediateUpdates: true,//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
        showWeekDays: true,// 위에 요일 보여주는 옵션 기본값 : true
        todayHighlight: true, //오늘 날짜에 하이라이팅 기능 기본값 :false
        weekStart: 0, //달력 시작 요일 선택하는 것 기본값은 0인 일요일
        language: 'kr', //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	});
	// 아이디 입력시 Ajax를 호출하여 아이디 중복확인하기	
	$("#userid").keyup(function() {
		var value = $(this).val();
		if(value!=null && value.length>=4){
			// alert(value);
			$.ajax("idCheck.jsp", {
				type : "GET",
				data : {"userid":value},
				success : function(data){
					//alert(typeof(data) + "\n" + data )
					if(data*1==0){
						$("#msg_id").html("√ 사용가능").css('color','green');
					}else{
						$("#msg_id").html("× 사용불가").css('color','red');
					}
				},
				error : function(){
					alert('에러다!!!!')
				}
			});
		}else{
			$("#msg_id").html("").css('color','black');
		}
	});
	
	$("#password").keyup(function() {
		var value = $(this).val();
		var passRule = /^[A-Za-z0-9]{6,12}$/;
		
		if(value!=null && value.length>=6){
			if(passRule.test(value)) {  
				$("#msg_pw").html("√ 사용가능").css('color','green');
			} else{
				$("#msg_pw").html("× 사용불가").css('color','red');
			}
		}
	});
	$("#email").keyup(function() {
		var value = $(this).val();
		var emailRule = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
		if(value!=null && value.length>=7){
			if(emailRule.test(value)) {  
				$("#msg_email").html("√ 사용가능").css('color','green');
			} else{
				$("#msg_email").html("× 사용불가").css('color','red');
			}
		}
	});
	$("#phone").keyup(function() {
		var value = $(this).val();
		var hpRule = /^\d{3}-\d{3,4}-\d{4}$/;
		
		if(value!=null && value.length>=6){
			if(hpRule.test(value)) {  
				$("#msg_hp").html("√ 사용가능").css('color','green');
			} else{
				$("#msg_hp").html("× 부적절").css('color','red');
			}
		}
	});
	
});

function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postCode').value = data.zonecode;
            document.getElementById("addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addr2").focus();
        }
    }).open();
}

// 폼검증하는 자바스크립트 함수
function formCheck(){
	var value = $("#userid").val();
	if(value==null || value.trim().length==0){
		alert('아이디는 반드시 입력해야 합니다.');
		$("#userid").val("");
		$("#userid").focus();
		return false;
	}
	if($("#msg_id").html()!="√ 사용가능"){
		alert('사용 불가능한 아이디입니다.');
		$("#userid").val("");
		$("#msg_id").text("");
		$("#userid").focus();
		return false;
	}
	var value = $("#password").val();
	if(value==null || value.trim().length==0){
		alert('사용자 비빌번호는 반드시 입력해야 합니다.');
		$("#password").val("");
		$("#password").focus();
		return false;
	}
	if($("#msg_pw").html()!="√ 사용가능"){
		alert('사용 불가능한 비밀번호입니다.');
		$("#password").val("");
		$("#msg_pw").text("");
		$("#password").focus();
		return false;
	}
	var value = $("#name").val();
	if(value==null || value.trim().length==0){
		alert('사용자 이름은 반드시 입력해야 합니다.');
		$("#name").val("");
		$("#name").focus();
		return false;
	}
	var value = $("#email").val();
	if(value==null || value.trim().length==0){
		alert('이메일 주소는 반드시 입력해야 합니다.');
		$("#email").val("");
		$("#email").focus();
		return false;
	}
	
    if ($("#msg_hp").html()!="√ 사용가능") {
    	alert('이메일 주소 형식이 잘못되었습니다.');
		$("#email").val("");
		$("msg_email").text("");
		$("#email").focus();
		return false;
    }
	var value = $("#phone").val();
	if(value==null || value.trim().length==0){
		alert('전화번호는 반드시 입력해야 합니다.');
		$("#phone").val("");
		$("#phone").focus();
		return false;
	}
	if($("#msg_hp").html()!="√ 사용가능"){
		alert('전화번호가 부적절합니다. 다시 입력해주세요.');
		$("#phone").val("");
		$("#msg_hp").text("");
		$("#phone").focus();
		return false;
	}
	var value = $("#postCode").val();
	if(value==null || value.trim().length==0){
		alert('우편번호는 반드시 입력해야 합니다.');
		$("#postCode").val("");
		$("#postCode").focus();
		return false;
	}
	var value = $("#addr2").val();
	if(value==null || value.trim().length==0){
		alert('상세 주소는 반드시 입력해야 합니다.');
		$("#addr2").val("");
		$("#addr2").focus();
		return false;
	}
}
</script>

<style type="text/css">
	.title { 
		font-size: 18pt;
		text-align: center; 
		padding: 10px; 
		margin-top:-10px;
		margin-bottom:20px;
		font-weight: bold;
	}
	
	body {
	background-color:white;
	display: flex;
  	justify-content: center;
  	align-items: center;
  	min-height: 100vh;
	}
	
	.container{
	margin-top:20px;
	width:700px;
	background-color:white;
	border: 1px solid lightgray;
	padding: 15px;
	border-radius: 0px;
	}
	
	.col-form-label{
	font-weight:bolder
	}
	
	.form-control{
	font-size:10pt;
	}
	
</style>
</head>
<body>
	<div class="container" style="">
		<form action="insertOk.jsp" method="post" onsubmit="return formCheck();">
			<div class="title" >회원가입하기</div>
			<div style="margin-top:10px;margin-bottom:10px;"></div>
			<div class="mb-3 row">
			  	<div class="col-sm-1"></div>
			  	<label for="userid" class="col-sm-3 col-form-label" style="font-weight:bolder">사용자 아이디(*)</label>
			  	<div class="col-sm-3">
				<input type="text" class="form-control" id="userid" name="userid" placeholder="아이디입력" required>
				</div>
				<div class="col-sm-3 col-error-label" id="msg_id" ></div>
			</div>
			
			<div class="mb-3 row">
			  	<div class="col-sm-1"></div>
			  	<label for="password" class="col-sm-3 col-form-label">사용자 비밀번호(*)</label>
			  	<div class="col-sm-3">
				<input type="password" class="form-control" id="password" name="password" placeholder="6~12자 입력" 
				maxlength="12" required  >
				</div>
				<div class="col-sm-3 col-error-label" id="msg_pw"></div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
			  	<label for="name" class="col-sm-3 col-form-label">사용자 이름</label>
			  	<div class="col-sm-3">
				<input type="text" class="form-control" id="name" name="name" placeholder="이름 입력" required>
				</div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label for="birth" class="col-sm-3 col-form-label">생년월일</label>
			  	<div class="col-sm-3">
				<input type="text" class="form-control" id="birth" name="birth1" placeholder="생년월일 입력" required>
				</div>
			</div>
			
			<div class="mb-3 row">
			  	<div class="col-sm-1"></div>
			  	<label for="email" class="col-sm-3 col-form-label">사용자 이메일(*)</label>
			  	<div class="col-sm-3">
				<input type="email" class="form-control" id="email" name="email" placeholder="이메일 입력" required>
				</div>
				<div class="col-sm-3 col-error-label" id="msg_email"></div>
			  	
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label for="phone" class="col-sm-3 col-form-label">사용자 전화번호(*)</label>
			  	<div class="col-sm-3">
				<input type="tel" class="form-control" id="phone" name="phone" placeholder="ex) 010-1234-5678" required>
				</div>
				<div class="col-sm-3 col-error-label" id="msg_hp"></div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label class="col-sm-3 col-form-label">성별</label>
				<div class="col-sm-3">
			  	  <label for="gender1" class="col-sm-3 col-gender-label">남자</label>
				  <input class="form-check-input" type="radio" name="gender" id="gender1" value="M" checked>
				</div>
				<div class="col-sm-3">
			  	  <label for="gender2" class="col-sm-3 col-gender-label">여자</label>
				  <input class="form-check-input" type="radio" name="gender" id="gender2" value="F">
				 </div> 
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label class="col-sm-3 col-form-label" for="postCode" >우편번호</label>
				<div class="col-sm-3">
				  <input class="form-control" type="text" name="postCode" id="postCode" readonly  required onclick="daumPostcode();">
				</div>
				<div class="col-sm-3">
				  <input type="button" class="btn-check" id="zipCodebtn" onclick="daumPostcode();">
				  <label class="btn btn-outline-primary" for="zipCodebtn">우편번호찾기</label>
				</div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label class="col-sm-3 col-form-label" for="addr1">주소</label>
				<div class="col-sm-6">
				  <input class="form-control" type="text" name="addr1" id="addr1" readonly  required  onclick="daumPostcode();">
				</div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-1"></div>
				<label class="col-sm-3 col-form-label" for="addr2">상세주소</label>
				<div class="col-sm-6">
				  <input class="form-control" type="text" name="addr2" id="addr2"  required>
				</div>
			</div>
			
			<div class="col-sm-10" style="text-align: right;">
					  <input type="submit" class="btn-check" id="submitBtn" >
					  <label class="btn btn-outline-success" for="submitBtn">회원가입</label>
					  <input type="reset" class="btn-check" id="resetBtn" >
					  <label class="btn btn-outline-success" for="resetBtn">다시쓰기</label>
					  <input type="button" class="btn-check" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}'">
					  <label class="btn btn-outline-success" for="cancelBtn">돌아가기</label>
			</div>
			
		</form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="UTF-8">
<title>searchPwd</title>

<script>
$(document).ready(function() {
	
	$("#userEmail").focus();
	

	
	
	
});

function fn_resetPwd(){
	if($.trim($("#userId").val()).length <= 0){
		alert("이메일 전화번호 또는 아이디를 입력해 주세요.");
		$("#userEmail").val("");
		$("#userEmail").focus();
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"/user/findPwdProc",
		data:{
			userId:$("#userId").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			if(res.code == 0){
				alert("임시비밀번호가 발송되었습니다.");
				fn_signUpProc();
			}
			else if(res.code == 400){
				alert("값이 올바르지 않습니다.");
				$("#userId").focus();
			}
			else{
				alert("임시 비밀번호 발송 중 오류가 발생하였습니다. 다시 시도해 주세요");
				$("#userId").focus();
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
			alert("임시 비밀번호 발송 중 예상치 못한 오류가 발생하였습니다.");
		}
		
	});
	
	document.findpw_form.action = "/main/home";
	document.findpw_form.submit();
	
}

</script>
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="logo">
                <img src="/resources/images/Sistagram.png" alt="Instagram" class="brand_logo">
            </div>
            <div class="centent">
                <form name="findpw_form"  method="POST">
                    <div class="content_text">
                        <span style="font-weight: bold;">로그인에 문제가 있나요?</span>
                    </div>
                    <div class="content_text">
                        <span style="font-size: 13px;">이메일 주소, 전화번호 또는 아이디를 입력하시면 계정에 다시 액세스할 수 있는 링크를 보내드립니다</span>
                    </div>
                    <div class="input_value">
                        <input type="text" id="userId" name="userId"  placeholder="이메일, 전화번호, 아이디">
                    </div>
                    <div class="btn_submit">
                        <button onclick="fn_resetPwd()">비밀번호 재설정</button>
                    </div>
                </form>
                <div class="or_line">
                    <div class="line"></div>
                    <div class="text">또는</div>
                    <div class="line"></div>
                </div>
                <ul class="find_pw">
                    <li><a href="/user/signUp">새 계정 만들기</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <span><a href="/index">로그인으로 돌아가기</a></span>
        </div>
            </div>
        </div>
    </div>
</body>
</html>
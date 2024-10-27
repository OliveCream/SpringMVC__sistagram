<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/boardDetail.css">


<script type="text/javascript">
$(document).ready(function(){
	$("#comment").focus();
	
	//게시 버튼 클릭시 실행 함수
	$(document).on("click", "#btnCommentPost", function(){
	
		if($.trim($("#comment").val()).length <= 0){
			alert("댓글 내용을 입력해주세요.");
			return;
		}
		
		fn_commentProc($("#commentGroup").val());
		
	});

});

//댓글 달기 클릭시 (태그)
function fn_comment(commentGroup, groupId){	
	
	$("#commentGroup").val(commentGroup);
	
	$("#comment").val("");
	$("#comment").focus();
	
	$("#comment").val('@' + groupId + ' ');
	
	// 백스페이스 키를 누르면 입력된 값과 commentGroup 초기화
	$("#comment").on("keydown", function(event){
		var totalCnt = $("#comment").val().length;
		var idCnt = groupId.length + 2;
		if(totalCnt <= idCnt){
			if(event.keyCode === 8){
				$("#commentGroup").val("");
				$("#comment").val("");
			}
		}
    });
}

//댓글 등록 Proc
function fn_commentProc(commentGroup){		
	
	$.ajax({
		type:"POST",
		url:"/main/commentProc",
		data:{
			boardNum:$("#boardNum").val(),
			comment:$("#comment").val(),
			commentGroup:commentGroup
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			if(res.code == 200){
				alert("댓글 등록 성공");
				location.reload();
			}
			else{
				alert(res.code);
				alert("댓글 등록 중 오류가 발생하였습니다.");
			}
		},
		error:function(xhr, status, error){
			alert("게시 중 예상치 못한 오류가 발생하였습니다.");
		}
	});
}

//글 삭제 (...) 클릭시
function fn_boardDelete(boardNum){
	if(confirm("해당 게시글을 삭제하시겠습니까:")){
		$.ajax({
			type:"POST",
			url:"/main/deleteBoard",
			data:{
				boardNum:boardNum
			},
			dataType: "JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(res){
				if(res.code == 200){
					alert("삭제되었습니다.");
					history.back();
				}else{
					alert("게시글 삭제 중 오류가 발생하였습니다.");
				}
			},
			error:function(xhr, status, error){
				console.log(xhr.status);
				alert("게시물 삭제 중 예상치 못한 오류가 발생하였습니다.");
			}
		});
	}
}


</script>

</head>
<body>
<div>
    <div>
        <div>
            <div class="main">
                <div class="container">
                    <div>
                        <div>
                            <%@ include file="/WEB-INF/views/include/navigation.jsp"%>
                            <br />
                            <section class="section-submit">
                                <div style="display: flex; justify-content: space-between;">
                                    <div class="boardDetail-img" style="flex-grow: 0; display: flex; align-items: center; background-color:black; border-radius: 5px;">
                                        <img src="/resources/upload/${insBoard.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="프로필 이미지" style="width: 450px; height:auto;">
                                    </div>
                                    <div style="flex-grow: 1; overflow-y: auto; margin-left:30px;">
<!-- 게시글 작성자 + 게시글 내용 -->
			<c:if test="${cookieUserId eq insBoard.userId}">
										<img src="/resources/images/more.png" onclick="fn_boardDelete(${insBoard.boardNum})" alt="img" style="cursor:pointer;">
			</c:if>
										<div class="user-list" style="padding: 10px; ">
											<div style="display: flex; flex-direction: row; justify-content: space-between;">
												<div style="margin-right: 10px;">
													<div style="cursor: pointer;">
														<img src="/resources/upload/${boardUser.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
													</div>
												</div>
												<div style="width: 100%; display: flex;">
													<div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
														<div>
															<div>
																<span style="font-weight: bold;">${boardUser.userId}</span>
															</div>
														</div>
														<div>
															<span style="font-size: 12px;">${boardUser.userName} <b style="text-align: right; margin-left:200px;"> ${insBoard.regDate}</b></span>
														</div>
													</div>
												</div>
											</div>
										</div>

										<p></p><hr>
<!-- 댓글 박스 시작 -->
                                        <div style="height: 500px; width:450px; overflow-y: auto;">
                                            <ul>
	<!--글 작성자 + 글내용 시작-->
											<div class="comment-list">
										        <div style="display: flex; flex-direction: row; justify-content: space-between;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${boardUser.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                        <p style="font-size: 15px;"><b style="font-weight:bold">${insBoard.userId}</b>&nbsp;&nbsp;${insBoard.boardContent}</p>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
	<!--글 작성자 + 글내용 끝-->
	<!--댓글 시작-->
		<c:if test="${!empty commentList}">
			<c:forEach var="insComment" items="${commentList}" varStatus="status">
					<c:if test="${insComment.commentParent eq 0}">
										    <div class="comment-list" >
										        <div style="display: flex; flex-direction: row; justify-content: space-between; margin-bottom:5px;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${insComment.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                    	<p style="font-size: 15px;"><b style="font-weight:bold">${insComment.userId}</b>&nbsp;&nbsp;${insComment.commentContent}</p>
										                    	<span style="font-size: 11px; color:gray;">
<%-- 										<c:if test="" --%>
										                    		<b style="margin-left:px;font-weight:bold; ">좋아요 5개</b>
										                    		<b style="margin-left:px;font-weight:bold;color:blue">좋아요 5개</b>
										                    		<b style="margin-left:15px;font-weight:bold; cursor:pointer" onclick="fn_comment(${insComment.commentGroup}, '${insComment.userId}')" >답글달기</b>
										                    		<b style="margin-left:15px; font-weight: thin;">${insComment.regDate}</b>
										                    	</span>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
					</c:if>
					
					<c:if test="${insComment.commentParent eq 1}">
										    <div class="comment-list" >
										        <div style="margin-left:50px; margin-top:-10px; margin-bottom:-5px; display: flex; flex-direction: row; justify-content: space-between;">
										            <div style="margin-right: 10px;">
										                <div style="cursor: pointer;">
										                    <img src="/resources/upload/${insComment.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 38px; height: 38px; border-radius: 50%;">
										                </div>
										            </div>
										            <div style="width: 100%; display: flex;">
										                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
										                    <div>
										                    	<p style="font-size: 15px;"><b style="font-weight:bold">${insComment.userId}</b>&nbsp;&nbsp;${insComment.commentContent}</p>
										                    	<span style="font-size: 11px; color:gray;">
										                    		<b style="margin-left:px;font-weight:bold; ">좋아요 5개</b>
										                    		<b style="margin-left:15px;font-weight:bold; cursor:pointer"  onclick="fn_comment(${insComment.commentGroup}, '${insComment.userId}')"  >답글달기</b>
										                    		<b style="margin-left:15px; font-weight: thin;">${insComment.regDate}</b>
										                    	</span>
										                    </div>
										                </div>
										            </div>
										        </div>
										    </div>
							
					</c:if>
					
			</c:forEach>
		</c:if>
	<!--댓글 끝-->
                                            </ul>
                                        </div>
<!-- 댓글 박스 끝 -->
<br />
<hr>
                                        <br />
<!--                                         <form id="commentForm" name="commentForm" method="post"> -->
                                            <input type="text" id="comment" name="comment" style="outline: none;"><br>
                                            <input type="hidden" id="commentGroup" name="commentGroup" value="">
                                            <button class="btn-comment" id="btnCommentPost" >게시</button>
<!--                                         </form> -->
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="boardDetailForm" name="boardDetailForm" method="post">
	<input type="hidden" id="cookieUserId" name="cookieUserId" value="${cookieUserId}" />
	<input type="hidden" id="userId" name="userId" value="" />
	<input type="hidden" id="boardNum" name="boardNum" value="${boardNum}" />
</form>

</body>
</html>
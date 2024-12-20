<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>home</title>
<%@ include file="/WEB-INF/views/include/head_main.jsp" %>

<style type="text/css">
.heartImg {
	width: 22px; 
	height: 22px;"
}
</style>

<script>
$(document).ready(function() {

});

//게시물 상세
function fn_boardDetail(boardNum){
	document.homeForm.boardNum.value = boardNum;
	document.homeForm.action = "/main/boardDetail";
	document.homeForm.submit();
}

//타인 프로필 이동
function fn_profileSomeone(userId){
	
	document.homeForm.someId.value = userId;
	
	if('${cookieUserId}' !== $("#someId").val()){
		document.homeForm.action = "/main/profileSomeone";
		document.homeForm.submit();
	}
	else{
		document.homeForm.action = "/main/profile";
		document.homeForm.submit();
	}
	
}

//회원님을 위한 추천 (팔로우/취소)
function fn_toggleFollow(button, userId) {
	if (button.innerText === "팔로우") {
	
	$.ajax({
		type:"POST",
		url:"/user/followingProc",
		data:{
			followingId:userId
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			if(res.code == 200){
				console.log("팔로잉 완료");
			}
			else{
				alert("팔로잉 중 오류가 발생하였습니다.");
			}
		},
		error:function(xhr, status, error){
			alert("팔로잉 중 예상치 못한 오류가 발생하였습니다.");
			icia.common.error(error);
		}
	});
	button.innerText = "팔로잉";
		button.style.color = "gray";
		        
	} else {
		if(confirm("팔로우 취소 하시겠습니까?")){
			$.ajax({
				type:"POST",
				url:"/user/followingCancelProc",
				data:{
					followingId:userId
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(res){
					if(res.code == 200){
						alert("팔로잉를 취소했습니다.");
					}
					else{
						alert("팔로잉 취소중 오류가 발생하였습니다.");
					}
				},
				error:function(xhr, status, error){
					alert("팔로잉 취소 중 예상치 못한 오류가 발생하였습니다.");
					icia.common.error(error);
				}
			});
			button.innerText = "팔로우";
			button.style.color = "#4cb5f9";
    	}
    }
    
}


//게시물 하트(추가/취소)
function fn_like(boardNum){
	
	var heartImg =  document.getElementById("heartImg").src;
	var standard = 'http://sistagram.co.kr:8088/resources/images/empty_heart.png';
	
	alert(document.getElementById("heartImg").src);
	alert(standard);
	
	if(heartImg == standard){
		alert("통과");
		document.getElementById("heartImg").src = "http://sistagram.co.kr:8088/resources/images/red_heart.png";
	}
	else{
		alert("else");
		document.getElementById("heartImg").src = "http://sistagram.co.kr:8088/resources/images/empty_heart.png";
	}
}

//main 댓글 게시
function fn_commentProc(boardNum){
	
	if($.trim($("#commentTextarea"+boardNum).val()).length <= 0){
		alert("댓글 내용을 입력해주세요.");
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"/main/commentProc",
		data:{
			boardNum:boardNum,
			comment:$("#commentTextarea"+boardNum).val(),
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(res){
			if(res.code == 200){
				alert("댓글 등록되었습니다.");
				location.reload();
			}
			else{
				alert("댓글 등록 중 오류가 발생하였습니다.");
			}
		},
		error:function(xhr, status, error){
			alert("게시 중 예상치 못한 오류가 발생하였습니다.");
			console.log(error);
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
					location.reload();
				}else{
					alert("게시글 삭제 중 오류가 발생하였습니다.");
				}
			},
			error:function(xhr, status, error){
			    console.log("Status -- " + status);
			    console.log("Error -- " + error);
			    console.log("Response -- " + xhr.responseText);
				alert("게시물 삭제 중 예상치 못한 오류가 발생하였습니다.");
			}
		});
	}
}

	
</script>

</head>
<body>


<form id="homeForm" name="homeForm" method="post">
	<input type="hidden" id="boardNum" name="boardNum" value="" />
	<input type="hidden" id="someId" name="someId" value="" />
</form>
    <div>
        <div>
            <div>
                <div class="main">
                    <div class="container">
                        <div>
                            <div>
                                <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
                                <div style="width: 85%; margin-left: auto;">
                                    <div style="height: 100vh; display: flex; flex-direction: column;">
                                        <div style="display: flex; flex-direction: column; flex-grow: 1;">
                                            <div style="display: flex; flex-direction: row; justify-content: center;">
                                                <div style="max-width: 500px; width: 100%; margin-left:10%;">	<!-- 메인게시물 너비 -->
                                                    <div style="margin-top: 20px;">
                                                        <!-- top -->
                                                        <div style="margin-bottom: 30px;">
                                                            <div style="padding: 0 10px;">
                                                                <div style="width: 100%; height: 100%; display: flex; flex-direction: row;">
                                                                    <ul style="display: flex; flex-direction: row; flex-grow: 1;">
                                                                        <li>
                                                                            <div style="padding: 0 5px;">
                                                                                <button style="background-color: transparent; border-style: none; cursor: pointer;">
                                                                                    <div>
                                                                                        <img src="/resources/upload/fbbc8c56b944464abde6e1555336fdf3.jpg" alt="img" style="width: 50px; height: 50px; border-radius: 50%;">
                                                                                    </div>
                                                                                    <div>
                                                                                        <span>${cookieUserId}</span>
                                                                                    </div>
                                                                                </button>
                                                                            </div>                                                                        
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- list 시작-->
<c:if test="${!empty boardList}">
	<c:forEach var="insBoard" items="${boardList}" varStatus="status">
	
                                                        <div id="boardData" style="width: 100%;">
                                                            <div style="display: flex; flex-direction: column;">
                                                                <div>
                                                                    <div style="width: 100%; height: 100%; display: flex; flex-direction: column; padding-bottom: 10px; margin-bottom: 20px; border-bottom-width: 1px; border-bottom-style: solid;">
                                                                        <div style="padding-bottom: 10px;">
                                                                            <div style="width: 100%; display: flex; flex-direction: row;">
                                                                                <div style="margin-right: 10px;">
                                                                                    <div style="cursor: pointer;">
                                                                                        <img id="boardProfileImg" onclick="fn_profileSomeone('${insBoard.userId}')" src="/resources/upload/${insBoard.userFileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 32px; height: 32px; border-radius: 50%;">
                                                                                    </div>
                                                                                </div>
                                                                                <div style="width: 100%; display: flex; align-items: center;">
                                                                                    <div style="display: flex; flex-direction: row;">
                                                                                        <div style="cursor: pointer;">
                                                                                            <a>
                                                                                                <span style="font-weight: bold;" onclick="fn_profileSomeone('${insBoard.userId}')">${insBoard.userId}</span>
                                                                                            </a>
                                                                                        </div>
                                                                                        <div style="display: flex; flex-direction: row;">
                                                                                            <div>
                                                                                                <span style="margin: 0px 4px;">•</span>
                                                                                            </div>
                                                                                            <div>
                                                                                                <span style="font-size:12px;">&nbsp;${insBoard.regDate}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div style="display: flex; align-items: center;">
					<c:if test="${user.userId eq insBoard.userId}">
                                                                                    <img src="/resources/images/more.png" onclick="fn_boardDelete(${insBoard.boardNum})" alt="img" style="cursor:pointer;">
					</c:if>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div style="cursor: pointer;">
                                                                            <a ><img id="boardImg" onclick="fn_boardDetail(${insBoard.boardNum})" class="board-detail-Img" src="/resources/upload/${insBoard.fileName}" alt="img" style="width: 100%; height: 100; border-radius: 3px;">
						<input type="hidden" value="${insBoard.boardNum}">
																			</a>
                                                                        </div>
                                                                        
                                                                        <div>
                                                                            <div style="display: flex; flex-direction: column;">
                                                                                <div style="display: grid; margin: 0px 5px; align-items: center; grid-template-columns: 1fr 1fr;">
                                                                                    <div style="display: flex; margin-left: -10px;">
                                                                                        <div style="padding: 8px; cursor: pointer; size:20px;">
                                                                                            <a><img id="heartImg" src="/resources/images/empty_heart.png" onclick="fn_like(${insBoard.boardNum})"  alt="img" class="heartImg"></a>
                                                                                        </div>
                                                                                        <div style="padding: 8px; cursor: pointer;">
                                                                                            <a><img src="/resources/images/reply.png" onclick="fn_boardDetail(${insBoard.boardNum})" alt="img"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div style="margin-left: auto; cursor: pointer;">
                                                                                        <a><img src="/resources/images/mark.png" alt="img"></a>
                                                                                    </div>
                                                                                </div>
                                                                                <div style="margin-top: 10px;">
                                                                                    <div style="display: inline-block; margin-right: 5px;">
                                                                                        <a>
                                                                                            <span style="font-weight: bold; cursor:pointer;" onclick="fn_profileSomeone('${insBoard.userId}')">${insBoard.userId}</span>
                                                                                        </a>
                                                                                    </div>
                                                                                    <span>
				<c:choose>
					<c:when test="${insBoard.boardContent.length() > 10}">
                                                                                        <p id="shortContent${insBoard.boardNum}" style="display:inline; font-size: 14px;">${insBoard.boardContent.substring(0, 10)}</p>
                                                                                        <p id="fullContent${insBoard.boardNum}" style="display:none; font-size: 14px; ">${insBoard.boardContent}</p>
                                                                                        <div style="margin-top: 10px; color:grey;">
		                                                                                    <span id="moreContent${insBoard.boardNum}" onclick="fn_showFullContent(${insBoard.boardNum})" style="cursor:pointer;">...더 보기</span>
		                                                                                </div>
					</c:when>
					<c:otherwise>
                                                                                        <span id="boardFullContent">${insBoard.boardContent}</span>
					</c:otherwise>
				</c:choose>
                                                                                    </span>
                                                                                </div>
                                                                                
                                                                                <div style="margin-top: 10px;">
                                                                                    <a>
                                                                                        <span style="font-size: 13px; cursor:pointer;" onclick="fn_boardDetail(${insBoard.boardNum})">댓글 ${insBoard.commentCnt}개 보기</span>
                                                                                    </a>
                                                                                </div>
                                                                                <div style="margin-top: 10px;">
                                                                                    <div style="display: flex; flex-direction: row; flex-grow: 1; align-items: center;">
                                                                                        <textarea id="commentTextarea${insBoard.boardNum}"  placeholder="댓글달기" style="height: 18px; border-style: none; resize: none; outline: none; flex-grow: 1;"></textarea>
                                                                                        <div>
                                                                                            <span onclick="fn_commentProc(${insBoard.boardNum})" style="font-size: 13px; font-weight: bold; cursor:pointer;">게시</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
	</c:forEach>
</c:if>
	
                                                        <!-- list 끝 -->
                                                    </div>
                                                </div>
                                                
                                                
                                                <!-- right -->
                                                <div style="width: 33%; height: 100vh; padding-left: 180px; ">
                                                    <div style="margin-top: 40px; display: flex; flex-direction: column;">
                                                        <div style="padding: 0 10px;">
                                                            <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                                                <div style="margin-right: 10px;">
                                                                    <div style="cursor: pointer;">
                                                                        <img src="/resources/upload/fbbc8c56b944464abde6e1555336fdf3.jpg" alt="img" style="width: 44px; height: 44px; border-radius: 50%;">
                                                                    </div>
                                                                </div>
	

                                                                <div style="width: 100%; display: flex;">
                                                                    <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
                                                                        <div>
                                                                            <div>
                                                                                <span style="font-weight: bold;">${user.userId}</span>
                                                                            </div>
                                                                        </div>
                                                                        <div>
                                                                            <span>${user.userName}</span>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div style="display: flex;">
                                                                    <div style="display: flex; align-items: center; flex-shrink: 0;">
                                                                        <span style="font-size: 12px; color: #4cb5f9;">전환</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div style="margin-top: 25px; margin-bottom: 10px;">
                                                            <div style="display: flex; flex-direction: column;">
                                                                <div style="display: flex; flex-direction: row;">
                                                                    <div style="display: flex; flex-grow: 1;">
                                                                        <span style="font-size: 14px;color:gray; font-weight:bold;">회원님을 위한 추천</span>
                                                                    </div>
                                                                    <div>
                                                                        <span style="font-size: 14px; font-weight: bold;">모두보기</span>
                                                                    </div>
                                                                </div><br />
                                                                
<c:if test="${!empty recommendUserList}">
	<c:forEach var="recommendUser" items="${recommendUserList}" varStatus="status">
                                                                <div style="width: 100%;">
                                                                    <div style="padding: 10px;">
                                                                        <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                                                            <div style="margin-right: 10px;">
                                                                                <div style="cursor: pointer;">
                                                                                    <img onclick="fn_profileSomeone('${recommendUser.userId}')" src="/resources/upload/${recommendUser.fileName}" onerror="this.src='/resources/images/default_profile.png';" alt="img" style="width: 44px; height: 44px; border-radius: 50%;">
                                                                                </div>
                                                                            </div>
                                                                            <div style="width: 100%; display: flex;">
                                                                                <div style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
                                                                                    <div>
                                                                                        <div style=" margin-bottom:5px;">
                                                                                            <span style="font-weight: bold; cursor:pointer;" onclick="fn_profileSomeone('${recommendUser.userId}')">${recommendUser.userId}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div >
                                                                                        <span style="cursor:pointer;" onclick="fn_profileSomeone('${recommendUser.userId}', this)">${recommendUser.userName}</span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
 					
                                                                            <div style="display: flex;">
                                                                                <div class="followButton" style="display: flex; align-items: center; flex-shrink: 0;">
                                                                                    <span class="followText" style="font-size: 12px;font-weight:bold; color: #4cb5f9; cursor:pointer;" onclick="fn_toggleFollow(this, '${recommendUser.userId}')">팔로우</span>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
	</c:forEach>
</c:if>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    
<script type="text/javascript">

//더보기
function fn_showFullContent(boardNum){
	document.getElementById('moreContent' + boardNum).style.display = "none";
	document.getElementById("shortContent" + boardNum).style.display = "none";
	document.getElementById("fullContent" + boardNum).style.display = "inline";
}

</script>
  </body>
</html>
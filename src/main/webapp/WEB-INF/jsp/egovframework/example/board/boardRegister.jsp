<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>boardRegister</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'/>">
	<script src="<c:url value='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'/>"></script>
	<script src="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'/>"></script>
	<script type="text/javaScript" language="javascript" defer="defer">
	
	$(document).ready(function(){
		
		/* readonly 처리 */
		$('#idx').attr("readonly",true);
		$('#writerNm').attr("readonly",true);
		$('#indate').attr("readonly",true);
	});
	
	/* 게시물 작성 취소 */
	function cancel(){
		location.href="<c:url value='/boardList.do'/>";
	}
	
	/* 게시물 등록 */
	function register(){
		
		/* 제목 미입력인 경우 */
		if($('#title').val() == ''){
			alert("제목을 입력하세요.");
			$('#title').focus();
			return;
		}
		
		/* 내용 미입력인 경우 */
		if($('#contents').val() == ''){
			alert("내용을 입력하세요.");
			$('#contents').focus();
			return;
		}
		
		/* 등록확인창 */
		if( !confirm("등록 하시겠습니까?")){
			return;
		}
		
		/* 게시물 등록 */
		document.form1.action = "<c:url value='/boardRegister.do'/>?mode=register";
		document.form1.submit();
	}
	
	/* 게시물 수정 */
	function mod(){
		
		/* 제목 미입력인 경우 */
		if($('#title').val() == ''){
			alert("제목을 입력하세요.");
			$('#title').focus();
			return;
		}
		
		/* 내용 미입력인 경우 */
		if($('#contents').val() == ''){
			alert("내용을 입력하세요.");
			$('#contents').focus();
			return;
		}
		
		/* 수정확인창 */
		if( !confirm("수정 하시겠습니까?")){
			return;
		}
		
		/* 수정 */
		document.form1.action = "<c:url value='/boardRegister.do'/>?mode=mod";
		document.form1.submit();
	}
	</script>
</head>
<body>
	<div class="container">
		<h1>Board Register</h1>
		<div class="panel panel-info">
			<!-- 로그인 정보 -->
	        <div class="panel-heading">
	        	<label for="">${sessionScope.user_name}님이 로그인했습니다.</label>
	        </div>
	        <!-- 게시물 작성 -->
	        <div class="panel-body">
	        	<form id="form1" name="form1" class="form-horizontal" method="post" action="">
				  	<div class="form-group">
					    <label class="control-label col-sm-2" for="idx">게시물ID:</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="idx" name="idx" placeholder="자동발번" value="${boardVO.idx}">
					    </div>
				  	</div>
				  	<div class="form-group">
					    <label class="control-label col-sm-2" for="title">제목:</label>
					    <div class="col-sm-10">
					      	<input type="text" class="form-control" id="title" name="title" placeholder="제목 입력" maxlength="100" value="${ boardVO.title}">
					    </div>
				  	</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="writer">작성자 / 작성일:</label>
						<div class="col-sm-10">
						    <input type="hidden" class="form-control" id="writer" name="writer" placeholder="등록자 입력" maxlength="15" style="float:left; width:30%" value="${ boardVO.writer}">
						    <input type="text" class="form-control" id="writerNm" name="writerNm" placeholder="등록자 입력" maxlength="15" style="float:left; width:30%" value="${ boardVO.writerNm}">
						    <input type="text" class="form-control" id="indate" name="indate" placeholder="등록일 입력" maxlength="10" style="float:left; width:30%" value="${ boardVO.indate}">
						</div>
					</div>
				  	<div class="form-group">
					    <label class="control-label col-sm-2" for="contents">내용:</label>
					    <div class="col-sm-10">
					    	<textarea class="form-control" rows="5" id="contents" name="contents" maxlength="1000">${ boardVO.contents}</textarea>
					    </div>
				  	</div>
				</form>
	        </div>
	        <div class="panel-footer" style="background-color:#d9edf7; text-align:right;">
	        	<!-- 로그인한 경우만 게시물 등록, 수정할 수 있음 -->
				<c:if test="${!empty sessionScope.user_id }">
					<!-- 게시물ID가 null이면 등록가능 -->
					<c:if test="${empty boardVO.idx }">
						<button type="button" class="btn btn-info" onclick="register();">등록</button>
					</c:if>
					<!-- 게시물ID가 존재하면 수정가능 -->
					<c:if test="${!empty boardVO.idx }">
						<button type="button" class="btn btn-info" onclick="mod();">수정</button>
					</c:if>
				</c:if>
				<button type="button" class="btn btn-info" onclick="cancel();">취소</button>
	        </div>
	    </div>
    </div>
</body>
</html>
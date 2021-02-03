<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>SignUp</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'/>">
	<script src="<c:url value='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'/>"></script>
	<script src="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'/>"></script>
	<script type="text/javaScript" language="javascript" defer="defer">
	
	$(document).ready(function(){
		
	});
	
	/* 회원가입 */
	function add(){
		
		/* 아이디 미입력인 경우 */
		if($('#user_id').val() == ''){
			alert("아이디를 입력하세요.");
			$('#user_id').focus();
			return;
		}
		
		/* 비밀번호 미입력인 경우 */
		if($('#password').val() == ''){
			alert("비밀번호를 입력하세요.");
			$('#password').focus();
			return;
		}
		
		/* 닉네임 미입력인 경우 */
		if($('#user_name').val() == ''){
			alert("닉네임을 입력하세요.");
			$('#user_name').focus();
			return;
		}
		
		/* 등록확인창 */
		if( !confirm("회원가입 하시겠습니까?")){
			return;
		}
		
		document.formSignUp.action = "<c:url value='/boardSignUp.do'/>";
		document.formSignUp.submit();
	}
	
	/* 회원가입 취소 */
	function cancel(){
		location.href="<c:url value='/boardList.do'/>";
	}
	
	</script>
</head>
<body>
	<div class="container">
		<h1>Sign Up</h1>	
		<div class="panel panel-info">
	        <div class="panel-heading" style="text-align:right;">
	        	<h5>*개인정보는 보안이 중요합니다.</h5>
	        </div>
	        <!-- 회원가입 -->
	        <div class="panel-body">
			    <form id="formSignUp" class="form-horizontal" method="post">
			    	<div class="form-group">
					    <label class="control-label col-sm-2" for="user_id">ID:</label>
					    <div class="col-sm-10">
					        <input type="text" class="form-control" id="user_id" name="user_id">
					    </div>
					</div>
					<div class="form-group">
					    <label class="control-label col-sm-2" for="user_name">name:</label>
					    <div class="col-sm-10">
					        <input type="text" class="form-control" id="user_name" name="user_name">
					    </div>
					</div>
					<div class="form-group">
					    <label class="control-label col-sm-2" for="password">Password:</label>
					    <div class="col-sm-10">
					        <input type="password" class="form-control" id="password" name="password">
					    </div>
					</div>
				</form>
	        </div>
	        <div class="panel-footer" style="background-color:#d9edf7; text-align:right;">
	        	<!-- 회원등록 -->
				<button type="button" class="btn btn-default" onclick="add();">회원등록</button>
				<button type="button" class="btn btn-default" onclick="cancel();">취소</button>
	        </div>
	    </div>
    </div>
</body>
</html>
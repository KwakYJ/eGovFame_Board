<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'/>">
	<script src="<c:url value='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'/>"></script>
	<script src="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'/>"></script>
	<script type="text/javaScript" language="javascript" defer="defer">
	
	$(document).ready(function(){
		/* 로그인 시 정보가 올바르지 않다고 알리는 msg */
		<c:if test="${!empty msg}">
			alert("${msg}");
		</c:if>
	});
	
	/* 게시글 등록 화면으로 이동 */
	function register(){
		location.href="<c:url value='/boardRegister.do'/>";
	}
	
	/* 게시물 보는 화면으로 이동 */
	function view(idx){
		location.href="<c:url value='/boardView.do'/>?idx="+idx;
	}
	
	/* 선택된 사용자의 비밀번호 호출  */
	function setPwd(user_id){
		if(user_id == "admin"){
			$('#password').val('manager');
		}
		else if(user_id == "guest1"){
			$('#password').val('guest1');
		}
		else if(user_id == "guest2"){
			$('#password').val('guest2');
		}
	}
	
	/* 로그인 정보가 입력되었는지 검사 */
	function check(){
		if($('#user_id').val() == ''){
			alert("아이디를 입력하세요.");
			return false;
		}	
		if($('#password').val() == ''){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		
		return true; // 모든 정보가 입력 되었으면 return true;
	}
	
	/* 로그아웃 */
	function logout(){
		location.href="<c:url value='/logout.do'/>";
	}
	
	/* 회원가입 */
	function signUp(){
		location.href="<c:url value='/boardSignUp.do'/>";
	}
	
	/* 페이징 */
	function page(pageNo){
    	location.href="<c:url value='/boardList.do'/>?pageIndex="+pageNo;
    }
	
	</script>
</head>
<body>
	<div class="container">
		<h1>Board List</h1>	
		<div class="panel panel-info">
			<!-- 로그인 -->
	        <div class="panel-heading" style="text-align:right;">
	        	<!--  -->
	        	<c:if test="${sessionScope == null || sessionScope.user_id == null || sessionScope.user_id == ''}">
			        <form class="form-inline" method="post" action="<c:url value='/login.do'/>">
						<div class="form-group">
						  	<!-- <label for="use_id">ID:</label>
						    <select class="form-control" id="user_id" name="user_id" onchange="setPwd(this.value);">
							    <option value="">선택</option>
							    <option value="admin">관리자</option>
							    <option value="guest1">사용자1</option>
							    <option value="guest2">사용자2</option>
							</select> -->
							<div class="form-group">
						    	<label for="user_id">ID:</label>
						    	<input type="text" class="form-control" id="user_id" name="user_id">
							</div>
						</div>
						<div class="form-group">
						    <label for="password">Password:</label>
						    <input type="password" class="form-control" id="password" name="password">
						</div>
						<button type="submit" class="btn btn-default" onclick="return check();">로그인</button>
					</form>
				</c:if>
				<!--  -->
				<c:if test="${sessionScope != null && sessionScope.user_id != null && sessionScope.user_id != ''}">
					${ sessionScope.user_name}님 환영합니다.
					<button type="button" class="btn btn-default" onclick="logout();">로그아웃</button>
				</c:if>	
	        </div>
	        <!-- 게시판 -->
	        <div class="panel-body">
	        	<!-- 검색 -->
	        	<div class="form-group" style="text-align:right;">
	        	<form class="form-inline" method="post" action="<c:url value='/boardList.do'/>">
					<div class="form-group">
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="제목으로 검색">
					</div>
					<button type="submit" class="btn btn-default">검색</button>
				</form>
				</div>
				<!-- 목록 -->
				<div class="table-responsive">
		        	<table class="table table-hover">
					    <thead>
					      	<tr>
					        	<th>게시물 번호</th>
					        	<th>제목</th>
					        	<th>조회수</th>
					        	<th>작성자</th>
					        	<th>작성일</th>
					      	</tr>
					    </thead>
					    <tbody>
					    	<!--  -->
						    <c:forEach var="result" items="${resultList}" varStatus="status">
						      	<tr>
						        	<td><a href="javascript:view('${result.idx}');"><c:out value="${result.idx}"/></a></td>
						        	<td><a href="javascript:view('${result.idx}');"><c:out value="${result.title}"/></a></td>
						        	<td><c:out value="${result.count}"/></td>
						        	<td><c:out value="${result.writerNm}"/></td>
						        	<td><c:out value="${result.indate}"/></td>
						      	</tr>
						    </c:forEach>
					    </tbody>
					</table>
				</div>
				<div id="paging" style="text-align:center">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="page"/>
        		</div>
	        </div>
	        <div class="panel-footer" style="background-color:#d9edf7; text-align:right;">
	        	<!-- 로그인 되어있으면 게시물 등록 가능 -->
				<c:if test="${!empty sessionScope.user_id }">
					<button type="button" class="btn btn-default" onclick="register();">등록</button>
				</c:if>
				<c:if test="${empty sessionScope.user_id }">
					<button type="button" class="btn btn-default" onclick="signUp();">회원가입</button>
				</c:if>
	        </div>
	    </div>
    </div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    /* 치환 변수 선언 */
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>boardView</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'/>">
	<script src="<c:url value='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'/>"></script>
	<script src="<c:url value='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'/>"></script>
	<script type="text/javaScript" language="javascript" defer="defer">
	
	/* 게시판으로 이동 */
	function list(){
		location.href="<c:url value='/boardList.do'/>";
	}
	
	/* 댓글 입력 */
	function boardReply(){
		
		/* 작성자가 미입력시 */
		if($('#writer').val() == ''){
			alert("작성자를 입력하세요.");
			$('#writer').focus();
			return;
		}
		
		/* 댓글 미입력시 */
		if($('#reply').val() == ''){
			alert("댓글을 입력하세요.");
			$('#reply').focus();
			return;
		}
		
		/* 댓글확인창 */
		if( !confirm("댓글 입력 하시겠습니까?")){
			return;
		}
		
		/* 댓글 등록 */
		document.form2.action = "<c:url value='/reply.do'/>?idx=${boardVO.idx}";
		document.form2.submit();
	}
	
	/* 게시물 수정 화면으로 이동 */
	function mod(){
		location.href="<c:url value='/boardRegister.do'/>?idx=${boardVO.idx}";
	}
	
	/* 게시물 삭제 */
	function del(){
		
		/* 삭제확인창 */
		if( !confirm("삭제 하시겠습니까?")){
			return;
		}
		
		/* 게시물 삭제 */
		document.form1.action = "<c:url value='/boardRegister.do'/>?mode=del&idx=${boardVO.idx}";
		document.form1.submit();
	}
	
	</script>
</head>
<body>
	<div class="container">
		<h1>View</h1>
		<div class="panel panel-info">
			<!-- 로그인 정보 -->
	        <div class="panel-heading">
	        	<label for="">${sessionScope.user_name}님이 로그인했습니다.</label>
	        </div>
	        <!-- 게시물 상세화면 -->
	        <div class="panel-body">
	        	<form id="form1" name="form1" class="form-horizontal" method="post" action="">
				    <div class="form-group">
					    <label class="control-label col-sm-2" for="">게시물ID:</label>
					    <div class="col-sm-10 control-label" style="text-align:left;">
					        <c:out value="${boardVO.idx}"/>
					    </div>
				    </div>
				    <div class="form-group">
					    <label class="control-label col-sm-2" for="">제목:</label>
					    <div class="col-sm-10 control-label" style="text-align:left;">
					        <c:out value="${boardVO.title}"/>
					    </div>
				    </div>
				    <div class="form-group">
					    <label class="control-label col-sm-2" for="">등록자 / 등록일:</label>
					    <div class="col-sm-10 control-label" style="text-align:left;">
					       <c:out value="${boardVO.writerNm}"/> / <c:out value="${boardVO.indate}"/>
					    </div>
				    </div>
				    <div class="form-group">
					    <label class="control-label col-sm-2" for="">내용:</label>
					    <div class="col-sm-10 control-label" style="text-align:left;">
					        <c:out value="${fn:replace(boardVO.contents, crcn, br)}" escapeXml="false"/>
					    </div>
				    </div>
				</form>
	        </div>
	        <div class="panel-footer" style="background-color:#d9edf7; text-align:right;">
	        	<!-- (로그인 == true) and (로그인ID == 작성자)인 경우만 게시물 수정, 삭제 가능  -->
				<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == boardVO.writer}">
					<button type="button" class="btn btn-info" onclick="mod();">수정</button>
					<button type="button" class="btn btn-info" onclick="del();">삭제</button>
				</c:if>
				<button type="button" class="btn btn-info" onclick="list();">목록</button>
	        </div>
	    </div>
	    <!-- 댓글 목록 -->
	    <!--  -->
	    <c:forEach var="result" items="${resultList}" varStatus="status">
	    	<div class="well well-sm" style="background-color:#fff;">
	    		<b>닉네임:[</b><c:out value="${result.writer}"/><b>] / 작성일:[</b><c:out value="${result.indate}"/><b>]</b><br/>
	    		<c:out value="${fn:replace(result.reply, crcn, br)}" escapeXml="false"/>
	    	</div>
	    </c:forEach>
	    <!-- 댓글 작성 부분 -->
	    <div class="well well-lg" style="background-color:#d9edf7;">
	    	<form id="form2" name="form2" class="form-horizontal" method="post" action="">
	    		<div class="form-group">
				    <label class="control-label col-sm-2" for="">작성자:</label>
				    <div class="col-sm-10 control-label" style="text-align:left;">
				        <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자 입력" maxlength="15" style="float:left; width:30%" value="${sessionScope.user_name}">
				        <%-- <input type="text" class="form-control" id="indate" name="indate" placeholder="작성일 입력" maxlength="10" style="float:left; width:30%" readonly value="${strToday}"> --%>
				    </div>
				</div>
				<div class="form-group">
				    <label class="control-label col-sm-2" for="reply">댓글입력:</label>
				    <div class="col-sm-10">
				        <textarea class="form-control" rows="3" id="reply" name="reply" maxlength="300"></textarea>
				    </div>
				</div>
				<div class="form-group" style="text-align:right;">
					*비로그인도 댓글 작성이 가능하기 때문에 따로 수정이나 삭제는 불가능*
					<button type="button" class="btn btn-default" onclick="boardReply();">등록</button>
				</div>
	    	</form>
	    </div>
    </div>
</body>
</html>
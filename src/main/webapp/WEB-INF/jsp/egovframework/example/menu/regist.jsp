<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부트스트랩 웹 페이지</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty msg }">
	<script type="text/javascript">
		alert("${msg}")
	</script>
</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	<div class="container mt-5">
		<h3>권한 등록</h3>
		<font color="red">*</font> 필수입력
		<br>
		<form action="/authorInfoRegist.do" method="post" id="saveFrm">
			<table border="1">
				<tr>
					<td>권한 코드 <font color="red">*</font></td>
					<td>
						<input type="text" value="${authorInfoVO.author_code }" name="author_code">
					</td>
				</tr>
				<tr>
					<td>권한 명 <font color="red">*</font></td>
					<td>
						<input type="text" required name="author_nm" value="${authorInfoVO.author_nm }">
					</td>
				</tr>
				<tr>
					<td>설명 <font color="red">*</font></td>
					<td>
						<textarea rows="" cols="" required name="author_dc" id="clCodeDc"><c:out value="${authorInfoVO.author_dc }"/></textarea>
					</td>
				</tr>
				<tr>
					<td>등록일자 <font color="red">*</font></td>
					<td>
						<input type="date" id="authorCreatDe" name="author_creat_de" value="${authorInfoVO.author_creat_de }" required>
					</td>
				</tr>
			</table>
		</form>
		<hr>
		<button id="saveBtn" class="btn btn-primary">등록</button>
		<button id="listBtn" class="btn btn-light">목록</button>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function(){
	const saveBtn = $('#saveBtn');
	const listBtn = $('#listBtn');
	
	
	$(saveBtn).on('click',function(event){
		// 입력값 검증 해야함 원래는
		$('#saveFrm')[0].submit();
	});
	
	
	$(listBtn).on('click',function(){
		location.href = "/authManagement.do";
	});
	
})
</script>
</html>
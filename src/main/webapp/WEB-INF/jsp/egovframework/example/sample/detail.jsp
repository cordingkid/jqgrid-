<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<c:if test="${not empty addSuccessMSg }">
		<script type="text/javascript">
			alert("${addSuccessMSg}");
		</script>
	</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	<div class="container mt-5">
		<h3>공통분류코드 상세조회</h3>
		<table>
			<tr>
				<td>분류코드명</td>
				<td>${clCodeVO.cl_code_nm }</td>
			</tr>
			<tr>
				<td>분류코드</td>
				<td>${clCodeVO.cl_code }</td>
			</tr>
			<tr>
				<td>분류코드설명</td>
				<td>
					<textarea rows="" cols="" readonly><c:out value="${clCodeVO.cl_code_dc }"/></textarea>
				</td>
			</tr>
			<tr>
				<td>사용여부</td>
				<td>
					<c:if test="${clCodeVO.use_at eq 'Y'}">
						<c:set var="useAt" value="Yes"/>
					</c:if>
					<c:if test="${clCodeVO.use_at eq 'N'}">
						<c:set var="useAt" value="No"/>
					</c:if>
					<input type="text" value="${useAt}" disabled>
				</td>
			</tr>
		</table>
		<form action="/delete.do" method="post" id="delFrm">
			<input type="hidden" name="cl_code" value="${clCodeVO.cl_code}">
		</form>
		<hr>
		<button id="modifyBtn">수정</button>
		<button id="deleteBtn">삭제</button>
		<button id="listBtn">목록</button>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function(){
	const clCode = "${clCodeVO.cl_code }";
	const modifyBtn = $('#modifyBtn');
	const deleteBtn = $('#deleteBtn');
	const listBtn = $('#listBtn');
	const delFrm = $('#delFrm');
	
	
	$(modifyBtn).on('click',function(){
		console.log("수정버튼")	
		location.href = "/updateForm.do?clCode=" + clCode;
	});

	
	$(deleteBtn).on('click',function(){
		console.log("삭제버튼")	
		if(confirm("해당 데이터를 삭제 하시겠습니까?")){
			delFrm[0].submit();
		}
	});
	
	
	$(listBtn).on('click',function(){
		console.log("목록버튼")	
		location.href = "/test.do";
	});
})
</script>
</html>
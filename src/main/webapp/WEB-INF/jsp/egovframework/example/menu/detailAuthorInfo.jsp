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
<style>
.authInfoTable tr td:FIRST-CHILD{
	background-color: #eff0f1;
}
</style>
</head>
<body>
	<c:if test="${not empty msg }">
		<script type="text/javascript">
			alert("${msg}");
		</script>
	</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	<div class="container mt-5">
		<h3>권한 수정</h3>
		<form action="/authorInfoModify.do" method="post" id="authInfoFrm">
			<table border="1" class="authInfoTable">
				<tr>
					<td>권한 코드</td>
					<td>
						<input type="text" value="${authorInfoVO.author_code }" name="author_code" style="background-color: #dddddd;" readonly>
					</td>
				</tr>
				<tr>
					<td>권한 명</td>
					<td>
						<input type="text" value="${authorInfoVO.author_nm }" name="author_nm">
					</td>
				</tr>
				<tr>
					<td>설명</td>
					<td>
						<textarea rows="" cols="" name="author_dc"><c:out value="${authorInfoVO.author_dc }"/></textarea>
					</td>
				</tr>
				<tr>
					<td>등록일자</td>
					<td>
						<input type="date" id="authorCreatDe" name="author_creat_de" value="${authorInfoVO.author_creat_de }">
					</td>
				</tr>
			</table>
		</form>
		<form action="/deleteAuthorInfo.do" method="post" id="delFrm">
			<input type="hidden" name="author_code" value="${authorInfoVO.author_code}">
		</form>
		<hr>
		<button id="modifyBtn" class="btn btn-primary">수정</button>
		<button id="deleteBtn" class="btn btn-danger">삭제</button>
		<button id="listBtn" class="btn btn-light">목록</button>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
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
	var sendData = {};
	
	
	$(modifyBtn).on('click',function(){
		if (confirm("저장 하시겠습니까?")) {
			$('#authInfoFrm')[0].submit();
		}
	});

	
	$(deleteBtn).on('click',function(){
		if(confirm("해당 데이터를 삭제 하시겠습니까?")){
			delFrm[0].submit();
		}
	});
	
	
	$(listBtn).on('click',function(){
		location.href = "/authManagement.do";
	});
})
</script>
</html>
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
	<c:set var="state" value="등록"/>
	<c:if test="${status eq 'u' }">
		<c:set var="state" value="상세수정"/>
	</c:if>
	<c:if test="${not empty error }">
		<script type="text/javascript">
			alert("${error}")
		</script>
	</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	<div class="container mt-5">
		<h3>공통분류코드 ${state }</h3>
		<font color="red">*</font> 필수입력
		<br>
		<form action="/saveClCode.do" method="post" id="saveFrm">
			<table>
				<tr>
					<td>분류코드명 <font color="red">*</font></td>
					<td>
						<input type="text" value="${clCodeVO.cl_code_nm }" name="cl_code_nm">
					</td>
				</tr>
				<tr>
					<td>분류코드 <font color="red">*</font></td>
					<td>
						<c:if test="${not empty status}">
							${clCodeVO.cl_code }
							<input type="hidden" value="${clCodeVO.cl_code }" name="cl_code">
						</c:if>
						<c:if test="${empty status}">
							<input type="text" value="" name="cl_code" maxlength="3">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>분류코드설명 <font color="red">*</font></td>
					<td>
						<textarea rows="" cols="" name="cl_code_dc" id="clCodeDc"><c:out value="${clCodeVO.cl_code_dc }"/></textarea>
					</td>
				</tr>
				<tr>
					<td>사용여부 <font color="red">*</font></td>
					<td>
						<select id="selectBox" name="use_at">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<hr>
		<button id="saveBtn">저장</button>
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
	const saveBtn = $('#saveBtn');
	const listBtn = $('#listBtn');
	const clCodeDc = $('#clCodeDc');
	const saveFrm = $('#saveFrm');
	var useAt = "${clCodeVO.use_at}";
	var state = "${state }";
	
	
	
	$(clCodeDc).on('keyup', function(){
		console.log($(this).val().length)
		//원래 바이트 수 체크 해서 200 안넘게 해야함 
	});
	
	
	
	$(saveBtn).on('click',function(){
		console.log("저장버튼")
		if (state == "등록") {
			saveFrm[0].action = "/addClCodeProcess.do";
		}
		saveFrm[0].submit();
	});
	
	
	$(listBtn).on('click',function(){
		console.log("목록버튼")	
		location.href = "/test.do";
	});
	
	checkSelectBox();
	
	function checkSelectBox(){
		console.log(useAt);
		if (useAt == "Y") {
			$('#selectBox option:eq(1)').prop('selected', true);	
		}else{
			$('#selectBox option:eq(0)').prop('selected', true);
		}
	}
	
})
</script>
</html>
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
		<h3>공통코드 ${state }</h3>
		<font color="red">*</font> 필수입력
		<hr>
		<form action="/saveCommCode.do" method="post" id="saveFrm">
			<table>
				<tr>
					<td>분류코드명 <font color="red">*</font></td>
					<td>
						<c:if test="${empty status }">
							<select id="clCode" name="cl_code">
								<c:forEach items="${clCodeList }" var="clCode">
									<option value="${clCode.cl_code }">${clCode.cl_code_nm }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${not empty status }">
							${codeVO.cl_code_nm }
						</c:if>
					</td>
				</tr>
				<tr>
					<td>코드ID <font color="red">*</font></td>
					<td>
						<input type="text" name="code_id" value="${codeVO.code_id }" id="code_id" readonly="readonly" style="background-color: #dddddd;">
					</td>
				</tr>
				<tr>
					<td>코드ID명 <font color="red">*</font></td>
					<td>
						<input type="text" name="code_id_nm" value="${codeVO.code_id_nm }" id="codeIdNm">
					</td>
				</tr>
				<tr>
					<td>코드ID설명 <font color="red">*</font></td>
					<td>
						<textarea rows="" cols="" name="code_id_dc" id="codeIdDc"><c:out value="${codeVO.code_id_dc }"/></textarea>
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
		<button id="saveBtn" class="btn btn-primary">저장</button>
		<button id="listBtn" class="btn btn-info">목록</button>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function(){
	const codeId = "${codeVO.code_id }";
	const saveBtn = $('#saveBtn');
	const listBtn = $('#listBtn');
	const clCodeDc = $('#clCodeDc');
	const saveFrm = $('#saveFrm');
	var useAt = "${codeVO.use_at}";
	var state = "${state }";
	
	var sendData = {};
	
	
	
	
	$(saveBtn).on('click',function(){
		if (state == "상세수정") {
			saveFrm[0].action = "/uptCommCode.do";
		}
		saveFrm[0].submit();
	});
	
	
	$(listBtn).on('click',function(){
		console.log("목록버튼")	
		location.href = "/test2.do";
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
	
	getAutoPk();
	
	function getAutoPk(){
		sendData.cl_code = $('#clCode').val(); 
		console.log(sendData);
		$.ajax({
			url: "/getAutoPrimaryKey.do",
			data: sendData,
			dataType: "text",
			success: function(res) {
				if (res.length == 6) {
					$('#code_id').val(res);
				}
				console.log(res);
			},
			error: function(err) {
				console.log(err.statusText)
			}
		});
	}
	
	$('#clCode').on('change', function() {
		getAutoPk();
	})
	
})
</script>
</html>
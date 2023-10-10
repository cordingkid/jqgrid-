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
		<h3>공통상세코드 ${state }</h3>
		<font color="red">*</font> 필수입력
		<hr>
		<form action="/detailCodeRegistProcess.do" method="post" id="saveFrm">
			<table>
				<tr>
					<td>코드ID <font color="red">*</font></td>
					<td>
						<c:if test="${empty status }">
							<select id="clCode" name="cl_code">
								<c:forEach items="${clCodeList }" var="clCode">
									<option value="${clCode.cl_code }">${clCode.cl_code_nm }</option>
								</c:forEach>
							</select>
							<select id="codeId" name="code_id">
							</select>
						</c:if>
						<c:if test="${not empty status }">
							${detailCodeVO.code_id_nm }
						</c:if>
					</td>
				</tr>
				<tr>
					<td>코드 <font color="red">*</font></td>
					<td>
						<input type="text" name="code" value="${detailCodeVO.code }" id="code" readonly="readonly" style="background-color: #dddddd;">
					</td>
				</tr>
				<tr>
					<td>코드명 <font color="red">*</font></td>
					<td>
						<input type="text" name="code_nm" value="${detailCodeVO.code_nm }" id="codeNm">
					</td>
				</tr>
				<tr>
					<td>코드설명 <font color="red">*</font></td>
					<td>
						<textarea rows="" cols="" name="code_dc" id="codeDc"><c:out value="${detailCodeVO.code_dc }"/></textarea>
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
	const code = "${detailCodeVO.code }";
	const saveBtn = $('#saveBtn');
	const listBtn = $('#listBtn');
	const clCodeDc = $('#clCodeDc');
	const saveFrm = $('#saveFrm');
	var useAt = "${detailCodeVO.use_at}";
	var state = "${state }";
	
	var sendData = {};
	
	
	
	
	$(saveBtn).on('click',function(){
		if (state == "상세수정") {
			saveFrm[0].action = "/updateDetailCodeProcess.do";
		}
		saveFrm[0].submit();
	});
	
	
	$(listBtn).on('click',function(){
		console.log("목록버튼")	
		location.href = "/test3.do";
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
	
	
	
	function getAutoPk(){
		sendData.code = $('#codeId').val(); 
		console.log("전송데이터", sendData);
		$.ajax({
			url: "/getAutoPrimaryKeyDetailCode.do",
			data: sendData,
			dataType: "text",
			success: function(res) {
// 				console.log("오토 피케잇", res);
				$('#code').val(res);
			},
			error: function(err) {
				console.log(err.statusText)
			}
		});
	}
	
	$('#codeId').on('change', function() {
		getAutoPk();
	})
	
	getCommCodeData();
	
	
	$('#clCode').on('change', function() {
		getCommCodeData();
	});
	
	function getCommCodeData() {
		if (state == "상세수정") {
			return false;	
		}
		sendData.cl_code = $('#clCode').val();
		$.ajax({
			url: "/getCommCodeList.do",
			data: sendData,
			dataType: 'json',
			contentType: 'application/json;charset=utf-8',
			success: function(res) {
				console.log(res);
				var str = "";
				res.forEach((v, i) => {
					str += `<option value="\${v.code_id}">\${v.code_id_nm}</option>`;
				});
				$('#codeId').html(str);
				getAutoPk();
			},
			error: function(err) {
				console.log(err.statusText)
			}
		});
	}
	
})
</script>
</html>
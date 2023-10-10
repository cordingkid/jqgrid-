<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부트스트랩 웹 페이지</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- jqGrid 세팅 -->
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
	<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>    
    <!-- jqGrid 세팅 -->
    
<title>Insert title here</title>
<style type="text/css">
.searchDiv{
	text-align: center;
	background-color: rgb(10,10,10,0.1); 
	border: 3px solid black;
	border-radius: 20px;
	padding: 2px;
}
</style>
</head>
<body>
	<c:if test="${not empty msg}">
		<script type="text/javascript">
			alert("${msg}");
		</script>
	</c:if>
	<c:if test="${not empty noData}">
		<script type="text/javascript">
			alert("${noData}");
		</script>
	</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	
	<div class="container mt-5">
		<h3>공통코드상세</h3>
		<div class="row mb-3 searchDiv">
			<div class="col-sm-9">
				<div class="row row-cols-4">
					<div class="col">
						분류코드명		
					</div>
					<div class="col">
						<select id="clCode">
							<option value="">:::선택:::</option>
							<c:forEach items="${clCodeList }" var="clCode">
								<option value="${clCode.cl_code}">${clCode.cl_code_nm}</option>
							</c:forEach>
						</select>	
					</div>
					<div class="col">
						코드ID명
					</div>
					<div class="col">
						<select id="codeId">
							<option value="">:::선택:::</option>
						</select>		
					</div>
					<div class="col">
						코드
					</div>
					<div class="col">
						<input type="text" id="code">	
					</div>
					<div class="col">
						코드명
					</div>
					<div class="col">
						<input type="text" id="codeNm">	
					</div>
				</div>
				
			</div>
			<div class="col-sm-3">
				<button class="btn btn-primary" id="searchBtn">검색</button>
				<button type="button" id="resetSearchBtn" class="btn btn-light btn-sm">검색 초기화</button>
			</div>
		</div>
		<h6>공통상세코드 리스트</h6>
		<span>총 <font id="ttlCnt" color="red"> </font>건</span>
		<table id="list"></table>
		<div id="pager"></div>
		<hr>
		<div class="row" style="padding-left: 95%">
			<button id="addBtn" class="btn btn-primary">등록</button>
		</div>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function() {
	var sendData = {};
	       	$("#list").jqGrid({
	       		url : "/detailCodeList.do",
	       		datatype: "json",
	       		mtype: "get",
	       		colNames:['상세조회', '코드ID', '코드', '코드명', '사용여부'],
	       		colModel:[
	       			{name:'infoBtn', index:'infoBtn', width:90, align: "center", sortable:false, formatter:formatOpt},
	       			{name:'code_id', index:'code_id', width:100 , align: "center", sortable:false},
	       			{name:'code', index:'code', width:150, align: "center"}, // ,sortable:false 
	       			{name:'code_nm', index:'code_nm', width:150, align: "center"}, // ,sortable:false 
	       			{name:'use_at', index:'use_at', width:80, align: "center", sortable:false},
	       		],
	       		autowidth: true,
	       		rownumbers : true,
	       		pager:'#pager',
	       		rowNum: 5,
	       		loadonce : true,
// 	       		viewrecords : true,
	       		rowList: [5, 10, 20],
	       		emptyrecords : "데이터가 없습니다.",
// 	       		sortname: 'cl_code_nm',
// 	       		sortorder: 'asc',
	       		height: 'auto',
	       		hoverrows: false, // 행에 마우스를 올렸을 때의 강조 효과 비활성화
	       		beforeSelectRow: function () {
	    	        return false; // 행 선택을 막음
	    	    },
	    	    loadComplete: function(data) {
	    	    	$('#ttlCnt').text(data.length);
	    	    }
	       	});
	       	
	       	function formatOpt(cellvalue, options, rowObject){
	       		var str = "";
	       		var row_id = options.rowId;
	       		var idx = rowObject.idx;
	       		
	       		str += "<div class=\"btn-group\">";
	    		str += `<a href="/detailCodeInfo.do?code=\${rowObject.code}">조회</a>`;
	    		str += "</div>";

	    		return str;
	       	}
	const addBtn = $('#addBtn');
	
	addBtn.on('click',function(){
		location.href = "/detatilCodeRegist.do";
	});
	
	function getCommCodeData() {
		sendData.cl_code = $('#clCode').val();
		$.ajax({
			url: "/getCommCodeList.do",
			data: sendData,
			dataType: 'json',
			contentType: 'application/json;charset=utf-8',
			success: function(res) {
				console.log(res);
				var str = `<option value="">:::선택:::</option>`;
				res.forEach((v, i) => {
					str += `<option value="\${v.code_id}">\${v.code_id_nm}</option>`;
				});
				$('#codeId').html(str);
			},
			error: function(err) {
				console.log(err.statusText)
			}
		});
	}
	
	$('#clCode').on('change', function() {
		getCommCodeData();
	});
	
	
	$('#searchBtn').on('click', function() {
		sendData.cl_code = $('#clCode').val()
		sendData.code_id = $('#codeId').val();
		sendData.code = $('#code').val();
		sendData.code_nm = $('#codeNm').val();
		
		console.log(sendData)
// 		return false;
		$("#list").jqGrid("clearGridData", true);
		
		$("#list").setGridParam({
			datatype : "json",
			postData : sendData,
			loadComplete : function(data) {
				$('#ttlCnt').text(data.length);
			}
		}).trigger("reloadGrid");
	});
	
	$('#resetSearchBtn').on('click', function() {
		$('#code').val("");
		$('#codeNm').val("");
		$('#codeId').val("");
	});
	
});
</script>
</html>
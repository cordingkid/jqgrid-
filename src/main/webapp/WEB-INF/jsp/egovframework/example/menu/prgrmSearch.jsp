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
    
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
	<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>
<title>Insert title here</title>
<style>
.container{
	padding: 10px;
	margin: 10px;
}
.authorCodeDiv{
	border-bottom: 1px solid #e5e6e6;
	border-top: 1px solid #e5e6e6;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
				<h4>프로그램파일명 검색</h4>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<div class="row" style="border: 1px solid black;">
					<div class="col-4">
						프로그램명
					</div>
					<div class="col-8">
						<input type="text" id="progrmKoreanNm">
						<button id="searchBtn" class="btn btn-secondary">검색</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row mt-3" style="border-top: 2px solid black; height: 500px; overflow: scroll;">
			<div class="col" style="padding: 10px;">
				<h6>프로그램 목록</h6>
				<span>총 <font id="ttlCnt" color="red"></font>건</span>
				<table id="list"></table>
				<div id="pager"></div>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col" style="padding: 10px; border-top: 1px dotted;">
				<button onclick="fnExit();" class="btn btn-secondary" style="margin-left: 48%;">닫기</button>
			</div>
		</div>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function () {
	var sendData = {};
	$("#list").jqGrid({
   		url : "/getPrgrmList.do",
   		datatype: "json",
//    		datatype: "local",
   		mtype: "get",
   		colNames:['프로그램 파일명', '프로그램명'],
   		colModel:[
   			{name:'progrm_file_nm', index:'progrm_file_nm', width:90, align: "center", sortable:false, formatter:formatOpt},
   			{name:'progrm_korean_nm', index:'progrm_korean_nm', width:100, align: "center", sortable:false},
   		],
   		autowidth: true,
   		rownumbers : true,
   		pager:'#pager',
   		rowNum: 5,
   		loadonce : true,
   		rowList: [5, 10, 20],
   		emptyrecords : "데이터가  없습니다.",
   		height: 'auto',
   		hoverrows: false, // 행에 마우스를 올렸을 때의 강조 효과 비활성화
	    loadComplete: function(data) {
	    	$('#ttlCnt').text(data.length);
	    }
   	});
   	
   	function formatOpt(cellvalue, options, rowObject){
   		var str = "";
   		var row_id = options.rowId;
   		var idx = rowObject.idx;
   		
   		str += "<div class=\"btn-group\">";
		str += `<a href="#" onclick="getProgrmFileNm(this);">\${rowObject.progrm_file_nm}</a>`;
		str += "</div>";

		return str;
   	}
   	
   	
	const addBtn = $('#addBtn');
	
	addBtn.on('click',function(){
	location.href = "/authorInfoRegist.do";
	});
	
	
	
	$('#searchBtn').on('click', function() {
		sendData.progrm_korean_nm = $('#progrmKoreanNm').val();
		$("#list").jqGrid("clearGridData", true);
		
		$("#list").setGridParam({
			datatype : "json",
			postData : sendData,
			loadComplete : function(data) {
				$('#ttlCnt').text(data.length);
			}
		}).trigger("reloadGrid");
	});
});

function getProgrmFileNm(obj) {
	opener.document.querySelector('#progrmFileNm').value = obj.text.trim(); 
	window.close();
}

function fnExit() {
	window.close();
}
</script>
</html>
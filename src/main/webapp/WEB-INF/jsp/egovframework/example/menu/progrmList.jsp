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
table {
	text-align: center;
}
thead {
	border-top: 2px solid black;
}
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
	<c:if test="${not empty msg }">
		<script type="text/javascript">
			alert("${msg}");
		</script>
	</c:if>
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	
	<div class="container mt-5">
		<h3>프로그램관리</h3>
		<div class="row mb-3 searchDiv">
			<div class="col-sm-9">
				<div class="row">
					<div class="col">
						프로그램명	
					</div>
					<div class="col">
						<input type="text" id="progrmKoreanNm">	
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<button class="btn btn-primary" id="searchBtn">검색</button>
				<button type="button" id="resetSearchBtn" class="btn btn-light btn-sm">검색 초기화</button>
			</div>
		</div>
		<h6>권한 관리</h6>
		<span>총 <font id="ttlCnt" color="red"></font>건</span>
		<table id="list"></table>
		<div id="pager"></div>
		<hr>
		<div class="row" style="padding-left: 85%">
			<button id="addBtn" class="btn btn-primary">등록</button>
			<button id="delBtn" class="btn btn-danger" style="margin-left: 20px;">삭제</button>
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
	       		url : "/getProgrmList.do",
	       		datatype: "json",
	       		mtype: "get",
	       		colNames:['상세조회', '프로그램파일명', '프로그램명', 'URL','프로그램설명'],
	       		colModel:[
	       			{name:'infoBtn', index:'infoBtn', width:90, align: "center", sortable:false, formatter:formatOpt},
	       			{name:'progrm_file_nm', index:'progrm_file_nm', width:100 , align: "center", sortable:false},
	       			{name:'progrm_korean_nm', index:'progrm_korean_nm', width:80, align: "center", sortable:false },
	       			{name:'url', index:'url', width:150, align: "center", sortable:false},
	       			{
	       				name:'progrm_dc', index:'progrm_dc', width:100, align: "center", sortable:false
// 	       				formatter: function (cellvalue, options, rowObject) {
// 	       	                if (cellvalue.length > 3) {
// 	       	                    return cellvalue.substring(0, 3) + '...';
// 	       	                } else {
// 	       	                    return cellvalue;
// 	       	                }
// 	       	            },
// 	       	            cellattr: function (rowId, cellValue, rawObject, cm, rdata) {
// 	       	                return 'title="' + cellValue + '"'; // 생략된 부분을 title 속성으로 나타냅니다.
// 	       	            }
	       			},
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
	       		multiselect : true,
	    	    loadComplete: function(data) {
	    	    	$('#ttlCnt').text(data.length);
	    	    }
	       	});
	       	
	       	function formatOpt(cellvalue, options, rowObject){
	       		var str = "";
	       		var row_id = options.rowId;
	       		var idx = rowObject.idx;
	       		
	       		str += "<div class=\"btn-group\">";
	    		str += `<a href="/detailProgrmFileInfo.do?progrmFileNm=\${rowObject.progrm_file_nm}">조회</a>`;
	    		str += "</div>";

	    		return str;
	       	}
	       	
	const addBtn = $('#addBtn');
	
	addBtn.on('click',function(){
		location.href = "/progrmFileRegist.do";
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
	
	$('#resetSearchBtn').on('click', function() {
		$('#progrmKoreanNm').val("");
	});
	
	$('#delBtn').on('click', function() {
		var rowId = $('#list').jqGrid('getGridParam', 'selarrrow');
		var delAuthorInfoList = [];
		if (confirm("삭제 하시겠습니까?")) {
			for (var i = 0; i < rowId.length; i++) {
				var rowData = $("#list").jqGrid('getRowData', rowId[i]);
				delAuthorInfoList.push(rowData.author_code);
			}
		}
		$.ajax({
			url: "/authorInfoListDelete.do",
			async: false,
			type: "DELETE",
			data: JSON.stringify({list : delAuthorInfoList}),
			dataType: "text",
			contentType: "application/json;charset=utf-8",
			success: function(res) {
				if (res === "success") {
					alert("성공적으로 삭제 되었습니다.");
				}else if(res === "empty"){
					alert("삭제할 데이터를 선택해주세요.");
				}else if(res === "failed"){
					alert("서버 에러 다시 시도해주세요.");
				}
				location.reload();
			},
			error: function(err) {
				console.log("에러 : ", err.status);
			}
		});
	});
	
});
</script>
</html>
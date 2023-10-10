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
    
    <!-- jstree -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
    
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
.menuTable{
	text-align: left;
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
		<h3>메뉴리스트관리</h3>
		<form action="" id="menuListFrm" method="post">
			<div class="row" style="border: 1px solid blue;">
				<div class="col">
					<div class="row" style="border-bottom: 1px solid gray; text-align: center; justify-content: center; align-items: center;">
						<h6>메뉴목록</h6>
					</div>
					<div id="jstree" style="overflow: scroll; height: 600px;"></div>
				</div>
				<div class="col">
					<table class="menuTable" border="1" style="width: 100%; height: 100%;">
						<tr>
							<td>상위메뉴번호</td>
							<td>
								<input type="text" name="upper_menu_no" id="upperMenuNo">
								<button id="menuSearch" class="btn btn-secondary">검색</button>
								<font style="color: #3154af;">(메뉴선택 검색)</font>
							</td>
						</tr>
						<tr>
							<td>메뉴번호</td>
							<td>
								<input type="text" name="menu_no" id="menuNo" readonly style="background: #dddddd;">
							</td>
						</tr>
						<tr>
							<td>메뉴순서</td>
							<td>
								<input type="text" name="menu_ordr" id="menuOrdr">
							</td>
						</tr>
						<tr>
							<td>메뉴명</td>
							<td>
								<input type="text" name="menu_nm" id="menuNm">
							</td>
						</tr>
						<tr>
							<td>프로그램파일명</td>
							<td>
								<input type="text" name="progrm_file_nm" id="progrmFileNm" style="background: #dddddd" readonly="readonly">
								<button id="prgrmSearch" class="btn btn-secondary">검색</button>
								<font style="color: #3154af;">(프로그램파일명 검색)</font>
							</td>
						</tr>
						<tr>
							<td>이미지명</td>
							<td>
								<input type="text" name="relate_image_nm" id="relateImageNm">
							</td>
						</tr>
						<tr>
							<td>이미지경로</td>
							<td>
								<input type="text" name="relate_image_path" id="relateImagePath">
							</td>
						</tr>
						<tr>
							<td>메뉴설명</td>
							<td>
								<textarea rows="5" cols="50" name="menu_dc" id="menuDc"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;">
								<button id="initBtn" class="btn btn-secondary">초기화</button>
								<button id="saveBtn" class="btn btn-primary">저장</button>
								<button id="updateBtn" class="btn btn-primary">수정</button>
								<button id="delBtn" class="btn btn-danger">삭제</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
	<!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
$(function() {
	var checkSystem = false;
	const menuListFrm = $('#menuListFrm');
	getJstree();
	function getJstree() {
		$.ajax({
			type: "get",
			url: "/getMenuInfoList.do",
			dataType: "json",
			success: function(data) {
				console.log("data", data)
				var jsonData = new Array();
				
				$.each(data, (idx, item) => {
					if (item.upper_menu_no == 0) {
						item.upper_menu_no = '#';
					}
					jsonData[idx] = {
						id: item.menu_no, 
						parent: item.upper_menu_no, 
						text: item.menu_nm, 
						type: item.type,
						progrmFileNm: item.progrm_file_nm,
						relateImagePath: item.relate_image_path,
						relateImageNm: item.relate_image_nm,
						menuDc: item.menu_dc,
						menuOrdr: item.menu_ordr
					};
				});
				console.log("jsonData", jsonData);
				$('#jstree').jstree({
					core: {
						data: jsonData
					},
					'types': {
						'dir':  { 'icon': '/images/folder.png' },
					 	'file': { 'icon': "/images/file.png" }
					},
					"plugins" : [
             	 		'types', "wholerow"
	             	]
				}).bind('loaded.jstree', function(event, data){
                    //트리 로딩 롼료 이벤트
					$('#jstree').jstree('open_all');
                }).bind('select_node.jstree', function(event, data){
                      //노드 선택 이벤트
                	data.instance.deselect_node(data.node);
                    console.log(data.node);
                    $('#menuNo').val(data.node.id);
                    
                    if (data.node.parent == "#") {
                    	$('#upperMenuNo').val("0");
					}else{
	                    $('#upperMenuNo').val(data.node.parent)
					}
                    
                    $('#menuNm').val(data.node.text);
                    $('#menuOrdr').val(data.node.original.menuOrdr);
                    $('#progrmFileNm').val(data.node.original.progrmFileNm);
                    $('#relateImageNm').val(data.node.original.relateImageNm);
                    $('#relateImagePath').val(data.node.original.relateImagePath);
                    $('#menuDc').val(data.node.original.menuDc);
                    checkSystem = true;
                })
			}
		})
	}
	
	$('#prgrmSearch').on('click', (e) =>{
		e.preventDefault();
		window.open(
			"/prgrmSearch.do",
			"prgrmSearch",
			"width=600px, height=738px, top=300px, left=300px, scrollbars=yes"
		);
	});
	
	$('#delBtn').on('click', function(e) {
		e.preventDefault();
		if (confirm("삭제 하시겠습니까?")) {
			if ($('#menuNo').val() == "") {
				alert("선택 해주세요.");
				return false;
			}
			$(menuListFrm).attr("action","/deleteMenu.do");
			$(menuListFrm)[0].submit();
		}
	})
	
	$('#initBtn').on('click', function(e) {
		e.preventDefault();
		$(menuListFrm)[0].reset();
		checkSystem = false;
	})
	
	$('#updateBtn').on('click', (e) =>{
		e.preventDefault();
		if (!checkSystem) { // 상세 안누르고 수정버튼 눌렀을떄
			alert("선택해주세여.");
			return false;
		}
		$(menuListFrm).attr("action","/updateMenu.do");
		$(menuListFrm)[0].submit();
	});
	
	$('#saveBtn').on('click', function(e) {
		e.preventDefault();
		if(checkSystem){
			alert("상세조회시는 수정혹은 삭제만 가능합니다.")
			return false;
		}
		if(checkText()){
			alert("필수 항목을 입력해주세요.");
			return false;
		}
		$(menuListFrm).attr("action","/insertMenu.do");
		$(menuListFrm)[0].submit();
	})
	
	function checkText() {
		var returnValue = false;
		
		if ($('#upperMenuNo').val() == "" ||
				$('#menuNo').val() == "" ||
				$('#menuNm').val() == "" ||
				$('#menuOrdr').val() == "" ||
				$('#progrmFileNm').val() == "") {
			returnValue = true;
		}
		
		return returnValue;
	}
	
	$('#menuSearch').on('click', function(e) {
		e.preventDefault();
		window.open(
			"/menuSearch.do",
			"menuSearch",
			"width=600px, height=738px, top=300px, left=300px, scrollbars=yes"
		);
	})
});
</script>
</html>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
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
				<h4>메뉴생성</h4>
			</div>
		</div>
		<div class="row authorCodeDiv">
			<div class="col-4" style="border-right: 1px solid #e5e6e6; text-align: center; background-color: #eff0f1;">
				<h6>권한코드</h6>
			</div>
			<div class="col-8">
				<h6 id="authorCode">${authorCode }</h6>
			</div>
		</div>
		<div class="row mt-3" style="border-top: 2px solid black; height: 500px; overflow: scroll;">
			<div class="col" style="padding: 10px;">
				<div id="jstree">
				</div>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col">
				<button id="menuCreatBtn" class="btn btn-primary" style="margin-left: 82%;">메뉴생성</button>
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
	const menuCreatBtn = $('#menuCreatBtn');
	var sendData = {};
	getJson();
	
		
	function getJson() {
		$('#jstree').jstree('destroy');
		$('#jstree').jstree("deselect_all");
		$.ajax({
			type: "get",
			url: "/getMenuInfoList.do",
			async: false,
			data: {author_code : "${authorCode}"},
			dataType: "json",
			success: function(data) {
				console.log("data", data)
				var jsonData = new Array();
				
				$.each(data, (idx, item)=>{
					if (item.upper_menu_no == 0) {
						item.upper_menu_no = '#';
					}
					jsonData[idx] = {
						id: item.menu_no, 
						parent: item.upper_menu_no, 
						text: item.menu_nm, 
						type: item.type
					};
					console.log(item.selectedCnt);
					if (item.selectedCnt != 0) {
						jsonData[idx].state = {
							"selected": true
						}
					}else{
						jsonData[idx].state = {
							"selected": false
						}
					}
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
					"checkbox" : {
			         	"keep_selected_style": false,
		         		three_state: false
			     	},
					"plugins" : [
	             		"checkbox", 'types', "wholerow"
	             	]
				}).bind('loaded.jstree', function(event, data){
                    //트리 로딩 롼료 이벤트
					$('#jstree').jstree('open_all');
                }).bind('select_node.jstree', function(event, data){
                      //노드 선택 이벤트
                })
			}
		})
	}
	
	
	$(menuCreatBtn).on('click', function() {
		sendData.authorCode = $('#authorCode').text().trim();
		sendData.nodeData = $("#jstree").jstree("get_selected", false);
		console.log("선택된 노드 : ", sendData);
		menuSelectSetting();
	})
	
	function menuSelectSetting() {
		$.ajax({
			url: "/menuSetting.do",
			type: "post",
			data: JSON.stringify(sendData),
			dataType: "text",
			contentType: "application/json;charset=utf-8",
			success: function(res) {
				if (res === "success") {
					alert("정상적으로 저장되었습니다.");
				}else{
					alert("서버에러 다시 시도해 주세요.");
				}
				location.reload();
			},
			error: function(err) {
				console.log("에러 : ", err.status)
			}
		});
	}
});

function fnExit() {
	window.close();
}
</script>
</html>
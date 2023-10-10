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
		<div class="row mt-3" style="border-top: 2px solid black; height: 500px; overflow: scroll;">
			<div class="col" style="padding: 10px;">
				<div id="jstree">
				</div>
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
		$('#jstree').jstree("deselect_all");
		$.ajax({
			type: "get",
			url: "/getMenuInfoList.do",
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
                      var item = data.node;
                      console.log(item);
                      opener.document.querySelector('#upperMenuNo').value = item.id;
                      if (item.children.length != 0) {
                    	  var nodeArr = item.children;
                    	  for (var i=0; i<nodeArr.length; i++) {
                    		  nodeArr[i] = parseInt(nodeArr[i]); 
						  }
//                     	  console.log(nodeArr);
                    	  var maxVal = Math.max(...nodeArr);	
                    	  opener.document.querySelector('#menuNo').value = maxVal+1;
                      }else{
                    	  opener.document.querySelector('#menuNo').value = parseInt(item.id)+1;
                      }
                      window.close();
                })
			}
		})
	}
	
});

function fnExit() {
	window.close();
}
</script>
</html>
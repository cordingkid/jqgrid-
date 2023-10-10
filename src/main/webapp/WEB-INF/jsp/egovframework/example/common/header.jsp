<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
        /* 해더 배경색 설정 */
        .navbar {
            background-color: black;
        }
        /* 드롭다운 메뉴가 항상 열린 상태로 설정 */
        .dropdown:hover .dropdown-menu {
            display: block;
        }
        /* 해더 내용 가운데 정렬 */
        .navbar {
            text-align: center;
        }
    </style>
<script type="text/javascript">
$(function() {

    function fnMenuTree(){
        return new Promise((resolve, reject)=>{
            $.ajax({
                url: "/menuTreeList.do",
                type: "get",
                dataType: "json",
                success: function(data) {
                    console.log("헤더메뉴 생성");
                    resolve(data);
                },
                error: function(err) {
                    console.log("헤더메뉴 실패");
                    reject(err);
                }
            });
        });
	}
	
	fnMenuTree().then(( res )=>{
        /* fnMenuTree에서 성공한 data 값이 resolve를 통해 리턴되어 res에 data 값이 매핑됨  */
        console.log(res);
        fnMenuTreeRender( res );
    }).catch(( err )=>{
        /* 만약 서버 데이터 전송이 실패 했을때 reject함수가 호출되어서 인자로 err 값을 전달 catch매서드로 err 값을 전달받아 사용 가능  */
        console.log( err );
    });
	
	

    function fnMenuTreeRender(menuTreeArr){
        var str = "";
        for(var i in menuTreeArr){
            var node = menuTreeArr[i];
            str += `<li class="nav-item dropdown">
        	            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            \${node.menu_nm}`;
            str += `<div class="dropdown-menu" aria-labelledby="navbarDropdown">`;
            var nodeBaby = node.children;
            str += fnMenuNodeRender(nodeBaby);
            str += `</div>`;
            str += `    </a>
                    </li>`;
        }
        document.querySelector('#headerUl').innerHTML = str;
    }

    function fnMenuNodeRender(menuNode){
        var str = "";
        if( menuNode != null || menuNode.length > 0 ){
            for(var i in menuNode){
                if(menuNode[i].url == "dir"){
                    str += `<a class="dropdown-item" href="#" onclick="return false;">\${menuNode[i].menu_nm}</a>`;
                    str += fnMenuNodeRender(menuNode[i].children);
                }else{
                    str += `<a class="dropdown-item" href="\${menuNode[i].url}"> - \${menuNode[i].menu_nm}</a>`;
                }
            }
        }
        return str;
    }
});
</script>
<!-- 네비게이션 바 (해더) -->
<nav class="navbar navbar-expand-lg navbar-light">
    <!-- 네비게이션 메뉴 -->
    <ul class="navbar-nav mx-auto" id="headerUl">
    </ul>
</nav>
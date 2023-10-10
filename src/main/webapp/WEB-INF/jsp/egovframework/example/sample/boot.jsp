<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부트스트랩 웹 페이지</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
</head>
<body>
	<!-- 헤더자리 -->
	<%@include file="/WEB-INF/jsp/egovframework/example/common/header.jsp" %>
	<!-- 헤더자리 -->
	
	
    <!-- 본문 내용 -->
    <div class="container mt-5">
        <h1>안녕하세요, 부트스트랩 웹 페이지!</h1>
        <p>이것은 부트스트랩을 사용하여 만든 웹 페이지입니다. 해더에는 드롭다운 메뉴가 있으며, 해더 내용은 가운데 정렬되어 있습니다.</p>
    </div>

    <!-- 부트스트랩 JS 및 jQuery 링크 (jQuery는 부트스트랩의 일부 기능을 사용하기 위해 필요합니다) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

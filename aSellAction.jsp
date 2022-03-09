<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aSell</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if("${res}" == "success") {
		switch("${param.gbn}") {
		case "u":
			$("#actionForm").submit();
			break;
		case "i":
		case "d":
			location.href = "aSell";	
			break;
		}
	} else { // 예외 발생 시
		alert("작업 중 문제가 발생하였습니다.");
		history.back();
	}
});
</script>
</head>
<body>
<!-- 수정 성공 시 사용 -->
<form action="aSell" id="actionForm" method="post">
	<input type="hidden" name="page" value="${param.page}" />
</form>
</body>
</html>
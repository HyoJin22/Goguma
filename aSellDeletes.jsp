<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aSell Delete</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	switch('${res}') {
	case "success" :
		location.href = "aSellList";
		break;
	case "failed" :
		alert("삭제에 실패하였습니다.");
		history.back();
		break;
	case "error" :
		alert("삭제중 문제가 발생하였습니다.");
		history.back();
		break;
	}
});
</script>
</head>
<body>
</body>
</html>
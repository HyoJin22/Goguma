<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aSell</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function() {
		$("#actionForm").attr("action", "aSellList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "aSellUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post", 
				url : "aSellAction/delete", 
				dataType : "json", 
				data : params, 
				success : function(res) { 
					if(res.res == "success") {
						location.href = "aSellList";
					} else {
						alert("판매내역 삭제 중 문제가 발생하였습니다.");
					}
				},
				error : function(request, status, error) { 
					console.log(request.responseText);
				}
			});
		}
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
</form>
번호 : ${data.SELL_NO}<br/>
품명 : ${data.ITEM_NAME}<br/>
갯수 : ${data.COUNT}<br/>
판매일 : ${data.SELL_DT}<br/>
<input type="button" value="목록" id="listBtn" />
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="삭제" id="deleteBtn" />
</body>
</html>
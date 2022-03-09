<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TB Update</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#cancelBtn").on("click", function() {
		$("#backForm").submit();
	});
	
	$("#updateBtn").on("click", function() {
		// instances[이름] : 해당 이름으로 CKEDITOR 객체 취득
		// getData() : 입력된 데이터 취득
		if(checkEmpty("#name")) {
			alert("품명을 입력하세요.");
			$("#name").focus();
		} else if (checkEmpty("#count")) {
			alert("갯수를 입력하세요.");
			$("#count").focus();
		}  else if (checkEmpty("#date")) {
			alert("판매일을 입력하세요.");
			$("#date").focus();
		} else {
			var params = $("#updateForm").serialize();
			
			$.ajax({
				type : "post", 
				url : "aSellAction/update", 
				dataType : "json", 
				data : params, 
				success : function(res) { 
					if(res.res == "success") {
						$("#backForm").submit();
					} else {
						alert("수정중 문제가 발생하였습니다.");
					}
				},
				error : function(request, status, error) { 
					console.log(request.responseText);
				}
			});
		}
	});
});

function checkEmpty(sel) {
	if($.trim($(sel).val()) == "") {
		return true;
	} else {
		return false;
	}
}
</script>
</head>
<body>
<form action="aSell" id="backForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="SearchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="SearchTxt" value="${param.searchTxt}" />
</form>
<form action="#" id="updateForm" method="post">
<input type="hidden" name="no" value="${param.no}" />

번호 : ${data.SELL_NO}<br/>
품목 <input type="text" id="name" name="name" value="${data.ITEM_NAME}"/><br/>
갯수 <input type="text" id="count" name="count" value="${data.COUNT}"/><br/>
판매일 <input type="text" id="date" name="date" value="${data.SELL_DT}" /><br/>

<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</form>
</body>
</html>
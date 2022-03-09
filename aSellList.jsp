<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ASELL List</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if('${param.searchGbn}' != '') {
		$("#searchGbn").val('${param.searchGbn}');
	} else {
		$("#oldSearchGbn").val(0);
	}
	
	// 목록 조회 
	reloadList();
		
	$("#searchTxt").on("keypress", function(event) {
		if(event.keyCode == 13) {
			$("#searchBtn").click();
			
			return false;
		}		
	});
		
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		$("#oldSearchGbn").val($("#searchGbn").val());
		$("#oldSearchTxt").val($("#searchTxt").val());
		
		// 목록 조회
		reloadList();
	});	
	
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "aSell");
		$("#actionForm").submit();
		
	});
	
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));

		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		reloadList();
	});
	
	$("#writeBtn").on("click", function() {
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "aSellAdd");
		$("#actionForm").submit();
	});
	
	$("#logoutBtn").on("click", function() {
		location.href = "amLogout";
	});	
	
	$("#loginBtn").on("click", function() {
		location.href = "amLogin";
	});	
	
	
});

function reloadList() { // 목록 조회용 + 페이징 조회용
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post", 
		url : "aSellListAjax", 
		dataType : "json", 
		data : params, 
		success : function(res) { 
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function(request, status, error) { 
			console.log(request.responseText);
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list) {
		html += "<tr no=\"" + data.SELL_NO + "\">";
		html += "<td>" + data.SELL_NO + "</td>";
		html += "<td>" + data.ITEM_NAME + "</td>";
		html += "<td>" + data.COUNT + "</td>";
		html += "<td>" + data.SELL_DT + "</td>";
		html += "</tr>";
	}
	$("tbody").html(html);
}

function drawPaging(pb) {
	var html = "";
	
	html += "<span page=\"1\">처음</span>";
	
	if($("#page").val() == "1") {
		html += "<span page=\"1\">이전</span>";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 -1) + "\">이전</span>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++) {
		if($("#page").val() == i) {
			html += "<span page=\"" + i + "\"><b>" + i + "</b></span>";
		} else {
			html += "<span page=\"" + i + "\">" + i + "</span>";
		}
	}

	if($("#page").val() == pb.maxPcount) {
		html += "<span page=\"" + pb.maxPcount + "\">다음</span>";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>";
	}
	
	html += "<span page =\"" + pb.maxPcount + "\">마지막</span>";
	
	$("#paging_wrap").html(html);
	
	
}
</script>
</head>
<body>
<c:choose>
	<%-- 비 로그인 시 --%> 
	<c:when test="${empty sMNo}">
		로그인이 필요합니다.<input type="button" value="로그인" id="loginBtn" />
	</c:when>
	<%-- 로그인 시 --%> 
	<c:otherwise>
		${sMNm}님 어서오십시오. <input type="button" value="로그아웃" id="logoutBtn" />
	</c:otherwise>
</c:choose>
<!-- 검색 데이터 유지용 -->
<input type="hidden" id="oldSearchGbn" value="${param.searchGbn}" />
<input type="hidden" id="oldSearchTxt" value="${param.searchTxt}" />
<!-- action, href에서의 #은 이동하지 않겠다. -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" id="no" name="no" />
	<input type="hidden" id="page" name="page" value="${page}" />
	<select id="searchGbn" name="searchGbn">
		<option value="0">제목</option>
		<option value="1">작성자</option>
	</select>
	<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" />
	<input type="button" value="검색" id="searchBtn" />
	<%-- <c:if test="${!empty sMNo}">  --%>
		<input type="button" value="글쓰기" id="writeBtn" />
	<%-- </c:if> --%>
</form>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>품명</th>
			<th>갯수</th>
			<th>판매일</th>
		</tr>
	</thead>
	<tbody>
	</tbody>	
</table>
<div id="paging_wrap"></div>
</body>
</html>
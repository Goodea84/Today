<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>오늘 뭐하지?</title>
		<script src="script/jquery-ui.min.js" type="text/javascript"></script>
		<script src="script/jquery-3.1.0.min.js" type="text/javascript"></script>
		
		<script type="text/javascript">
			$(document).ready(function() {
				/* 지역검색 */
				$('#localBtn').on('click', function() {
					var local = $('#local').val();
					var localJason = {"local" : local};
					$.ajax({
						method: "post"
						, url: "getLocal"
						, data: localJason
						, dataType: "json"
						, success: function() {
						}
						
					});
				});
				
				/* 아이템 검색1 */
				$('#search').on('click', function() {
					var item1 = $('#item1').val();
					var itemJason = {"item1" : item1};
					$.ajax({
						method: "post"
						, url: "sendItem"
						, data: itemJason
						, dataType: "json"
						, success: call
					});
				});
				
				function call(response) {
					var url = "https://apis.daum.net/local/v1/search/keyword.json?";
					url += "&apikey=d0224817161ef3c311a65c73ea03f837";
					url += "&query=" + response.item1;
					url += "&sort=1";
	
					location.href= url;

					
					/* $.getJSON(url, function(data) {
						alert(data);
					}) */
					
				}
			});
		</script>
		
	</head>
	<body>
		<h2>오늘 뭐하지?!</h2>
		<input type="text" class="local" id="local" name="local" placeholder="지역 입력">&nbsp;
		<input type="button" id="localBtn" name="localBtn" value="검색"><br>
		
		<input type="text" class="item1" id="item1" name="item1" placeholder="아이템 입력">&nbsp;
		<input type="button" id="search" name="search" value="검색">

	<div id="results"></div>

	</body>
	
</html>
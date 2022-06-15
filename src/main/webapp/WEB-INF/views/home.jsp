<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<div  id="orgDiv">

	<div  class="item">
	
	<p>id1</p>
	<p>name1</p>
	<p>age1</p>
	<button class="btn_del">삭제</button>
	
	</div>
	
	<div class="item">
	
	<p>id6</p>
	<p>name6</p>
	<p>age6</p>
	<button class="btn_del">삭제</button>
	</div>
	
</div>

<jsp:forward page="/board/list"/>







<script type="text/javascript">
	$(document).ready(function() {
		$("#orgDiv").on("click", ".btn_del", function(){ // 동적으로만든건 이렇게 해줘야함.
			$(this).parent().remove();
		});
	});
</script>
	
</body>
</html>

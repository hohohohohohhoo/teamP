<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
</head>
<body>

<div>
	<a href="/displayfile?filename=${uploadedFilename}">
		<img alt="업로드한 파일의 썸네일" src="" >
	</a>
	<p>업로그한 파일의 원래 이름</p>
	<button>삭제</button>
</div>

<script type="text/javascript">
	$(document).ready(function () {
		let uploadedFilename = "${uploadedFilename}";
		
		$("div").on("click", "button", function () {
			
			// ajax의 success에서는 $(this)를 인식하지 못 함.
			// 그래서 $(this) 값을 변수에 담았다가 success 사용함.
			let $btn = $(this)
			
			$.ajax({
					type : "post",
					url : "/deletefile",
					data : {
						"uploadedFilename" : uploadedFilename
					},
					dataType : 'text',
					success : function(result){
						
						if(result == "SUCCESS"){
							$btn.parent().remove();
						}else{
							alert("삭제 실패");
						}
					}		
			});
			
		});
		
		
		
		if(isImg(uploadedFilename)){
			$("img").attr("src", "/displayfile?filename="+uploadedFilename);
		}else{
			
			$("img").attr("src", "/resources/img/일반파일.png");
		}
		
		
		if(isImg(uploadedFilename)){

			$("a").attr("href", "/displayfile?filename="+getImgFilePath(uploadedFilename) );	
		}
		
		
		
		
		$("p").text(getImgOrgName(uploadedFilename));
		
		
		
	
		
		function getImgOrgName(filename) {
			
			let orgName ="";
			let idx= -1;
			
			if(isImg(filename)){
				idx = filename.indexOf("_", 14) + 1;
				
			}else{
				idx = filename.indexOf("_");
			}
			
			orgName = filename.substring(idx);
			
			
			return orgName;
			
			
		}
		
		
		
		function getImgFilePath(filename) {
			let prefix = filename.substring(0, 12);
			let suffix = filename.substring(14);
			return prefix + suffix;
			
			
		}
		
		
		function isImg(filename) {
			let idx = filename.lastIndexOf(".") + 1;
			let formatName = filename.substring(idx).toLowerCase();
			if(formatName == "png" || formatName == "gif" 
					|| formatName == "jpg" || formatName =="jpeg"){
				return true;
			}else{
				return false;
			}
		}
	});

</script>


</body>
</html>
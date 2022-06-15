<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax를 이용한 파일 업로드</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
<style type="text/css">
	#uploadFile{
		width: 100%;
		height: 250px;
		border: 1px solid red;
	}

</style>

</head>
<body>

<div id="uploadFile" >


</div>

<div class="row row-cols-1 row-cols-lg-3" id="uploadedItems" style="margin-top: 10px;">

</div>


<script type="text/javascript" src="/resources/js/tl.js"></script>
<script type="text/javascript">




	$("#uploadedItems").on("click",".btn_del_item", function() {
		let filename = $(this).data("filename");
		
		let $btn = $(this);
		
		$.ajax({
			type : "post",
			url : "/deletefile",
			data : {
				"filename" : filename
			},
			dataType : "text",
			success : function(result) {
				
				if(result == 'SUCCESS'){
					$btn.parent().parent().parent().remove();
				}else{
					alert("삭제 실패")
				}
			}
		});
		
	});


	$(document).ready(function() {
		$("#uploadFile").on("dragenter dragover", function(event) {
			event.preventDefault();			
		});
		
		$("#uploadFile").on("drop", function(event) {
			
			event.preventDefault();
			
			//드래그한 파일들의 데이터를 files에 넣는다
			let files = event.originalEvent.dataTransfer.files;
			// files의 인덱스가 0번째인 데이터를 file에 저장
			let file = files[0];
			
			//이미지파일 ajax로 전송 도와줌 , form태그 역활
			let formData =new FormData();
			
			//file 데이터를 formData에 추가
			formData.append("file",file)
				
		
				
				$.ajax({				   //ajax는 화면갱신x 
					type : 'post',
					url : '/ajaxform',
					processData : false,	//url 주소창에 붙어나가는거 x 
					contentType: false,		//파일보낼수있는 형태로 변경 
					//enctype="application/x-www-form-urlencoded" form태그의 기본값사용 못하게막는 코드
					data : formData,
					dataType : "text",
					success : function(filename) {
						console.log(filename);
						filename = filename.substring(1,filename.length-1).trim();

						

						
						let str = makeUploadItemTag2(filename);`
						
						$("#uploadedItems").append(str);
						
					}			
				});
			
		
			
			

			

		});
		
		
	});
</script>
</body>
</html>
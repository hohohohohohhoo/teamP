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

<style type="text/css">
	#uploadFile{
		width: 100%;
		height: 250px;
		border: 1px solid red;
	}

</style>

</head>
<body>

<jsp:include page="../common/header.jsp"/>



<div class="jumbotron">
	<h1 class="text-center">게시글 게시글 수정</h1>
</div>


<form action="/board/update" method="post" style="padding:0 3%;">
<input type="hidden" name="bno" value="${bDto.bno }">
  <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">글제목</label>
    <div class="col-sm-10">
      <input name="title" class="form-control form-control-lg" id="title" value="${bDto.title }">
    </div>
  </div>
  
    <div class="form-group row">
    <label for="writer" class="col-sm-2 col-form-label col-form-label-lg">작성자</label>
    <div class="col-sm-10">
      <input name="writer" class="form-control form-control-lg" id="writer" value="${bDto.writer }" readonly="readonly">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="content" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
     <div class="col-sm-10">
    <textarea name="content" class="form-control" id="content" rows="10">${bDto.content }</textarea>
    </div>
  </div>
  
	
	<div class="form-group row">
			<div id="uploadFile" class="form-control text-center" ></div>
	</div>

   <div id="uploadedItems" class="row row-cols-1 row-cols-3"></div>
  

</form>



  
  <div class="form-group row">
  	<input id="btn_submit" class="form-control btn btn-primary col-md-2 offset-md-5"  type="submit" value="글 수정 완료">
  </div>


<script type="text/javascript" src="/resources/js/tl.js"></script>
<script type="text/javascript">

		
	$(document).ready(function() {
		
		let bno = ${bDto.bno};
		
		let formData = new FormData();
		
		let idx =0;    
		
		let deleteFilenameArr = [];
		
		
		$("#uploadFile").on("dragenter dragover", function(event) {
			event.preventDefault();
		});
		
		$("#uploadFile").on("drop", function(event) {
			event.preventDefault();	
			
			
			let files = event.originalEvent.dataTransfer.files;

			let file = files[0];
			

			formData.append("file"+idx,file);
			
			
			let reader = new FileReader();
			
			//파일 읽어오기
			reader.readAsDataURL(file);
			
			
			reader.onload = function(event) {
							//event 파일을읽는 이벤트  target 지정한다  result 값	
				let str = test2(event.target.result, file["name"], "file"+idx++);
				
				$("#uploadedItems").append(str);
			};
			
		});
		

	
		
		
		
		getAllUploadForUpdateUI(bno, $("#uploadedItems"));
		
		
		
		
		$("#uploadedItems").on("click",".btn_del_item", function() {
			let filename = $(this).attr("data-filename");
			
			if(filename =="new"){
				let filekey = $(this).attr("data-filekey");
				formData.delete(filekey);
			}else{
				deleteFilenameArr.push(filename);				
			}
			
			

			$(this).parent().parent().parent().remove();
		});
		
		
		
		$("#btn_submit").click(function() {
			formData.append("bno",bno);
			
			let title = $("#title").val();
			formData.append("title",title);
			
			let writer = $("#writer").val();
			formData.append("writer",writer);
			
			let content = $("#content").val();
			formData.append("content",content);
			
			formData.append("deleteFilenameArr",deleteFilenameArr);	
			
			$.ajax({				   
				type : 'post',
				url : '/board/update',
				processData : false,	
				contentType: false,			
				data : formData,
				dataType : "text",
				success : function(result) {
					if(result=="SUCCESS"){
						location.assign("/board/read/"+bno);
					}else{
						alert("수정 실패");
					}
					
				}			
			});
			
			
		});

		
	})

</script>
</body>
</html>
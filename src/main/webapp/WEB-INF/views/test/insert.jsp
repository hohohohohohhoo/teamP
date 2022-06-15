<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 화면</title>
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

}
	

</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="jumbotron">
<h1 class="text-center">게시글 작성</h1>
</div>



<form action="/board/insert" method="post" id="myform">

  <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">글제목</label>
    <div class="col-sm-10">
      <input name="title"  class="form-control form-control-lg"  id="title"  placeholder="제목 입력">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="writer" class="col-sm-2 col-form-label col-form-label-lg">작성자</label>
    <div class="col-sm-10">
      <input name="writer"  class="form-control form-control-lg"  id="writer"  placeholder="작성자 입력">
    </div>
  </div>
  
   <div class="form-group row">
    <label for="content" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
     <div class="col-sm-10">
    	<textarea name="content" class="form-control" id="content" rows="5"></textarea>
  	</div>	
  </div>
</form>



<div class="form-group">
	<!-- 파일을 드래그해서 넣을 수 있는 영역을 생성 -->
	<div id="uploadFile" class="form-control text-center"></div>
</div>
	<!-- 드래그한 파일들을 보여주는 영역 -->
	<div id="uploadedItems" class="row row-cols-3">
</div>

<div class="form-group row">
	<!-- 폼과 파일들의 정보를 가지고 서버로보낸다 .ajax 방식으로 스크립트로 구현 -->
	<input id="btn_submit" class="form-control btn btn-primary col-sm-2 offset-sm-5" type="submit" value="글 작성 완료">	
</div>

 <!-- /resources/js/tl.js  자바스크립트 태그와 연동  Template Literals --> 
<script type="text/javascript" src="/resources/js/tl.js"></script>
<script type="text/javascript">
$(document).ready(function() { //jquery 사용을 알리는 코드
	//html5에서 form태그를 클래스로 구현한 FormData
	let formData = new FormData();
	// formData에 파일을 추가할 때, filekey를 입력하는데 공통적으로 들어가는 이름구분 
	let idx = 0;
	
	/* id가 uploadedItems 로 된 div 영역의 btn_del_item 클래스를 가지고잇는 버튼을 누를 경우 */
	$("#uploadedItems").on("click", ".btn_del_item", function() {
		/* 방금누른 버튼의 사용자속성 data-filekey 값을 filekey에 저장 */
		let filekey = $(this).attr("data-filekey");
		/* formData에 변수 filekey과 같은 key 값을 삭제 */
		formData.delete(filekey);
		/* 방금누른 버튼의 부모의 부모의 부모를 삭제 */
		$(this).parent().parent().parent().remove();
	});
	
	
	
	/* id가 uploadFile 인 div 영역의 dragenter dragover 기능 이벤트 */
	$("#uploadFile").on("dragenter dragover", function(event) {
		//dragenter dragover기본기능 막음
		event.preventDefault();
	});
	// id가 uploadFile 인 div 영역의 drop 이벤트
	$("#uploadFile").on("drop", function(event) {
		//drop 기본기능 막음
		event.preventDefault();
		
		//드래그한 파일들을 files에 저장
		let files = event.originalEvent.dataTransfer.files;
		//files의 인덱스 0번인 파일을 file에 저장
		let file = files[0];
		
		//formData에 file을 key가 "file"+idx 로 저장 
		formData.append("file"+idx, file);
		
		//아이디가 uploadedItems인 영역에 드랍한 파일의 썸네일을 보여주기 위한 스트림
 		let reader = new FileReader();
 		
 		//앞에서만든 reader라는 스트림(톨로)을 통해 드랍한 파일의 정보를 읽어 옴
 		reader.readAsDataURL(file);
 		
		// reader.onload: readAsDataURL 작업이 끝나면 실행되는 function()구현
		reader.onload = function(event) {
			// str에 tl.js에 잇는 test2함수를 호출 Template Literals
			let str = test2(event.target.result, file["name"], "file"+ idx++);
						//event 파일을읽는 이벤트  target 지정한다  result 값
			//id 가 uploadedItems 값에 str 값을 넣는다
			$("#uploadedItems"). append(str);
		}
		
	});
	
	//id가 btn_submit 인 버튼 클릭시
	$("#btn_submit").click(function() {
		// id가 title인 정보의 값을 title에 저장
		let title = $("#title").val();
		// id가 writer인 정보의 값을 writer에 저장
		let writer = $("#writer").val();
		// id가 content인 정보의 값을 content에 저장
		let content = $("#content").val();
		
		//formData에 title 정보를 key 값 title 로 저장
		formData.append("title", title);
		//formData에 writer 정보를 key 값 writer 로 저장
		formData.append("writer", writer);
		//formData에 content 정보를 key 값 content 로 저장
		formData.append("content", content);
		
		//ajax 통신 비동기 통신
		$.ajax({
			//type 은 post
			type : "post",
			//url을 /board/insert로 보낸다
			url : "/board/insert",
			//processData의 디폴트값은 true: 데이터를 주소창에 붙여서 보낸다 false 주소창에 붙여서안보낸다
			processData : false,
			// form태그의 기본 enctye을 사용하겠다는 의미 그러면 파일전송x
			contentType : false,
			//data 는 formData 객체 안에 추가 데이터들이 전송됨.
			data : formData,
			// dataType 을 text 로받아온다
			dataType : "text",
			//완료할경우
			success : function(bno) {
				//주소창을/board/read/ + 받아온 bno 값의 페이지를 연다
				location.assign("/board/read/"+bno);
			}
		});
	});
	
	
	
	
});
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 화면</title>
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
<h1 class="text-center">게시글 수정</h1>
</div>

<form action="/board/update" method="post">
	<input type="hidden" name="bno" value="${bDto.bno}">

  <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">글제목</label>
    <div class="col-sm-10">
      <input name="title"  class="form-control form-control-lg"  id="title"  value="${bDto.title}">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="writer" class="col-sm-2 col-form-label col-form-label-lg">작성자</label>
    <div class="col-sm-10">
      <input name="writer"  class="form-control form-control-lg"  id="writer"  value="${bDto.writer}">
    </div>
  </div>
  
   <div class="form-group row">
    <label for="content" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
     <div class="col-sm-10">
    	<textarea name="content" class="form-control" id="content" rows="5">${bDto.content}</textarea>
  	</div>	
  </div>
  

</form>


<div class="form-group">
	<div id="uploadFile" class="form-control text-center"></div>
</div>



<div id="uploadedItems" class="row row-cols-1 row-cols-3">
</div>


  <div class="form-group row">
    <input id="btn_submit" class="form-control btn btn-primary col-sm-2 offset-sm-5" type="submit" value="글 수정 완료">	
  </div>
  
<script type="text/javascript" src="/resources/js/tl.js"></script>  
<script type="text/javascript">
$(document).ready(function() {
	//수정할 게시글 지정 역할& 업로그된 파일들에 대한 정보를 가져오기 위한 용도
	let bno = ${bDto.bno};
	
	/* form 태그를 클래스로 구현한것.
	나중에 form 태그의 input 태그에 있는 데이터와 새롭게 업로드 되는 파일들의 정보를
	formData 객체에 저장해서 Controller로 보내줄 것임. */
	let formData = new FormData();
	
	/* formData 객체에 업로드되는 파일 정보를 저장할 때 key 값을 구분하기 위해
	key 값을 달리해야지 파일을 추가하는 화면에서 추가 삭제를 할수 있음 */
	let idx = 0;
	
	//DB에 있던 원래 업로드된 파일들 중에 삭제한 파일정보를 저장하기위한 리스트
	let deletFilenameArr = [];
	
	
	//tl.js의 함수. 업로드된 파일 리스트 가져오기
	getAllUploadForUpdateUI(bno, $("#uploadedItems"));
	
	
	// uploadFilev파일의 기본기능 dragenter dragover 막는 이벤트
	$("#uploadFile").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	//uploadFile 파일의 기본 drop 기능 막는 이벤트
	$("#uploadFile").on("drop", function(event) {
		event.preventDefault();
		
		// 업로드한 파일들을 바이너리코드로 전환해서 변수 files에 대입 
		let files = event.originalEvent.dataTransfer.files;
		
		//files의 인덱스가 0 번째인 정보를 변수 file에 저장
		let file = files[0];
		
		// formData에 file을 각 파일마다 file+idx인 key로 저장
		formData.append("file"+ idx, file);
		
		//업로드할 파일의 썸네일을 화면에 표현하기 위한 코드 시작
		
		// FileReader라는 스트림 객체를 생성함.
		let reader = new FileReader();
		
		/* FileReader와 106번 라인의 file 변수를 연결하고 그 안에 있는 데이터를 읽어와서
		   reader 객체에 그 데이터를 저장함. */
		reader.readAsDataURL(file);
		
		// reader.onload: readAsDataURL(file) 함수 작업이 종료됨을 감지하는 코드
		reader.onload = function(event) {
			
			// 해당 이벤트에 대한 핸들러 작업
			// event.target : reader
			// event.target.result : reader 객체 안에 있는 result 속성 : file 로부터 읽어온 데이터
			// file["name"]  : 오리지널 파일 네임
			let str = test2(event.target.result, file["name"], "file"+ idx++);
			
			// uploadedItems 에 str 추가
			$("#uploadedItems").append(str);
		};
		
		
		
	});
	
	
	//정적으로 생성된 uploadedItems 안에 동적으로 생성된 btn_del_item 버튼시 클릭시 이벤트
	//동적으로 생성될 경우 작동이 안 될수도잇어서 이벤트가 항상 먹게하려고 on()함수 사용
	$("#uploadedItems").on("click", ".btn_del_item", function() {
		
		//방금 누른 버튼 btn_del_item 의 사용자속성 data-filenam 정보를 변수 filename에 저장
		let filename = $(this).attr("data-filename");
		
		//filename이 new 일경우
		if(filename == "new"){
			//방금누른 버튼 btn_del_item의 사용자속성data-filekey을 filekey에 저장
			let filekey = $(this).attr("data-filekey");
			//formData의 key가 filekey인 데이터삭제 
			formData.delete(filekey);
			//filename이 new 가아닐 경우
		}else{
			//deletFilenameArr리스트에  filename 정보를 넣는다
			deletFilenameArr.push(filename);
		}
		//방금 누른 버튼의 부모의 부모의 부모를 삭제
		$(this).parent().parent().parent().remove();
	});
	
	
	$("#btn_submit").click(function() {
		formData.append("bno", bno);
		
		let title = $("#title").val();
		formData.append("title", title);
		
		let writer = $("#writer").val();
		formData.append("writer", writer);
		
		let content = $("#content").val();
		formData.append("content", content);
		
		formData.append("deletFilenameArr", deletFilenameArr);
		
		
		$.ajax({
			type : 'post',
			url : "/board/update",
			//주소창 x
			processData : false,
			//파일첨부 o form 태그에 파일첨부할때 사용
			contentType : false,
			data : formData,
			dataType: "text",
			success : function(result) {
				if(result=="SUCCESS"){
					location.assign("/board/read/"+bno);
				}else{
					alert("수정 실패");
				}
				
			}
		});
		
	});
	
	
	
	
	
	
	
	
});

</script>

</body>
</html>
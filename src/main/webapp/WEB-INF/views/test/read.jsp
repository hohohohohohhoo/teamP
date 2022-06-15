<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 자세히 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="jumbotron">
	<h1 class="text-center">글 자세히 보기</h1>
</div>

  <div class="form-group row">
    <label for="bno" class="col-sm-2 col-form-label col-form-label-lg">글번호</label>
    <div class="col-sm-10">
      <input readonly class="form-control form-control-lg"  id="bno" value="${bDto.bno}">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="writer" class="col-sm-2 col-form-label col-form-label-lg">작성자</label>
    <div class="col-sm-10">
      <input readonly class="form-control form-control-lg"  id="writer" value="${bDto.writer}">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="regDay" class="col-sm-2 col-form-label col-form-label-lg">작성일</label>
    <div class="col-sm-10">
      <input readonly class="form-control form-control-lg"  id="regDay" value="${bDto.regDay}">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="updateDay" class="col-sm-2 col-form-label col-form-label-lg">수정일</label>
    <div class="col-sm-10">
      <input readonly class="form-control form-control-lg"  id="updateDay" value="${bDto.updateDay}">
    </div>
  </div>

  <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">글제목</label>
    <div class="col-sm-10">
      <input readonly class="form-control form-control-lg"  id="title" value="${bDto.title}">
    </div>
  </div>
  

  
   <div class="form-group row">
    <label for="content" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
     <div class="col-sm-10">
    	<textarea readonly class="form-control" id="content" rows="5">${bDto.content}</textarea>
  	</div>	
  </div>

 <!-- id가 uploadedItems 의 영역에 저장된 파일의 썸네이을 보여주는 영역 -->
<div id="uploadedItems" class="row row-cols-3">

</div>

<%-- a 태그를 버튼으로 변경하고 수정 버튼을 누르면 /board/update/${bDto.bno} 로 이동한다 --%>
<a class="btn btn-warning" href="/board/update/${bDto.bno}">수정</a>
<%-- a 태그를 버튼으로 변경하고 삭제 버튼을 누르면 게시글을 삭제한다. --%> 
<a class="btn btn-danger delete" href="#">삭제</a> 
<%-- a 태그를 버튼으로 변경하고 목록 버튼을 누르면 /board/list 로 이동한다 --%>
<a class="btn btn-info" href="/board/list">목록</a> 
<%-- a 태그를 버튼으로 변경하고 댓글 버튼을 누르면 modal 화면이 나온다 --%>
<a class="btn btn-success reply">댓글</a>
<br>
<br>
<!-- 댓글작성용 양식 -->
<div class="collapse">
  <div class="card card-body">
	<div class="form-group row">
    	<label for="replyer" class="col-sm-2 col-form-label col-form-label-lg">댓글 작성자</label>
    	<div class="col-sm-10">
      		<input class="form-control form-control-lg"  id="replyer"  placeholder="댓글 작성자 입력">
    	</div>
  	</div>
  	  	
	<div class="form-group row">
    	<label for="replyText" class="col-sm-2 col-form-label col-form-label-lg">댓글</label>
    	<div class="col-sm-10">
      		<input class="form-control form-control-lg"  id="replyText"  placeholder="댓글 입력">
    	</div>
  	</div>
  	
  	<div class="form-group row">
    	<input id="reply_btn_submit" class="form-control btn btn-primary col-sm-2 offset-sm-5" type="submit" value="댓글 작성 완료">	
    </div>    
    
  </div>
</div>

 <!-- post방식으로 삭제 정보를 넘겨주기위한 form -->
<form action="">
</form>

<!-- 입력된 댓글들을 넣어주는 영역 -->
<div id="replies">
</div>





<!-- Modal -->
<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">rno: <span id="modal_rno">5</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div class="form-group">
        	<input id="item_input_update_replyer" class="form-control" value="홍길동">
        </div>
        <div class="form-group">
        	<input id="item_input_update_replyText" class="form-control" value="아버지를 아버지라 부르지 못 하고">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary"  data-dismiss="modal" id="item_btn_update_submit" >댓글 수정 완료</button>
      </div>
    </div>
  </div>
</div>











<!-- tl.js 를 사용하기위해 연동 -->
<script type="text/javascript" src="/resources/js/tl.js"></script>

<script type="text/javascript">
	let bno = ${bDto.bno};  // 게시글의 bno 을 변수 bno 에 저장
	
	
	$(function() {
		
		// tl.js에 있는 getAllUpload 호출 해서 id가 uploadedItems 인 영역에 넣어준다
		getAllUpload(bno, $("#uploadedItems"));   
		 
		// id 가 item_btn_update_submit 인 버튼을 클릭시 발생하는 이벤트
		$("#item_btn_update_submit").click(function() {
			//id가 item_input_update_replyer 인 값을 replyer 에 저장
			let replyer = $("#item_input_update_replyer").val();
			//id가 item_input_update_replyText 인 값을 replyText 에 저장
			let replyText = $("#item_input_update_replyText").val()
			//id가 modal_rno 인 값의 텍스트를 rno 에 저장;
			let rno = $("#modal_rno").text();
			
			$.ajax({
				type : "put", // type 이 put 
				url : "/replies", //url 을 /replies 로 보낸다
				headers : {
					"Content-Type" : "application/json; charset=UTF-8",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({  //json 형태로 변환
					replyer : replyer,       // replyer 데이터를 replyer로 저장
					replyText : replyText,   // replyText 데이터를 replyText로 저장
					rno : rno				// rno 데이터를 rno로 저장
				}),
				dataType: "text",           //받은 데이터 타입이 text
				success : function(result) {
					//tl.js 의 getAllReply함수 호출후 id 가 replies 영역에 넣어준다
					getAllReply(bno, $("#replies"));    
				}
			});
		});
		
		// 정적으로 말들어진 replies 영역안의 동적으로 만든 class가 item_btn_update 버튼 클릭시 발생하는 이벤트
		$("#replies").on("click", ".item_btn_update", function() {
			// id 가 myModal 인 modal영역을 나오게 만든다 
			$("#myModal").modal("show");
			
			//방금 누른 class가 item_btn_update 버튼의 위에위에 텍스트값을 replyer 에 저장
			let replyer = $(this).prev().prev().text();
			//방금 누른 class가 item_btn_update 버튼의 위에 텍스트값을 replyer 에 저장
			let replyText = $(this).prev().text();
			////방금 누른 class가 item_btn_update 버튼의 사용자속성값 data-rno을 rno 에저장
			let rno = $(this).attr("data-rno");
			
			//id 가 modal_rno 인 태그에 text 값을 rno 값을 넣는다
			$("#modal_rno").text(rno);
			//id가 item_input_update_replyer 인 태그에 값을 replyer 값을 넣는디
			$("#item_input_update_replyer").val(replyer);
			//id가 item_input_update_replyText 인 태그에 값을 replyText 값을 넣는디
			$("#item_input_update_replyText").val(replyText);

			
		});
		
		//정적으로 만들어진 id가 replies 인 영역 안의 class가 item_btn_delete 인 버튼을 클릭시 발생하는 이벤트
		$("#replies").on("click", ".item_btn_delete", function() {
			//방금 누른 class가item_btn_delete인 버튼의 사용자속성 data-rno 값을 rno에 저장
			let rno = $(this).attr("data-rno");
			$.ajax({
				type : 'delete',   //type이 delete
				url : '/replies',  // url 을 /replies로 보낸다
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				data : JSON.stringify({  //json 형태로 변환
					rno : rno            //rno 데이터를 rno으로 저장
				}),
				dataType : 'text',      //받아온데이터의 Type 이 text
				success : function(result) {
					//tl.js 의 getAllReply함수 호출후 id 가 replies 영역에 넣어준다
					getAllReply(bno, $("#replies"));   
				}
				
			});
		});
		
		
		//id가 reply_btn_submit 인 버튼 클릭시 발생 이벤튼
		$("#reply_btn_submit").on("click", function() {
			//id가 replyer인 값을 replyer에 저장
			let replyer = $("#replyer").val();
			//id가 replyText인 값을 replyText에 저장
			let replyText = $("#replyText").val();

			$.ajax({
				type : 'post',  // type 이 post
				url : '/replies',   //url 을 /replies로 보낸다
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data : JSON.stringify({
					replyer : replyer,
					replyText : replyText,
					bno : bno
				}),
				dataType : 'text',
				success : function(result) {
					
					//반환된 result 값이 SUCCESS 가 맞으면 실행 아니면 else 실행
					if(result=='SUCCESS'){
						//tl.js의  getAllReply 함수를 호출 id가 replies 영역에 넣어준다
						getAllReply(bno, $("#replies"));
						// id 가 replyer 인 값을 null 으로 초기화
						$("#replyer").val("");
						// id 가 replyText 인 값을 null 으로 초기화
						$("#replyText").val("");
					}else{
						//메세지를 날려준다
						alert("입력 실패했습니다.");
					}
				}
				
			});
			
			
		});
		
		
		
		
		//class가 reply 인 버튼 클릭시 발생이벤트
		$(".reply").on("click", function() {
			//class가 collapse 인 영역을 보여준다.
			$(".collapse").collapse("toggle");
		});
		
		
		//	post 방식으로 하기위해 form 으로 보낸다.
		$(".delete").on("click", function() {
			$("form")
			.attr("action", "/board/delete/${bDto.bno}")
			.attr("method", "post")
			.submit();
		});
		
		
		
		getAllReply(bno, $("#replies"));
		
	});


</script>
</body>
</html>
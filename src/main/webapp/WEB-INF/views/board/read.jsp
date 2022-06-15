<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 자세히 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="jumbotron">
	<h1 class="text-center">게시글 자세히 보기</h1>
</div>

<div style="padding: 0 3%;">

 <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">게시글번호</label>
    <div class="col-sm-10">
    <input readonly="readonly"  class="form-control form-control-lg" id="bno" value="${bDto.bno}">
    </div>
  </div>
  
   <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">작성자</label>
    <div class="col-sm-10">
    <input readonly="readonly"  class="form-control form-control-lg" id="writer" value="${bDto.writer}">
    </div>
  </div>
  
     <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">작성일</label>
    <div class="col-sm-10">
    <input readonly="readonly"  class="form-control form-control-lg" id="regDay" value="${bDto.regDay}">
    </div>
  </div>
  
     <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">수정일</label>
    <div class="col-sm-10">
     <input readonly="readonly"  class="form-control form-control-lg" id="updateDay" value="${bDto.updateDay}">
    </div>
  </div>
  
     <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">조회수</label>
    <div class="col-sm-10">
     <input readonly="readonly"  class="form-control form-control-lg" id="readCnt" value="${bDto.readCnt}">
    </div>
  </div>
  
     <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">제목</label>
    <div class="col-sm-10">
     <input readonly="readonly"  class="form-control form-control-lg" id="title" value="${bDto.title}">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">내용</label>
    <div class="col-sm-10">
    <textarea readonly="readonly" class="form-control" id="content" rows="5">${bDto.content}</textarea><br>
    </div>
  </div>
  
   <div class="form-group row">
    <label for="title" class="col-sm-2 col-form-label col-form-label-lg">첨부파일</label>
  </div>
   <div id="uploadedItems" class="row row-cols-1 row-cols-lg-3"></div>
  
  
 	

  </div>
      
  
	<form action=""></form>
<nav class="nav" style="padding-left: 80%;">
  <a class="nav-link" href="/board/update/${bDto.bno}">수정</a>
  <a class="nav-link delete" href="#">삭제</a>
  <a class="nav-link" href="/board/list">목록</a>
  <a class="nav-link reply" >댓글</a>
</nav>
<br>
<br>
<div class="collapse" >
  <div class="card card-body">
		<div class="form-group row">
			<label for="replyer"class="col-sm-2 col-form-label col-form-label-lg">댓글작성자</label>
			<div class="col-sm-2">
				<input class="form-control form-control-lg"
					id="replyer" placeholder="댓글작성자 입력">
			</div>
		</div>

		<div class="form-group row">
			<label for="replyText" class="col-sm-2 col-form-label col-form-label-lg">댓글</label>
			<div class="col-sm-10">
				<input class="form-control form-control-lg" id="replyText" placeholder="댓글 입력">
			</div>
		</div>
		
		<div class="form-group row">
			<input id="reply_btn_submit" class="form-control btn btn-primary col-md-2 offset-md-5" type="submit" value="댓글 작성 완료">
		</div>


		</div>
</div>




<div id="replies" >


</div>


<!-- Modal -->
<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">rno : <span id="modal_rno">5</span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
			<div class="modal-body">
				<div class="form-group">
					<input id="item_input_update_replyer" class="form-control" value="홍길동">
				</div>
				<div class="form-group">
					<input id="item_input_update_replyText" class="form-control" value="똥">
				</div>
			</div>
				<div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button id="item_btn_update_submit" type="button" class="btn btn-primary" data-dismiss="modal">댓글 수정 완료</button>
      </div>
    </div>
  </div>
</div>












<%-- <a class="btn btn-warning" href="/board/update/${bDto.bno}" style="margin-left: 80%;">수정</a> 
<a class="btn btn-danger" href="#">삭제</a> 
<a class="btn btn-info" href="/board/list">목록</a> 
<a class="btn btn-success">댓글</a> --%>


	
	
<script type="text/javascript" src="/resources/js/tl.js"></script>
<script type="text/javascript">

	let bno = ${bDto.bno};
	

	
	
	
	$(document).ready(function() {  
		
		getAllUpload(bno, $("#uploadedItems"));
		
		
		
		$("#item_btn_update_submit").click(function() {
			let replyer = $("#item_input_update_replyer").val();
			let replyText = $("#item_input_update_replyText").val();
			let rno = $("#modal_rno").text();
			
			
			$.ajax({
				type : 'put',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json; charset=UTF-8",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({
					replyer : replyer,
					replyText : replyText,
					rno : rno
				}),
				dataType : "text",
				success : function(result) {
				
					getAllReply(bno, $("#replies"));
					
				}
				
				
			}); 
		});
		
		
	      $("#replies").on("click", ".item_btn_update", function() {
	          $("#myModal").modal("show");
	          
	          let replyer = $(this).prev().prev().text();
	          let replyText = $(this).prev().text();
	          let rno = $(this).attr("data-rno");
	          
	          
	          $("#item_input_update_replyer").val(replyer);
	          $("#item_input_update_replyText").val(replyText);
	          $("#modal_rno").text(rno);
	          
	          
	         
	          
	          
	          
	       });

			
		//동적으로 생성된 코드는 정적으로 생성된 것을 이용하여 이용가능하다
		$("#replies").on("click", ".item_btn_delete", function() {
			let rno= $(this).data("rno");
			$.ajax({
				type : 'delete',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				data : JSON.stringify({
					rno : rno
				}),
				dataType : "text",
				success : function(result) {
					
					getAllReply(bno, $("#replies"));
					
				}
				
				
			}); 
		});
			
		
		
		$("#reply_btn_submit").on("click", function() {
			
			let replyer  = $("#replyer").val();
			let replyText  = $("#replyText").val();

			
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data : JSON.stringify({
					
					replyer : replyer,
					replyText : replyText,
					bno : bno
				}),
				dataType : "text",
				success : function(result) {
					if(result=="SUCCESS"){
					getAllReply(bno, $("#replies"));
					$("#replyer").val("");
					$("#replyText").val("");
					}else{
						alert("입력 실패했습니다.");
					}
				}
				

								
			}); 
		});
		
		$(".reply").on("click", function() {
			$('.collapse').collapse('toggle');
		});
		
		
		$(".delete").on("click", function() {
			$("form").attr("action", "/board/delete/${bDto.bno}");
			$("form").attr("method","post");
			$("form").submit();	
		}); 
		
		getAllReply(bno, $("#replies"));
	});
	

</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
  <h5 class="my-0 mr-md-auto font-weight-normal">게시판</h5>
  <nav class="my-2 my-md-0 mr-md-3">
    <a class="p-2 text-dark" href="/board/list">목록</a>
    <a class="p-2 text-dark" href="/board/insert">글쓰기</a>
 

  	<c:choose>
		<c:when test="${empty login }">
			<a class="p-2 text-dark" href="/member/loginget">로그인</a>
			 </nav>
			<a class="btn btn-outline-primary" href="#">Sign up</a>
		</c:when>
		<c:otherwise>
			<a class="p-2 text-dark">${login.id} 님 환영합니다.</a> <a class="p-2 text-dark" href="/member/logout">로그아웃</a>
			  </nav>
		</c:otherwise>
		
	</c:choose>
  
<!--     <a class="p-2 text-dark" href="#">Support</a>
    <a class="p-2 text-dark" href="#">Pricing</a> -->

  
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <section class="container-1200 mt-50 mb-50">
    
    
  

  <!-- aside -->
  <aside class="flex-all-center">
  
	<div class= "flex-column ml-auto" style="width: 300px; ">
        <a class="w-100 mb-10" href="${pageContext.request.contextPath}/member/myseal"><button class="form-btn neutral w-100">나의 인장</button></a>
        <a class="w-100 mb-10" href="${pageContext.request.contextPath}/member/edit"><button class="form-btn neutral w-100">개인정보수정</button></a>
        <a class="w-100 mb-10" href="${pageContext.request.contextPath}/member/exit"><button class="form-btn neutral w-100">회원탈퇴</button></a>
  	</div>
  
  
  </aside>
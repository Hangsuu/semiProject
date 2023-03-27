<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<span style="color: green; font-weight: bold;">이메일 인증 (이메일을 인증 받아야 다음 단계로 넘어갈 수 있습니다.)</span> <br> <br>    
        <br> <br>
        
        
 
        
       <div class="row center">
         
       <form action="auth.do" method="post">      
     
           <div>
               이메일 : <input type="email" name="e_mail"
                   placeholder="  이메일주소를 입력하세요. ">
           </div>                                                    

           <br> <br>
           <button type="submit" name="submit">이메일 인증받기 (이메일 보내기)</button>

       
       </form>
       </div>
       
       <form action="join_injeung.do${dice}" method="post"> //받아온 인증코드를 컨트롤러로 넘겨서 일치하는지 확인                  
               
                        <br>
                        <div>
                            인증번호 입력 : <input type="number" name="email_injeung"
                                placeholder="  인증번호를 입력하세요. ">
                        </div>                                        
 
                        <br> <br>
                        <button type="submit" name="submit">인증번호 전송</button>
                        
                        </form>
                        
        

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		$(".search-btn").click(function(){
			var number = $(".search-input").val();
			searchList();
			$(".target .monster-image").each(function(){
				var imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+number+".png";
				$(this).attr("src", imageUrl);
			});
		});
		$(".search-random").click(function(){
			searchList();
			$(".target .monster-image").each(function(){
				var number = Math.floor(Math.random()*1008+1);
				var imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+number+".png";
				$(this).attr("src", imageUrl);
			});
		})
		
		function searchList(){
			var stats = $(".target .stat");
			stats.each(function(){
				var randomValue = Math.floor(Math.random()*32);
				if(randomValue==31){
					$(this).text(randomValue+"(V)");
				}
				else if(randomValue==30){
					$(this).text(randomValue+"(U)");
				}
				else if(randomValue==0){
					$(this).text(randomValue+"(Z)");
				}
				else{
					$(this).text(randomValue);
				}
			})
			var evaluations = $(".target .evaluation");
			evaluations.each(function(){
				var table = $(this).parent().parent();
				var thisStats = table.find(" .stat");
				var sum=0;
				thisStats.each(function(){
					sum+=parseInt($(this).text());
				})
				if(sum>=151) $(this).text("훌륭한 능력을 가지고 있다");
				else if(sum>=121) $(this).text("상당히 우수한 능력을 가지고 있다");
				else if(sum>=90) $(this).text("평균 이상의 힘을 가지고 있다");
				else $(this).text("그럭저럭 힘을 가지고 있다");
			})
		};
	});
</script>

    <div class="container-900 mt-50">
    	<div class="row">
    		<input class="form-input search-input" placeholder="포켓몬 번호 입력">
    		<button class="form-btn neutral search-btn">찾기</button>
    		<button class="form-btn neutral search-random">랜덤</button>
    	</div>
        <div class="row flex-box align-center center target" style="flex-wrap: wrap;">
        	<c:forEach var="statList" items="${list}">
        	<table class="table table-border" style="font-size:13px; width:25%">
                <tr><td colspan="4" style="height:180px">
                	<img class="monster-image" width="180px" height="180px" src="/static/image/leaf.png">
				</td></tr>
                <tr>
                    <td class="w-25">체력</td>
                    <td class="w-25 stat"></td>
                    <td class="w-25">속도</td>
                    <td class="w-25 stat"></td>
                </tr>
                <tr>
                    <td class="w-25">공격</td>
                    <td class="w-25 stat"></td>
                    <td class="w-25">방어</td>
                    <td class="w-25 stat"></td>
                </tr>
                <tr>
                    <td class="w-25">Sp.atk</td>
                    <td class="w-25 stat"></td>
                    <td class="w-25">Sp.def</td>
                    <td class="w-25 stat"></td>
                </tr>
                <tr>
                    <td colspan="4" class="evaluation"></td>
                </tr>
            </table>
        	</c:forEach>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
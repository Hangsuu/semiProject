<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <div class="container-900">
        <div class="row flex-box align-center center" style="flex-wrap: wrap;">
        	<c:forEach var="statList" items="${list}">
        	<table class="table w-25 table-border" style="font-size:13px;">
                <tr><td colspan="4" style="height:180px">
                	<img width="180px" height="180px" src="https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png">
				</td></tr>
                <tr class="w-100">
                    <td class="w-25">체력</td>
                    <td class="w-25">${statList.hp}${statList.hpMent}</td>
                    <td class="w-25">속도</td>
                    <td class="w-25">${statList.speed}${statList.speedMent}</td>
                </tr>
                <tr>
                    <td class="w-25">공격</td>
                    <td class="w-25">${statList.atk}${statList.atkMent}</td>
                    <td class="w-25">방어</td>
                    <td class="w-25">${statList.def}${statList.defMent}</td>
                </tr>
                <tr>
                    <td class="w-25">Sp.atk</td>
                    <td class="w-25">${statList.spAtk}${statList.spAtkMent}</td>
                    <td class="w-25">Sp.def</td>
                    <td class="w-25">${statList.spDef}${statList.spDefMent}</td>
                </tr>
                <tr>
                    <td colspan="4">${statList.evaluation}</td>
                </tr>
            </table>
        	</c:forEach>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
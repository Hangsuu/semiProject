 <%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8"%> 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
 <jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>   

<div class="container-1000 mt-50">
  <div class="row ps-30">
    <h2>회원 목록</h2>
  </div>
  <div class="row flex-box ps-30 mt-20">
		<div class="flex-box">
			<form action="memberManage" method="get" autocomplete="off">
				<select name="column" class="form-input neutral">
					<option value="member_id">아이디</option>
					<option value="member_nick">닉네임</option>
					<option value="member_level">등급</option>
				</select>
				<input name="keyword" class="form-input" placeholder="검색">
				<input name="page" type="hidden" value="${vo.page}">
				<button class="form-btn neutral">검색</button>
			</form>
		</div>
	</div>
  <style>
    .member-row > *:nth-child(1) {
      width: 180px;
    }
    .member-row > *:nth-child(3) {
      width: 150px;
    }
    .member-row > *:nth-child(4) {
      width: 150px;
    }
    .member-row > * {
      width: 170px;
    }
  </style>
  <div class="row mt-50">
    <table class="table table-slit">
      <thead>
        <tr class="ps-10 flex member-row">
          <th>이미지</th>
          <th>아이디</th>
          <th>닉네임</th>
          <th>등급</th>
          <th>포인트</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody class="center">
        <c:if test="${list.size()>0}">
          <c:forEach var="i" begin="0" end="${list.size()-1}">
            <tr class="center ps-10 flex member-row">
              <td>
                <c:choose>
                  <c:when test="${list.get(0).attachmentNo == null}">
                    <img width="100" height="100" src="${urlList.get(i)}">
                  </c:when>
                  <c:otherwise>
                    <img width="100" height="100" src="/attachment/${list.get(i).imageURL}">
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="flex-all-center"><div>${list.get(i).memberId}</div></td>
              <td class="flex-all-center"><div>${list.get(i).memberNick}</div></td>
              <td class="flex-all-center"><div>${list.get(i).memberLevel}</div></td>
              <td class="right flex-all-center"><div>${list.get(i).memberPoint}</div></td>
              <td class="flex-all-center">
                <div class="flex" style="margin : 0 auto;">
	                <a href="memberDetail?memberId=${list.get(i).memberId}" class="form-btn neutral">상세</a>
	                <a href="memberEdit?memberId=${list.get(i).memberId}" class="form-btn neutral">수정</a>
	                <a href="memberDelete?memberId=${list.get(i).memberId}" class="form-btn negative">삭제</a>
                </div>
              </td>
            </tr>
          </c:forEach>
        </c:if>
      </tbody>
    </table>
  </div>
  <!-- 페이지네이션 -->
	<div class="row center pagination">
    <!-- 1페이지로 이동 -->
      <c:choose>
        <c:when test="${vo.first}">
          <a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
        </c:when>
        <c:otherwise>
          <a href="memberManage?${vo.parameter}&page=1"><i class="fa-solid fa-angles-left"></i></a>
        </c:otherwise>
      </c:choose>
    <!-- 이전 페이지로 이동 -->
      <c:choose>
        <c:when test="${vo.prev}">
          <a href="memberManage?${vo.parameter}&page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
        </c:when>
        <c:otherwise>
          <a class="disabled"><i class="fa-solid fa-angle-left disabled"></i></a>
        </c:otherwise>
      </c:choose>
    <!-- 번호들 -->
      <c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}" step="1">
        <c:choose>
          <c:when test="${vo.page==i}"><a class="on disabled">${i}</a></c:when>
          <c:otherwise><a href="memberManage?${vo.parameter}&page=${i}">${i}</a></c:otherwise>
        </c:choose>
      </c:forEach>
    <!-- 다음 페이지 -->
      <c:choose>
        <c:when test="${vo.next}">
          <a href="memberManage?${vo.parameter}&page=${vo.nextPage}" class=""><i class="fa-solid fa-angle-right"></i></a>
        </c:when>
        <c:otherwise><a class="disabled">
          <i class="fa-solid fa-angle-right"></i></a>
        </c:otherwise>
      </c:choose>
    <!-- 마지막페이지로 -->
      <c:choose>
        <c:when test="${!vo.last}">
          <a href="memberManage?${vo.parameter}&page=${vo.totalPage}" class=""><i class="fa-solid fa-angles-right"></i></a>
        </c:when>
        <c:otherwise>
          <a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
        </c:otherwise>
      </c:choose>
    </div>
  <!-- 페이지네이션 끝 -->
</div>

	</article>
            </section>
    			</header>
    			</main>

 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
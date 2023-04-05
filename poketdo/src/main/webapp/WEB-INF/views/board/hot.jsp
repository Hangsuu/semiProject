<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${boardWithImageDto.boardWriter}";
	var allboardNo = "${boardWithImageDto.allboardNo}";
</script>

<c:if test="${sessionScope.memberLevel == '관리자'}">
	<script type="text/javascript"> 
	function checkAll(){
 		var allCheckbox = document.querySelector(".check-all");
 		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
 		for(var i = 0; i < checkboxes.length; i++){
 			checkboxes[i].checked = allCheckbox.checked;
 		}
 	}
 	function checkUnit(){
 		var allCheckbox = document.querySelector(".check-all");
 		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
 		var count = 0;
 		for(var i = 0; i < checkboxes.length; i++){
 			if(checkboxes[i].checked){
 				count++;
 			}
 		}
 		allCheckbox.checked = (checkboxes.length == count);
 	}
 	function formCheck(){
 		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]:checked")
 		if(checkboxes.length == 0) return false;
		
		return confirm("정말 삭제하시겠습니까?");
 	}
 </script> 
</c:if>


<div class="container-800">
	<div class="row center">
		<h1>자유 게시판</h1>
	</div>
	<div class="row center">남을 비방하는 경우 예고 없이 삭제될 수 있습니다</div>

	<c:if test="${sessionScope.memberLevel == '관리자'}">
		<form action="deleteAll" method="post" onsubmit="return formCheck();">
	</c:if>
	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<c:if test="${sessionScope.memberLevel == '관리자'}">
						<!--  전체 선택 체크박스를 배치 -->
						<th><input type="checkbox" class="check-all"
							onchange="checkAll();"></th>
					</c:if>
					<th>번호</th>
					<th class="w-40">제목</th>
					<th class="left">작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody class="center">

				<!-- 공지사항을 출력 -->
                    <c:forEach var="boardWithImageDto" items="${noticeList}">
                    <tr style="background-color:#eee">
                        <c:if test="${sessionScope.memberLevel == '관리자'}">
                        <td></td>
                        </c:if>
                        <td>${boardWithImageDto.boardNo}</td>
                        <td class="left">
                            <!-- 제목을 누르면 상세로 이동 -->
                            <a href="detail2?allboardNo=${boardWithImageDto.allboardNo}" class="link">
                                
                                <c:if test="${boardWithImageDto.boardHead != null}">
                                    <!-- 말머리가 있으면 출력 -->
                                    [${boardWithImageDto.boardHead}]
                                </c:if>
                                
                                ${boardWithImageDto.boardTitle} 
                                <span style="color:red;"><c:if test="${boardWithImageDto.boardReply != 0}">(${boardWithImageDto.boardReply})</c:if></span>
                            </a>
                        </td>
                        <td class="left">
                        <img class="board-seal" src="${boardWithImageDto.urlLink}">${boardWithImageDto.memberNick}</td>
                        
                        <%-- DTO에 만든 가상의 Getter 메소드를 불러 처리 --%>
                        <td>${boardWithImageDto.boardTime}</td>
                        
                        <td>${boardWithImageDto.boardRead}</td>
                        <td>${boardWithImageDto.boardLike}</td>
                    </tr>
                    </c:forEach>

				<!-- 검색 또는 목록 결과를 출력 -->
				<c:forEach var="boardWithImageDto" items="${hot}">
					<tr>
						<c:if test="${sessionScope.memberLevel == '관리자'}">
							<!--  개별 선택 체크박스를 배치 -->
							<td><input type="checkbox" name="boardNo"
								value="${boardWithImageDto.boardNo}" onchange="checkUnit();">
							</td>
						</c:if>
						<td>${boardWithImageDto.boardNo}</td>
						<td class="left">
							<!-- 제목을 누르면 상세로 이동 --> <a
							href="detail2?allboardNo=${boardWithImageDto.getAllboardNo()}" class="link">

								<c:if test="${boardWithImageDto.boardHead != null}">
									<!-- 말머리가 있으면 출력 -->
                                    [${boardWithImageDto.boardHead}]
                                </c:if> ${boardWithImageDto.boardTitle} <span
								style="color: red;"><c:if
										test="${boardWithImageDto.boardReply != 0}">(${boardWithImageDto.boardReply})</c:if></span>
						</a>
						</td>
						<td class="left">
						<img class="board-seal" src="${boardWithImageDto.urlLink}">${boardWithImageDto.memberNick}</td>

						<%-- DTO에 만든 가상의 Getter 메소드를 불러 처리 --%>
						<td>${boardWithImageDto.boardTime}</td>

						<td>${boardWithImageDto.boardRead}</td>
						<td>${boardWithImageDto.boardLike}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="row right">
		<c:if test="${sessionScope.memberLevel == '관리자'}">
			<button type="submit" class="form-btn negative">삭제</button>
		</c:if>
		<a href="write" class="form-btn positive">글쓰기</a>
	</div>
	</form>

	<div class="row pagination">

		<!-- 처음 -->
		<c:choose>
			<c:when test="${vo.first}">
				<a class="disabled">&laquo;</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.parameter}&page=1">&laquo;</a>
			</c:otherwise>
		</c:choose>

		<!-- 이전 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?${vo.parameter}&page=${vo.prevPage}">&lt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&lt;</a>
			</c:otherwise>
		</c:choose>

		<!-- 숫자 -->
		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
			<c:choose>
				<c:when test="${vo.page == i}">
					<a class="on">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 다음 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?${vo.parameter}&page=${vo.nextPage}">&gt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&gt;</a>
			</c:otherwise>
		</c:choose>

		<!-- 마지막 -->
		<c:choose>
			<c:when test="${vo.last}">
				<a class="disabled">&raquo;</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.parameter}&page=${vo.totalPage}">&raquo;</a>
			</c:otherwise>
		</c:choose>
	</div>

	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get">

			<c:choose>
				<c:when test="${vo.column == 'board_content'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content" selected>내용</option>
						<option value="member_nick">작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_writer'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content">내용</option>
						<option value="member_nick" selected>작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_head'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content">내용</option>
						<option value="member_nick">작성자</option>
						<option value="board_head" selected>말머리</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="column" class="form-input">
						<option value="board_title" selected>제목</option>
						<option value="board_content">내용</option>
						<option value="member_nick">작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:otherwise>
			</c:choose>


			<input class="form-input" type="search" name="keyword"
				placeholder="검색어" required value="${vo.keyword}">

			<button type="submit" class="form-btn neutral">검색</button>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>  

  <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script type="text/javascript">
        $(function(){
            //목표
            //1. 전체 체크박스 체크 시 개별 항목 + 전체 항목 처리
            //2. 개별 항목 체크 시 전체 항목 처리

            //[1]
            $(".check-all").change(function(){
                // this == 체크된 체크박스
                var isChecked = $(this).prop("checked");

                //$(".check-all").prop("checked", ischecked);
                $(".check-all, .check-unit").prop("checked", isChecked);
            });

            //[2]
            $(".check-unit").change(function(){
                var checkboxCount = $(".check-unit").length;
                var checkedCount = $(".check-unit:checked").length;
                var isAllChecked = checkboxCount == checkedCount;

                $(".check-all").prop("checked", isAllChecked);
            });
        });
    </script>
    
<div class="container-800">
        <div class="row center">
            <h1>인기글 게시판</h1>
        </div>
        <div class="row center">
            남을 비방하는 경우 예고 없이 삭제될 수 있습니다
        </div>
        
        <c:if test="${sessionScope.memberLevel == '관리자'}">
        <form action="deleteAll" method="post" onsubmit="return formCheck();">
        </c:if>
        <div class="row right">
            <c:if test="${sessionScope.memberLevel == '관리자'}">
            <button type="submit" class="form-btn negative">삭제</button>
            </c:if>
        </div>
        <div class="row">
            <table class="table table-border">
                <thead>
                <tr>
                    <c:if test="${sessionScope.memberLevel == '관리자'}">
                    <!--  전체 선택 체크박스를 배치 -->
                    <th>
                        <input type="checkbox" class="check-all" onchange="checkAll();">
                    </th>
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
                    <c:forEach var="boardDto" items="${selectNoticeList}">
                    <tr style="background-color:#eee">
                        <c:if test="${sessionScope.memberLevel == '관리자'}">
                        <td></td>
                        </c:if>
                        <td>${boardDto.boardNo}</td>
                        <td class="left">
                            <!-- 제목을 누르면 상세로 이동 -->
                            <a href="detail?boardNo=${boardDto.boardNo}" class="link">
                                
                                <c:if test="${boardDto.boardHead != null}">
                                    <!-- 말머리가 있으면 출력 -->
                                    [${boardDto.boardHead}]
                                </c:if>
                                
                                ${boardDto.boardTitle}(${boardDto.boardReply})
                            </a>
                        </td>
                        <td class="left">${boardDto.boardWriter}</td>
                        
                        <td>${boardDto.boardTimeAuto}</td>
                        
                        <td>${boardDto.boardRead}</td>
                        <td>${boardDto.boardLike}</td>
                    </tr>
                    </c:forEach>
                    
                    <!-- 검색 또는 목록 결과를 출력 -->
                    <c:forEach var="boardDto" items="${list}">
                    <tr>
                    <c:if test="${sessionScope.memberLevel == '관리자'}">
                    <!--  개별 선택 체크박스를 배치 -->
                        <td>
                        <input type="checkbox" class="check-unit" name="boardNo" value="${boardDto.boardNo}">
                        </td>
                        </c:if>
                        <td>${boardDto.boardNo}</td>
                        <td class="left">
                            <!-- 제목을 누르면 상세로 이동 -->
                            <a href="detail?boardNo=${boardDto.boardNo}" class="link">
                                
                                <c:if test="${boardDto.boardHead != null}">
                                    <!-- 말머리가 있으면 출력 -->
                                    [${boardDto.boardHead}]
                                </c:if>
                                
                                ${boardDto.boardTitle}
                            </a>
                        </td>
                        <td class="left">${boardDto.boardWriter}</td>
                        
                        <td>${boardDto.boardTimeAuto}</td>
                        
                        <td>${boardDto.boardRead}</td>
                        <td>${boardDto.boardLike}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="row right">
        <c:if test="${sessionScope.memberLevel == '관리자'}">
            <button type="submit" class="form-btn negative">삭제</button>
            </c:if>
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
                            <option value="board_writer">작성자</option>
                            <option value="board_head">말머리</option>
                        </select>
                    </c:when>
                    <c:when test="${vo.column == 'board_writer'}">
                        <select name="column" class="form-input">
                            <option value="board_title">제목</option>
                            <option value="board_content">내용</option>
                            <option value="board_writer" selected>작성자</option>
                            <option value="board_head">말머리</option>
                        </select>
                    </c:when>
                    <c:when test="${vo.column == 'board_head'}">
                        <select name="column" class="form-input">
                            <option value="board_title">제목</option>
                            <option value="board_content">내용</option>
                            <option value="board_writer">작성자</option>
                            <option value="board_head" selected>말머리</option>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select name="column" class="form-input">
                            <option value="board_title" selected>제목</option>
                            <option value="board_content">내용</option>
                            <option value="board_writer">작성자</option>
                            <option value="board_head">말머리</option>
                        </select>
                    </c:otherwise>
                </c:choose>
                
                
                <input class="form-input" type="search" name="keyword" placeholder="검색어" required value="${vo.keyword}">
                
                <button type="submit" class="form-btn neutral">검색</button>
            </form>
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
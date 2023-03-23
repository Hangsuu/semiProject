<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>  

  <c:if test="${sessionScope.memberLevel == '������'}">
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
		
		return confirm("���� �����Ͻðڽ��ϱ�?");
	}
</script>
</c:if>


<div class="container-800">
    <div class="row center">
        <h1>���� �Խ���</h1>
    </div>
    <div class="row center">
        ���� ����ϴ� ��� ���� ���� ������ �� �ֽ��ϴ�
    </div>
    
    <c:if test="${sessionScope.memberLevel == '������'}">
    <form action="deleteAll" method="post" onsubmit="return formCheck();">
    </c:if>
    <div class="row right">
    	<c:if test="${sessionScope.memberLevel == '������'}">
    	<button type="submit" class="form-btn negative">����</button>
    	</c:if>
        <a href="write" class="form-btn positive">�۾���</a>
    </div>
    <div class="row">
        <table class="table table-border">
            <thead>
            <tr>
                <c:if test="${sessionScope.memberLevel == '������'}">
                <!--  ��ü ���� üũ�ڽ��� ��ġ -->
                <th>
                	<input type="checkbox" class="check-all" onchange="checkAll();">
                </th>
                </c:if>
                    <th>��ȣ</th>
                    <th class="w-40">����</th>
                    <th class="left">�ۼ���</th>
                    <th>�ۼ���</th>
                    <th>��ȸ��</th>
                    <th>���ƿ�</th>
                </tr>
            </thead>
            <tbody class="center">
            
            	<!-- ���������� ��� -->
				<c:forEach var="boardDto" items="${noticeList}">
				<tr style="background-color:#eee">
					<c:if test="${sessionScope.memberLevel == '������'}">
					<td></td>
					</c:if>
					<td>${boardDto.boardNo}</td>
					<td class="left">
						<!-- ������ ������ �󼼷� �̵� -->
						<a href="detail?boardNo=${boardDto.boardNo}" class="link">
							
							<c:if test="${boardDto.boardHead != null}">
								<!-- ���Ӹ��� ������ ��� -->
								[${boardDto.boardHead}]
							</c:if>
							
							${boardDto.boardTitle}
						</a>
					</td>
					<td class="left">${boardDto.boardWriter}</td>
					
					<%-- DTO�� ���� ������ Getter �޼ҵ带 �ҷ� ó�� --%>
					<td>${boardDto.boardTimeAuto}</td>
					
					<td>${boardDto.boardRead}</td>
					<td>${boardDto.boardLike}</td>
				</tr>
				</c:forEach>
				
				<!-- �˻� �Ǵ� ��� ����� ��� -->
				<c:forEach var="boardDto" items="${list}">
				<tr>
				<c:if test="${sessionScope.memberLevel == '������'}">
				<!--  ���� ���� üũ�ڽ��� ��ġ -->
					<td>
					<input type="checkbox" name="boardNo" value="${boardDto.boardNo }"
						onchange="checkUnit();">
					</td>
					</c:if>
					<td>${boardDto.boardNo}</td>
					<td class="left">
						<!-- ������ ������ �󼼷� �̵� -->
						<a href="detail?boardNo=${boardDto.boardNo}" class="link">
							
							<c:if test="${boardDto.boardHead != null}">
								<!-- ���Ӹ��� ������ ��� -->
								[${boardDto.boardHead}]
							</c:if>
							
							${boardDto.boardTitle}
							<c:if test="${boardDto.boardReply != 0}">(${board_reply})</c:if>
						</a>
					</td>
					<td class="left">${boardDto.boardWriter}</td>
					
					<%-- DTO�� ���� ������ Getter �޼ҵ带 �ҷ� ó�� --%>
					<td>${boardDto.boardTimeAuto}</td>
					
					<td>${boardDto.boardRead}</td>
					<td>${boardDto.boardLike}</td>
				</tr>
				</c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row right">
    <c:if test="${sessionScope.memberLevel == '������'}">
    	<button type="submit" class="form-btn negative">����</button>
    	</c:if>
        <a href="write" class="form-btn positive">�۾���</a>
    </div>
    </form>
    
    <div class="row pagination">
    
    	<!-- ó�� -->
    	<c:choose>
			<c:when test="${vo.first}">
				<a class="disabled">&laquo;</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.parameter}&page=1">&laquo;</a>
			</c:otherwise>
		</c:choose>
		
		<!-- ���� -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?${vo.parameter}&page=${vo.prevPage}">&lt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&lt;</a>
			</c:otherwise>
		</c:choose>
		
        <!-- ���� -->
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
	
		<!-- ���� -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?${vo.parameter}&page=${vo.nextPage}">&gt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&gt;</a>
			</c:otherwise>
		</c:choose>
		
		<!-- ������ -->
		<c:choose>
			<c:when test="${vo.last}">
				<a class="disabled">&raquo;</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.parameter}&page=${vo.totalPage}">&raquo;</a>
			</c:otherwise>
		</c:choose>
    </div>
    
    <!-- �˻�â -->
    <div class="row center">
		<form action="list" method="get">
		
			<c:choose>
				<c:when test="${vo.column == 'board_content'}">
					<select name="column" class="form-input">
						<option value="board_title">����</option>
						<option value="board_content" selected>����</option>
						<option value="board_writer">�ۼ���</option>
						<option value="board_head">���Ӹ�</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_writer'}">
					<select name="column" class="form-input">
						<option value="board_title">����</option>
						<option value="board_content">����</option>
						<option value="board_writer" selected>�ۼ���</option>
						<option value="board_head">���Ӹ�</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_head'}">
					<select name="column" class="form-input">
						<option value="board_title">����</option>
						<option value="board_content">����</option>
						<option value="board_writer">�ۼ���</option>
						<option value="board_head" selected>���Ӹ�</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="column" class="form-input">
						<option value="board_title" selected>����</option>
						<option value="board_content">����</option>
						<option value="board_writer">�ۼ���</option>
						<option value="board_head">���Ӹ�</option>
					</select>
				</c:otherwise>
			</c:choose>
			
			
			<input class="form-input" type="search" name="keyword" placeholder="�˻���" required value="${vo.keyword}">
			
			<button type="submit" class="form-btn neutral">�˻�</button>
		</form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
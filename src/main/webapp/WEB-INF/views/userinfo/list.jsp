<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 헤더 include -->
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mystyle2.css">
		
<script type="text/javascript">
function setCriteria(keyword) {
	var amount = $("#amount").val();
	var groupSize = $("#groupSize").val();
	
	location.href = "/userinfo/list?pageNum=1&amount=" + amount + "&groupSize=" + groupSize + "&keyword=" + keyword;
}
</script>
        <!-- 메인 컨텐츠 영역 -->
        <div class="contents">
            <div class="user-list">
            	<p align="right"> 페이지당 아이템 갯수
            		<select id="amount" name="amount" onchange="setCriteria('${keyword}')">
            			<c:forEach var="amountEntry" begin="5" end="30" step="5">
            			<option value="${amountEntry}" <c:if test="${amountEntry eq page.cri.amount}">selected</c:if>>${amountEntry}</option>
            			</c:forEach>
            		</select>
            	</p>
            	<p align="right"> 몇 페이지씩 출력?
            		<select id="groupSize" name="groupSize" onchange="setCriteria('${keyword}')">
            			<c:forEach var="groupSizeEntry" begin="5" end="10" step="5">
            			<option value="${groupSizeEntry}" <c:if test="${groupSizeEntry eq page.cri.groupSize}">selected</c:if>>${groupSizeEntry}</option>
            			</c:forEach>
            		</select>
            	</p>
            	<!-- 그리고 완전삭제 기능 추가해라. -->
            	<h3 class="table_title">회원목록</h3>
            	<p class="table_cnt">총 ${page.total}개</p>
                <table border='1'>
	                <caption><strong>회원목록</strong></caption>
	                <colgroup>
	                	<col width="10%">
	                	<col width="20%">
	                	<col width="10%">
	                	<col width="15%">
	                	<col width="10%">
	                	<col width="10%">
	                	<col width="15%">
	                	<col width="10%">
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No</th>
	                        <th>아이디</th>
	                        <th>이름</th>
	                        <th>생년월일</th>
	                        <th>성별</th>
	                        <th>최종학력</th>
	                        <th>등록일</th>
	                        <th>보기</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="userinfo" items="${list}">
	                	<tr>
	                        <td>${userinfo.u_idx}</td>
	                        <td>${userinfo.u_id}</td>
	                        <td>${userinfo.u_name}</td>
	                        <td>${userinfo.u_birth}</td>
	                        <td>${userinfo.u_gender eq "M" ? "남자" : "여자"}</td>
	                        <td>
	                        	<c:set var="edu" value="${userinfo.u_edu}" />
	                        	<c:choose>
	                        		<c:when test="${edu eq 'univ'}">대졸</c:when>
	                        		<c:when test="${edu eq 'high'}">고졸</c:when>
	                        		<c:when test="${edu eq 'middle'}">중졸</c:when>
	                        		<c:otherwise>유딩</c:otherwise>
	                        	</c:choose>
	                        </td>
	                        <td>
	                        	<fmt:formatDate var="formattedDate" pattern="yyyy-MM-dd" value="${userinfo.cret_date}" />
	                        	<c:out value="${formattedDate}"/>
	                        </td>
	                        <td><a href="/userinfo/view?u_idx=${userinfo.u_idx}&pageNum=${page.cri.pageNum }&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button>보기</button></a></td>
	                    </tr>
	                	</c:forEach>
	                </tbody>
	            </table>
                <div class="list">
                    <span class="list-button"><a href="/userinfo/list?pageNum=1&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}">[처음]</a></span>
                    <c:if test="${page.prev eq true}" >
                    <span class="list-button"><a href="/userinfo/list?pageNum=${page.startPage - 1}&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}">[이전]</a></span>
                    </c:if>
                    <span class="list-button">
                    	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    	<c:if test="${i eq page.cri.pageNum}"><b></c:if>
                        <a href="/userinfo/list?pageNum=${i}&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}">${i}</a>
                        <c:if test="${i eq page.cri.pageNum}"></b></c:if>
                        </c:forEach>
                    </span>
                    <c:if test="${page.next eq true}" >
                    <span class="list-button"><a href="/userinfo/list?pageNum=${page.endPage + 1}&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}">[다음]</a></span>
                    </c:if>
                    <span class="list-button"><a href="/userinfo/list?pageNum=${page.realEnd}&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}">[마지막]</a></span>
                </div>
                <div class="search">
                    <form action="/userinfo/list?pageNum=1&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}" method="GET" name="search" onsubmit="return formchk();">
                        <label for="keyword"><input type="text" name="keyword" value="${keyword}" placeholder="이름 입력"></label>
                        <input type="submit" value="검색">
                    </form>
                </div>
                <a href="/userinfo/register?pageNum=${page.cri.pageNum}&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button id="register-button">등록</button></a>
            </div>
        </div>
        <!-- 메인 컨텐츠 영역 끝 -->
        
    <!-- 헤더에서 시작된 wrapper 클래스 div 태그 닫아주기 -->
    </div>
    
<!-- 푸터 include -->
<jsp:include page="../include/footer.jsp" />
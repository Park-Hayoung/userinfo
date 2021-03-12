<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 헤더 include -->
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mystyle.css">
<script type="text/javascript">
function deleteprocess(target) {
	if (confirm("해당 회원을 삭제하시겠습니까?")) {
		location.href = "/userinfo/delete?u_idx=" + target;
	}
}
</script>
		<!-- 메인 컨텐츠 영역 -->
        <div class="contents">
            <div class="user-insert-form">
                <table border="1">
                    <caption>회원정보</caption>
                    <tbody>
                        <tr>
                            <th>아이디</th>
                            <td>${userInfo.u_id }</td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>${userInfo.u_name }</td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td>${userInfo.u_birth }</td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td>${userInfo.u_gender eq "M" ? "남자" : "여자" }</td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td>${userInfo.u_email }</td>
                        </tr>
                        <tr>
                            <th>휴대폰번호</th>
                            <td>${userInfo.u_phone }</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>${userInfo.u_tel }</td>
                        </tr>
                        <tr>
                            <th>취미</th>
                            <td>${userInfo.u_hobby }</td>
                        </tr>
                        <tr>
                            <th>최종학력</th>
                            <td>
                            	<c:set var="edu" value="${userInfo.u_edu }"/>
                            	<c:choose>
                        			<c:when test="${edu eq 'univ'}">대졸</c:when>
                        			<c:when test="${edu eq 'high'}">고졸</c:when>
                        			<c:when test="${edu eq 'middle'}">중졸</c:when>
                        			<c:otherwise>유딩</c:otherwise>
                        		</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>참고사항</th>
                            <td>
                                <ul>
                                    <li>위의 입력 항목을 모두 만들어주세요.</li>
                                    <li>비밀번호는 출력하지 않습니다.</li>
                                    <li>수정버튼을 클릭시 수정페이지로 이동을 합니다.</li>
                                    <li>삭제버튼을 클릭시 삭제 확인창을 출력 후 선택에 따라 처리해주세요.</li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="button">
                    <a href="/userinfo/update?u_idx=${userInfo.u_idx}&pageNum=${page.cri.pageNum }&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button type="button">수정</button></a>
                    <button onclick="deleteprocess(${userInfo.u_idx});">삭제</button>
                    <a href="/userinfo/list?pageNum=${page.cri.pageNum }&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button type="button">목록</button></a>
                </div>
            </div>
        </div>
        <!-- 메인 컨텐츠 영역 끝 -->

<!-- 푸터 include -->
<jsp:include page="../include/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!-- 헤더 include -->
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mystyle.css">
<script>
var isPwChecked = false;

$(document).ready(function() {
	
});
function submitForm(frm) {
	if (checkForm(frm)) {
		frm.u_email.value = frm.email1.value + "@" + frm.email2.value;
		frm.u_phone.value = frm.phone1.value + "-" + frm.phone2.value + "-" + frm.phone3.value;
		frm.u_tel.value = frm.tel1.value + "-" + frm.tel2.value + "-" + frm.tel3.value;
		var hobbyList = document.getElementsByName("hobby[]");
		var hobby = "";
		for (var i = 0; i < hobbyList.length; i++) {
			if (hobbyList[i].checked) {
				hobby += hobbyList[i].value;
				hobby += ",";
			}
		}
		frm.u_hobby.value = hobby.substring(0, hobby.length - 1); // 마지막 ',' 제거

		frm.submit();
	}
}

function checkForm(frm) {
	if (frm.email1.value == "" || frm.email2.value == "") {
		alert("이메일을 입력해주세요.");
		return false;
	}
	if (frm.phone1.value == "" || frm.phone2.value == "" || frm.phone3.value == "") {
		alert("휴대폰번호를 입력해주세요.");
		return false;
	}
	if (frm.tel1.value == "" || frm.tel2.value == "" || frm.tel3.value == "") {
		alert("전화번호를 입력해주세요.");
		return false;
	}
	if (!isHobbyChecked()) {
		alert("취미를 한 개 이상 선택해주세요.");
		return false;
	}
	if (frm.u_edu.value == "") {
		alert("최종학력을 선택해주세요.");
		return false;
	}
	if (!isPwChecked) {
		alert("비밀번호 인증을 완료해주세요.");
		return false;
	}

	return true;
}

function isHobbyChecked() {
	// 취미 한 개 이상 선택되었는지 검사하기
	var hobbyList = document.getElementsByName("hobby[]");
	var isHobbyChecked = false;
	for (var i = 0; i < hobbyList.length; i++) {
		if (hobbyList[i].checked == true) {
			isHobbyChecked = true;
			break;
		}
	}
	return isHobbyChecked;
}

function pwCheck(id, pw1, pw2) {
	if (pw1 == "") {
		alert("비밀번호를 입력해주세요.");
		return;
	}
	if (pw2 == "") {
		alert("비밀번호 확인을 입력해주세요.");
		return;
	}
	if (pw1 != pw2) {
		alert("입력한 비밀번호가 서로 일치하지 않습니다.");
		return;
	}
	
	$.ajax({
		url: "/userinfo/pwCheck",
		type: "POST",
		data: { u_id: id, u_pw: pw1 },
		cache: false,
		success: function(result) {
			if (result == '1') {
				alert("비밀번호가 일치합니다.");
				isPwChecked = true;
			} else {
				alert("비밀번호가 일치하지 않습니다.");
			}
		},
		error: function(request, status, error) {
			alert("오류가 발생했습니다.");
		}
	});
}
</script>

		<!-- 메인 컨텐츠 영역 -->
        <div class="contents">
            <div class="user-insert-form">
                <form id="frm" name="frm" action="/userinfo/update" method="POST" onsubmit="return false">
                    <input type="hidden" name="u_idx" value="${userInfo.u_idx }">
                    <input type="hidden" name="pageNum" value="${page.cri.pageNum}">
                    <input type="hidden" name="amount" value="${page.cri.amount}">
                    <input type="hidden" name="groupSize" value="${page.cri.groupSize}">
                    <input type="hidden" name="keyword" value="${keyword}">
                    <table border="1">
                        <caption>회원등록</caption>
                        <tbody>
                            <tr>
                                <th>아이디</th>
                                <td>
                                    <input type="text" name="u_id" value="${userInfo.u_id}" readonly>
                                    <span>영소문자, 숫자조합으로 6~16자리로 입력하세요</span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td>
                                    <input type="password" name="u_pw">
                                    <span>영소문자, 숫자, 특수문자(~!@#$^&*) 조합으로 8~20자리</span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호 확인</th>
                                <td>
                                    <input type="password" name="u_pw2">
                                    <a><button onclick="pwCheck('${userInfo.u_id}', frm.u_pw.value, frm.u_pw2.value)">확인</button></a>
                                </td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td>
                                    <input type="text" name="u_name" value="${userInfo.u_name }" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th>생년월일</th>
                                <td>
                                    <input type="text" name="u_birth" value="${userInfo.u_birth }" readonly>
                                    <span>예, 2000-01-01</span>
                                </td>
                            </tr>
                            <tr>
                                <th>성별</th>
                                <td>
                                    <c:choose>
                                    	<c:when test="${userInfo.u_gender eq 'M' }">
                                    		<label><input type="radio" name="u_gender" value="M" checked disabled>남성</label>
                                    		<label><input type="radio" name="u_gender" value="F" disabled>여성</label>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<label><input type="radio" name="u_gender" value="M" disabled>남성</label>
                                    		<label><input type="radio" name="u_gender" value="F" checked disabled>여성</label>
                                    	</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                    <c:set var="email" value="${fn:split(userInfo.u_email, '@')}" />
                                    <input type="hidden" name="u_email">
                                    <input type="text" name="email1" value="${email[0]}"> @ 
                                    <input type="text" name="email2" value="${email[1]}">
                                </td>
                            </tr>
                            <tr>
                                <th>휴대폰번호</th>
                                <td>
                                	<input type="hidden" name="u_phone">
                                    <select name="phone1">
                                    	<c:set var="phone" value="${fn:split(userInfo.u_phone, '-')}" />
                                    	<c:set var="phoneList">010,011,016</c:set>
                                    	<c:forEach var="item" items="${phoneList}">
                                    		<option value="${item}" <c:if test="${item eq phone[0]}">selected</c:if>>
                                    			<c:out value="${item}" />
                                    		</option>
                                    	</c:forEach>
                                    </select> -
                                    <input type="text" name="phone2" value="${phone[1]}"> -
                                    <input type="text" name="phone3" value="${phone[2]}">
                                </td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>
                                	<input type="hidden" name="u_tel">
                                    <select name="tel1" id="">
                                        <c:set var="tel" value="${fn:split(userInfo.u_tel, '-')}" />
                                    	<c:set var="telList">02,031,043</c:set>
                                    	<c:forEach var="item" items="${telList}">
                                    		<option value="${item}" <c:if test="${item eq tel[0]}">selected</c:if>>
                                    			<c:out value="${item}" />
                                    		</option>
                                    	</c:forEach>
                                    </select> - 
                                    <input type="text" name="tel2" value="${tel[1]}"> - 
                                    <input type="text" name="tel3" value="${tel[2]}">
                                </td>
                            </tr>
                            <tr>
                                <th>취미</th>
                                <td>
                                	<input type="hidden" name="u_hobby">
                                	<c:set var="hobby" value="${fn:split(userInfo.u_hobby, ',')}" />
                                	<c:set var="index" value="${0}" />
                                	<c:forEach var="item" items="${hobbyList}" varStatus="status">
                                		<label><input type="checkbox" name="hobby[]" value="${item}" <c:if test="${hobbyMap[item] eq true}">checked</c:if>>${item}</label>
                                	</c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <th>최종학력</th>
                                <td>
                                    <select name="u_edu" id="">
                                    	<c:set var="edu" value="${userInfo.u_edu}" />
                                    	<c:set var="eduList">middle,high,univ</c:set>
                                    	<c:set var="eduListKor" value="${fn:split('중졸,고졸,대졸', ',')}" />
                                    	<c:forEach var="item" items="${eduList}" varStatus="status">
                                    		<option value="${item}" <c:if test="${item eq edu}">selected</c:if>>${eduListKor[status.index]}</option>
                                    	</c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>참고사항</th>
                                <td>
                                    <ul>
                                        <li>위의 입력 항목을 모두 만들어주세요.</li>
                                        <li>모든 항목의 입력값에 대하여 DB에 입력전 유효성 검사를 해주세요.</li>
                                        <li>비밀번호확인의 입력값이 기존의 비밀번호와 일치할 경우만 수정이 되게 해주세요.</li>
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="button">
                        <input type="submit" value="저장" onclick="submitForm(this.form)">
                        <a href="/userinfo/view?u_idx=${userInfo.u_idx}&pageNum=${page.cri.pageNum }&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button type="button">취소</button></a>
                        <a href="/userinfo/list?pageNum=${page.cri.pageNum }&amount=${page.cri.amount}&groupSize=${page.cri.groupSize}&keyword=${keyword}"><button type="button">목록</button></a>
                    </div>
                </form>
            </div>
        </div>
        <!-- 메인 컨텐츠 영역 끝 -->

<!-- 푸터 include -->
<jsp:include page="../include/footer.jsp" />
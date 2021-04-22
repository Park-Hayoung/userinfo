<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 헤더 include -->
<jsp:include page="../include/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mystyle.css">
		
<script type="text/javascript">
var isIdChecked = false;

function setCriteria(keyword) {
	var amount = $("#amount").val();
	var groupSize = $("#groupSize").val();
	
	location.href = "/userinfo/list?pageNum=1&amount=" + amount + "&groupSize=" + groupSize + "&keyword=" + keyword;
}

function checkForm() {
    var idRegExp = /^[A-Za-z0-9]{6,16}$/;
    var pwRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$^&*])[A-Za-z\d~!@#$^&*]{8,20}$/;
    var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
    var nameRegExp = /^[가-힣]+$/;
    var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var email = reg.email1.value + '@' + reg.email2.value;
    var phoneRegExp = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;
    var phone = reg.phone1.value + '-' + reg.phone2.value + '-' + reg.phone3.value;
    var telRegExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
    var tel = reg.tel1.value + '-' + reg.tel2.value + '-' + reg.tel3.value;

    if (reg.u_id.value == "") {
        alert("아이디를 입력하세요.");
        return false;
    }
    if (!idRegExp.test(reg.u_id.value)) {
        alert("아이디는 영소문자, 숫자조합으로 6~16자리로 입력하세요.");
        return false;
    }
    if (reg.u_pw.value == "") {
        alert("비밀번호를 입력하세요.");
        return false;
    }
    if (!pwRegExp.test(reg.u_pw.value)) {
        alert("비밀번호는 영소문자, 숫자, 특수문자(~!@#$^&*) 조합으로 8~20자리로 입력하세요.");
        return false;
    }
    if (reg.u_pw2.value == "") {
        alert("비밀번호 확인을 입력하세요.");
        return false;
    }
    if (reg.u_pw.value != reg.u_pw2.value) {
        alert("비밀번호 확인값이 다릅니다.");
        return false;
    }
    if (reg.u_name.value == "") {
        alert("이름을 입력하세요.");
        return false;
    }
    if (!nameRegExp.test(reg.u_name.value)) {
        alert("이름을 확인하세요.");
        return false;
    }
    if (reg.u_birth.value == "") {
        alert("생년월일을 입력하세요.");
        return false;
    }
    if (!dayRegExp.test(reg.u_birth.value)) {
        alert("생년월일을 확인하세요.");
        return false;
    }
    if (reg.email1.value == "" || reg.email2.value == "") {
        alert("이메일을 입력하세요.");
        return false;
    }
    if (!emailRegExp.test(email)) {
        alert("이메일을 확인하세요.");
        return false;
    }
    if (reg.phone1.selectedIndex < 1 || reg.phone2.value == ""
        || reg.phone3.value == "") {
        alert("휴대폰번호를 입력하세요.");
        return false;
    }
    if (!phoneRegExp.test(phone)) {
        alert("휴대폰번호를 확인하세요.");
        return false;
    }
    if (reg.tel1.selectedIndex < 1 || reg.tel2.value == ""
        || reg.tel3.value == "") {
        alert("전화번호를 입력하세요.");
        return false;
    }
    if (!telRegExp.test(tel)) {
        alert("전화번호를 확인하세요.");
        return false;
    }
    if(!isHobbyChecked()){
        alert("취미를 한 개 이상 선택해주세요.");
        return false;
    }
    if (reg.u_edu.selectedIndex < 1) {
        alert("최종학력을 선택해주세요.");
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

function submitForm(frm) {
	if (checkForm(frm)) {
		frm.u_email.value = frm.email1.value + "@" + frm.email2.value;
		frm.u_phone.value = frm.phone1.value + "-" + frm.phone2.value + "-" + frm.phone3.value;
		frm.u_tel.value = frm.tel1.value + "-" + frm.tel2.value + "-" + frm.tel3.value;
		frm.u_hobby.value = getHobby();

		frm.submit();
	}
}

function getHobby() {
	// 취미1, 취미2, 취미3 ... 형식의 취미 문자열 리턴
	var hobbyList = document.getElementsByName("hobby[]");
	var hobby = "";
	for (var i = 0; i < hobbyList.length; i++) {
		if (hobbyList[i].checked) {
			hobby += hobbyList[i].value;
			hobby += ",";
		}
	}
	
	return hobby.substring(0, hobby.length - 1); // 마지막 ',' 제거
}

function idCheck(id) {
	// 아이디 유효성 검사
	if (id == "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	if (!testId(id)) {
		alert("영소문자, 숫자조합으로 6~16자리로 입력하세요");
		return;
	}

	// 아이디 유효성 검사를 통과하면 아이디가 중복되는지 확인
	$.ajax({
		url: "/userinfo/idCheck",
		type: "POST",
		data: { u_id: id },
		cache: false,
		success: function(result) {
			if (result == '1') {
				alert("이미 존재하는 아이디입니다.");
			} else if (result == '0') {
				alert("사용 가능한 아이디입니다.");
				isIdChecked = true;
			} else {
				alert("아이디 확인 과정에서 오류가 발생했습니다.");
			}
		},
		error: function(request, status, error) {
			alert("오류가 발생했습니다.");
		}
	});
}

function testId(id) {
	var idRegExp = /^[A-Za-z0-9]{6,16}$/;
	if (!idRegExp.test(id)) {
		return false;
	}
	return true;
}

function testPassword(pw) {
	var pwRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$^&*])[A-Za-z\d~!@#$^&*]{8,20}$/;
	var resultObj = $("#password_result");
	var result = "";
	if (!pwRegExp.test(pw)) {
		result = "영소문자, 숫자, 특수문자(~!@#$^&*) 조합으로 8~20자리";
	} else {
		result = "사용 가능한 비밀번호입니다.";
	}
	resultObj.text(result);
}
</script>
        <!-- 메인 컨텐츠 영역 -->
        <div class="contents">
            <div class="user-insert-form">
                <form action="/userinfo/register" method="POST" name="reg" onsubmit="return false">
                    <table border="1">
                        <caption>회원등록</caption>
                        <tbody>
                            <tr>
                                <th>아이디</th>
                                <td>
                                    <input type="text" name="u_id" onkeyup="testId(this.value)">
                                    <a onclick="idCheck(reg.u_id.value)"><button>아이디 확인</button></a>
                                    <span id="id_result">영소문자, 숫자조합으로 6~16자리로 입력하세요</span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td>
                                    <input type="password" name="u_pw" onkeyup="testPassword(this.value)">
                                    <span id="password_result">영소문자, 숫자, 특수문자(~!@#$^&*) 조합으로 8~20자리</span>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호 확인</th>
                                <td>
                                    <input type="password" name="u_pw2">
                                </td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td>
                                    <input type="text" name="u_name">
                                </td>
                            </tr>
                            <tr>
                                <th>생년월일</th>
                                <td>
                                    <input type="date" name="u_birth">
                                    <span>예, 2000-01-01</span>
                                </td>
                            </tr>
                            <tr>
                                <th>성별</th>
                                <td>
                                    <label><input type="radio" name="u_gender" value="M" checked>남성</label>
                                    <label><input type="radio" name="u_gender" value="F">여성</label>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                	<input type="hidden" name="u_email">
                                    <input type="text" name="email1"> @ 
                                    <input type="text" name="email2">
                                </td>
                            </tr>
                            <tr>
                                <th>휴대폰번호</th>
                                <td>
                                	<input type="hidden" name="u_phone">
                                    <select name="phone1" id="">
                                        <option value="" selected>선택</option>
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                    </select> -
                                    <input type="text" name="phone2"> -
                                    <input type="text" name="phone3">
                                </td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>
                                	<input type="hidden" name="u_tel">
                                    <select name="tel1" id="">
                                        <option value="" selected>선택</option>
                                        <option value="02">02</option>
                                        <option value="031">031</option>
                                        <option value="043">043</option>
                                    </select> - 
                                    <input type="text" name="tel2"> - 
                                    <input type="text" name="tel3">
                                </td>
                            </tr>
                            <tr>
                                <th>취미</th>
                                <td>
                                	<input type="hidden" name="u_hobby">
                                    <label><input type="checkbox" name="hobby[]" value="해킹">해킹</label>
                                    <label><input type="checkbox" name="hobby[]" value="요트타기">요트타기</label>
                                    <label><input type="checkbox" name="hobby[]" value="빵만들기">빵만들기</label>
                                    <label><input type="checkbox" name="hobby[]" value="TV보기">TV보기</label>
                                    <label><input type="checkbox" name="hobby[]" value="게임">게임</label>
                                    <label><input type="checkbox" name="hobby[]" value="공부">공부</label>
                                    <label><input type="checkbox" name="hobby[]" value="여행">여행</label>
                                    <label><input type="checkbox" name="hobby[]" value="수영">수영</label>
                                </td>
                            </tr>
                            <tr>
                                <th>최종학력</th>
                                <td>
                                    <select name="u_edu" id="">
                                        <option value="" selected>선택</option>
                                        <option value="middle">중졸</option>
                                        <option value="high">고졸</option>
                                        <option value="univ">대졸</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>참고사항</th>
                                <td>
                                    <ul>
                                        <li>위의 입력 항목을 모두 만들어주세요.</li>
                                        <li>모든 항목의 입력값에 대하여 DB에 입력전 유효성 검사를 해주세요.</li>
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="button">
                        <input type="submit" value="등록" onclick="submitForm(this.form)">
                        <a href="/userinfo/list?pageNum=${cri.pageNum}&amount=${cri.amount}&groupSize=${cri.groupSize}&keyword=${keyword}"><button type="button">목록</button></a>
                    </div>
                </form>
            </div>
        </div>
        <!-- 메인 컨텐츠 영역 끝 -->
        
    <!-- 헤더에서 시작된 wrapper 클래스 div 태그 닫아주기 -->
    </div>
    
<!-- 푸터 include -->
<jsp:include page="../include/footer.jsp" />
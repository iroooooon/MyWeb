<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyWeb_join</title>
<link href="../css/myweb_default.css" rel="stylesheet">

</head>
<body>
	<div class="join">	
			<div class="card">
				<h1><a href="../main/main.jsp">MyWeb</a></h1>
				<form action="updatePro.jsp" method="post" name="fr">
					<div id="join-content">
						<div class="row-group">
							<h4 class="head">회원 가입</h4>
							<!-- ID & PW -->
							<div class="join_row">
								<h4 class="join_title">아이디</h4>
								<div class="id_area">
									<input class="input_id" type="text" name="id" required>
									<input class="id_check" onclick="idCheck();" type="button" value="중복 확인">
								</div>
							</div>
							<div class="join_row">
								<h4 class="join_title">비밀번호</h4>
								<input class="input_pass" type="password" name="pass" required>
							</div>
							<div class="join_row">
								<h4 class="join_title">비밀번호 재확인</h4>
								<input class="input_pass" type="password" name="pass2" required>
							</div>
						</div>
						<div class="row-group">
							<!-- 이름 & 나이 -->
							<div class="join_row">
								<h4 class="join_title">이름</h4>
								<input class="input_name" type="text" name="name" required>
							</div>
							<div class="join_row">
								<h4 class="join_title">나이</h4>
								<input class="input_age" type="number" name="age" required>
							</div>
						</div>
						<div class="row-group">
							<!-- 성별 & 이메일 & 휴대폰-->
							<div class="join_row">
								<h4 class="join_title">성별</h4>
								<select class="input_gender" name="gender">
									<option value="" selected>성별</option>
									<option value="M">남자</option>
									<option value="W">여자</option>
								</select>
							</div>
							<div class="join_row">
								<h4 class="join_title">이메일</h4>
								<input class="input_email" type="email" name="email" required>
							</div>
							<div class="join_row">
								<h4 class="join_title">휴대폰 번호</h4>
								<input class="input_phone" type="text" name="phone" required>
							</div>
						</div>
						<div class="row-group">
							<!-- 주소 -->
							<div class="join_row">
								<h4 class="join_title">주소</h4>
								<div class="addr_area">
									<input class="input_addr" id="sample4_postcode" type="text" name="postcode" placeholder="우편번호">
									<input class="addr_search" type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
								</div>
								<input class="input_address" id="sample4_roadAddress" type="text" name="address" placeholder="도로명주소">
								<input class="input_address" id="sample4_jibunAddress" type="text" placeholder="지번주소">
								<span id="guide" style="color:#999;display:none"></span><br>
								<input class="input_address" id="sample4_detailAddress" type="text" name="d_address" placeholder="상세주소">
								<input class="input_address" id="sample4_extraAddress" type="text" name="e_address" placeholder="참고항목">
								<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
							</div>
						</div>
						<div class="btn_area">
								<input type="submit" value="회원정보수정" class="btn">
						</div>
					</div>
				</form>
			</div>
	</div>
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	<!-- footer -->
</body>
<script>
	//아이디 중복 체크
    function idCheck() {
    	if(document.fr.id.value == ""){
    		alert("ID를 입력하세요!");
    		document.fr.id.focus();
    		return;
    	}
    	var formID = document.fr.id.value;
    	window.open("joinIDCheck.jsp?userid="+formID,"","width=500,height=350");
    }
    
    //Daum Map API
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</html>
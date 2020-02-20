
<%@page import="net.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/myweb_default.css" rel="stylesheet">
</head>
<body>
<div id="dup_id">
	<div class="dup_title">
		<h1>아이디 중복 확인</h1>
	</div>
	<div class="dup_content1">
	<%
	//사용자 아이디를 받아서
	//DB에 있는지 체크 후
	//있으면 "사용중인 아이디" 출력 / 새로운 아이디 입력
	//없으면 "사용가능 아이디" 출력 / 아이디 선택 버튼 >> 새창 종료, 선택된 아이디는 회원가입창으로 전달
	
	//전달받은 아이디 값 (파라미터) 저장
	String id = request.getParameter("userid");
	//DB 객체 생성
	MemberDAO mdao = new MemberDAO();
	//joinIDCheck(id) 메서드 호출
	boolean result = mdao.joinIDCheck(id);
	if(result){
		//아이디 있을 때
		%>
		<h3>현재 사용중인 아이디 입니다. <br>새로운 아이디를 입력하세요!</h3>
		<%
	}else{
		//아이디 없을 때
		%>
		<h3><span><%=id %></span> 는 사용가능한 아이디 입니다.</h3>
		
		<%
	}
	%>
	<!-- 사용중 / 사용가능 >> 아이디를 변경 가능하게
		  폼태그 사용해서 사용자 아이디를 하나 입력
		 중복 체크 버튼으로 처리  -->
	</div>
	<div class="dup_content2">
		<div class="dup_form">
			<form action="joinIDCheck.jsp" method="post" name="winfr">
			<label>아이디 검색</label><br>
			<input class="input_id" type="text" name="userid" value="<%=id %>">
			<input class="submit" type="submit" value="중복 확인">
		</div>
	</div>
	<input class="use_btn" type="submit" value="아이디 사용 하기" onclick="useID();">
</div>
</body>
<script type="text/javascript">
	function useID() {
		opener.document.fr.id.value = document.winfr.userid.value;
		window.close();
	}
</script>
</html>
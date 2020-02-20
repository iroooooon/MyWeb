<%@page import="net.member.db.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//전달된 정보 저장(자바빈 사용)
		%>
		<jsp:useBean id="mb" class="net.member.db.MemberBean" />
		<jsp:setProperty property="*" name="mb" />
		<%
		//reg_date 정보 저장
		mb.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		//DB 객체 생성
		MemberDAO mdao = new MemberDAO();
		
		int result = mdao.insertMember(mb);
		if(result == 1){
			//가입 성공 >> 로그인 페이지 이동
			%>
				<script type="text/javascript">
					alert("회원 가입 성공!");
					location.href="loginForm.jsp";
				</script>
			<%
		}else{
			//가입 실패 >> 뒤로가기
			%>
				<script type="text/javascript">
					alert("회원 가입 실패!");
					history.back();
				</script>
			<%
		}
		%>
		
</body>
</html>
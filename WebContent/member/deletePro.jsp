<%@page import="net.member.db.MemberDAO"%>
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
		//파라미터값 저장
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
	
		//DB 객체 생성
		MemberDAO mdao = new MemberDAO();
	
		//deleteMember(id,pass)
		int result = mdao.deleteMember(id, pass);
		
		if(result == 1){
			//탈퇴 성공
			session.invalidate();//세션 초기화
			%>
				<script type="text/javascript">
					alert("회원 탈퇴 성공!");
					location.href="../main/main.jsp";
				</script>
			<%
		}else if(result == 0){
			//비밀번호 오류
			%>
				<script type="text/javascript">
					alert("잘못된 비밀번호 입니다.!");
					history.back();
				</script>
			<%
		}else{
			//아이디 오류
			%>
			<script type="text/javascript">
				alert("존재하지 않는 아이디 입니다.!");
				history.back();
			</script>
		<%
		}
	%>
</body>
</html>
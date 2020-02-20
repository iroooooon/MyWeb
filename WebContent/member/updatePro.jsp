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
		
		//전달받은 정보 저장(자바빈)
		%>
		<jsp:useBean id="mb" class="net.member.db.MemberBean" />
		<jsp:setProperty property="*" name="mb"/>
		<%
		//수정 날짜 저장
		mb.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		//MemberDAO 객체 생성
		MemberDAO mdao = new MemberDAO();
		
		//updateMember(mb)
		int result = mdao.updateMember(mb);
		
		if(result == 1){
			//수정 성공
			%>
				<script type="text/javascript">
					alert("회원정보 수정 성공!");
					location.href="../main/main.jsp";
				</script>
			<%
		}else if(result == 0){
			//비밀번호 오류
			%>
			<script type="text/javascript">
				alert("잘못된 비밀번호입니다.!");
				history.back();
			</script>
		<%
		}else{
			//아이디 오류
			%>
			<script type="text/javascript">
				alert("존재하지 않는 아이디입니다.!");
				history.back();
			</script>
		<%
		}
	%>
</body>
</html>
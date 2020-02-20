<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyWeb_Withdraw</title>
<link href="../css/myweb_default.css" rel="stylesheet">
<link href="../css/myweb_sub.css" rel="stylesheet">
</head>
<body>
	<%
		//세션값 저장
		String id = (String)session.getAttribute("id");
		if(id == null){
			response.sendRedirect("loginForm.jsp");
		}
	%>
	<div class="row">
		<div class="login">
			<div class="card">
				<h1><a href="../main/main.jsp">MyWeb</a></h1>
				<form action="deletePro.jsp" method="post">
				<input class="id" type="text" name="id" value="<%=id %>" readonly><br>
				<input class="pass" type="password" name="pass" placeholder="패스워드"><br>
				<input type="submit" value="탈퇴하기" class="btn">
				<hr>
				<a href="../main/main.jsp" class="join">뒤로가기</a>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>
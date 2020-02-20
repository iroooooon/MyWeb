<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyWeb_Login</title>
<link href="../css/myweb_default.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="login">
			<div class="card">
				<h1><a href="../main/main.jsp">MyWeb</a></h1>
				<form action="loginPro.jsp" method="post">
				<input class="id" type="text" name="id" placeholder="아이디" required><br>
				<input class="pass" type="password" name="pass" placeholder="패스워드" required><br>
				<input type="submit" value="로그인" class="btn">
				<hr>
				<a href="joinForm.jsp" class="join">회원가입</a>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>
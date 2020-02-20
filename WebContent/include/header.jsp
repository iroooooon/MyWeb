<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="header">
	<h1><a href="../main/main.jsp">My Web</a></h1>
  	<p>Simple is the best</p>
</div>
<div class="topnav">
	<a href="../main/main.jsp">Home</a>
	<a href="../board/board_main.jsp">Board</a>
	<a href="../fileboard/fboard_main.jsp">File Board</a>
	<a href="../gallery/gallery_main.jsp">Gallery</a>
	<a href="../contact/sendMail.jsp">Contact</a>
	<%
	String id = (String)session.getAttribute("id");
	if(id == null){
	%>
	<a href="../member/joinForm.jsp" style="float:right">Join</a>
	<a href="../member/loginForm.jsp" style="float:right">Login</a>
	<%
	}else{
	%>
	<a href="../member/logout.jsp" style="float:right">Logout</a>
	<%
	}
	%>
</div>
</body>
</html>
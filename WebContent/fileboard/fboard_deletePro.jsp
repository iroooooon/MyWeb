<%@page import="net.fileboard.db.FileBoardDAO"%>
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
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	
	//FileBoardDAO 객체 생성
	FileBoardDAO fbdao = new FileBoardDAO();
	//deleteFileBoard 메서드 호출
	boolean result = fbdao.deleteFileBoard(num,id,pass);
	
	if(result){
		%>
			<script type="text/javascript">
				alert("삭제 완료!");
				location.href="fboard_main.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
	}else{
		%>
			<script type="text/javascript">
				alert("삭제 실패!");
				history.back();
			</script>
		<%
	}
	%>
</body>
</html>
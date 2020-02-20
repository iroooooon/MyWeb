<%@page import="net.board.db.BoardDAO"%>
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
	//파라미터 값 저장
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	//DB처리 객체 생성
	BoardDAO bdao = new BoardDAO();
	//deleteBoard(id,pass,num)
	int result = bdao.deleteBoard(id,pass,num);
	if(result == 1){
		//삭제 성공
		%>
			<script type="text/javascript">
				alert("게시글 삭제 완료!");
				location.href="board_main.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
	}else if(result == 0){
		//비밀번호 오류
		%>
			<script type="text/javascript">
				alert("비밀번호 오류!");
				history.back();
			</script>
		<%		
	}else{
		//아이디 없음
		%>
			<script type="text/javascript">
				alert("아이디 없음!");
				history.back();
			</script>
		<%
	}
	%>
</body>
</html>
<%@page import="java.sql.Timestamp"%>
<%@page import="net.board.db.BoardDAO"%>
<%@page import="net.board.db.BoardBean"%>
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
	//한글 처리
	request.setCharacterEncoding("UTF-8");
	
	//파라미터 값 저장(자바빈)
	BoardBean bb = new BoardBean();
	bb.setId(request.getParameter("id"));
	bb.setPass(request.getParameter("pass"));
	bb.setSubject(request.getParameter("subject"));
	bb.setContent(request.getParameter("content"));
	//IP와 날짜 저장
	bb.setIp(request.getRemoteAddr());
	bb.setDate(new Timestamp(System.currentTimeMillis()));
	
	//DB 처리 객체
	BoardDAO bdao = new BoardDAO();
	
	//insertBoard(bb)
	boolean result = bdao.insertBoard(bb);
	if(result){
		//글 쓰기 성공
		%>
			<script type="text/javascript">
				alert("글 쓰기 완료!");
				location.href="board_main.jsp";
			</script>
		<%
	}else{
		//글 쓰기 실패
		%>
			<script type="text/javascript">
				alert("글 쓰기 실패!");
				history.back();
			</script>
		<%
	}
	%>
</body>
</html>
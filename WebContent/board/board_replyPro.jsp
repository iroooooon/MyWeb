<%@page import="net.board.db.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
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
	
	//파라미터값 저장
	String pageNum = request.getParameter("pageNum");
	%>
	<jsp:useBean id="bb" class="net.board.db.BoardBean" />
	<jsp:setProperty property="*" name="bb"/>
	<%
	bb.setIp(request.getRemoteAddr());
	bb.setDate(new Timestamp(System.currentTimeMillis()));
	
	//DB 객체 생성
	BoardDAO bdao = new BoardDAO();
	//insertReply(bb)
	boolean result = bdao.insertReply(bb);
	if(result){
		//답글 성공
		%>
			<script type="text/javascript">
			alert("답글쓰기 성공!");
			location.href="board_main.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
	}else{
		//답글 실패
		%>
			<script type="text/javascript">
			alert("답글쓰기 실패!");
			history.back();
			</script>
		<%
	}
	%>
</body>
</html>
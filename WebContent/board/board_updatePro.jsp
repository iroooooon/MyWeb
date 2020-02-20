<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Currency"%>
<%@page import="net.board.db.BoardBean"%>
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
	//한글 처리
	request.setCharacterEncoding("UTF-8");
	
	//파라미터 값 저장(자바빈)
	//자바빈 객체 생성
	BoardBean bb = new BoardBean();
	
	//값 저장
	bb.setId(request.getParameter("id"));
	bb.setPass(request.getParameter("pass"));
	bb.setSubject(request.getParameter("subject"));
	bb.setContent(request.getParameter("content"));
	bb.setNum(Integer.parseInt(request.getParameter("num")));
	bb.setDate(new Timestamp(System.currentTimeMillis()));
	bb.setIp(request.getRemoteAddr());
	
	String pageNum = request.getParameter("pageNum");
	
	//DB 처리 객체 생성
	BoardDAO bdao = new BoardDAO();
	
	//updateBoard(bb)
	int result = bdao.updateBoard(bb);
	if(result == 1){
		//수정 성공
		%>
		<script type="text/javascript">
			alert("게시글 수정 성공!");
			location.href="board_content.jsp?num=<%=bb.getNum()%>";
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
		//글 없음
		%>
		<script type="text/javascript">
			alert("비밀번호 오류!");
			history.back();
		</script>
		<%
	}
	%>
</body>
</html>
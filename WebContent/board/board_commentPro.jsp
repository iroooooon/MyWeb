<%@page import="net.comment.db.CommentDAO"%>
<%@page import="java.util.Currency"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="net.comment.db.CommentBean"%>
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
	
	//파라미터 값 저장
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String id = request.getParameter("id");
	String content = request.getParameter("content");
	String pageNum = request.getParameter("pageNum");
	
	//CommentBean 객체 생성
	CommentBean cb = new CommentBean();
	cb.setContent(content);
	cb.setBoard_num(board_num);
	cb.setId(id);
	cb.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	//DB 처리 객체 생성
	CommentDAO cdao = new CommentDAO();
	
	//insertComment(cb)
	
	boolean result = cdao.insertComment(cb);
	
	if(result){
		//댓글 작성 성공
		response.sendRedirect("board_content.jsp?num="+board_num);
	}else{
		%>
			<script type="text/javascript">
				alert("댓글을 쓰지 못했습니다. 다시 시도해주세요!");
				history.back();
			</script>
		<%
	}
	%>
</body>
</html>
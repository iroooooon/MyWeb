<%@page import="net.comment.db.CommentDAO"%>
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
		//num , board_num 저장
		int num = Integer.parseInt(request.getParameter("num"));
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		CommentDAO cdao = new CommentDAO();
		int result = cdao.cmtDelete(num, board_num);
		if(result == 1){
			response.sendRedirect("board_content.jsp?num="+board_num);
		}
		
		else{
			%>
				<script type="text/javascript">
					alert("댓글 삭제를 실패했습니다!")	;
					hitory.back();
				</script>
			<%
		}
	%>
</body>
</html>
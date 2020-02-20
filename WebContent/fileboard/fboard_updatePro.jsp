<%@page import="net.fileboard.db.FileBoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="net.fileboard.db.FileBoardBean"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
	//전달된 파라미터 값 저장
	String pageNum = request.getParameter("pageNum");
	
	//파일 업로드할 폴더(물리적 위치)
	//upload 폴더를 사용해서 가상경로로 사용
	String realPath = request.getRealPath("/upload");
	
	//파일 최대 크기
		int maxSize = 10*1024*1024; //10MB
	//파일 업로드 처리 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request,
				realPath,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
	//자료실 update 내용 저장
	//글쓴이, 비밀번호, 제목, 내용, 첨부파일 > 전달받아서 DB로 전달
	//자바빈 객체 생성
	FileBoardBean fbb = new FileBoardBean();
	fbb.setNum(Integer.parseInt(multi.getParameter("num")));
	fbb.setId(multi.getParameter("id"));
	fbb.setPass(multi.getParameter("pass"));
	fbb.setSubject(multi.getParameter("subject"));
	fbb.setContent(multi.getParameter("content"));
	fbb.setFile(multi.getFilesystemName("file"));
	
	/* System.out.println(fbb.getNum());
	System.out.println(fbb.getId());
	System.out.println(fbb.getPass());	
	System.out.println(fbb.getSubject());	
	System.out.println(fbb.getContent());	
	System.out.println(fbb.getFile());	 */
	//FileBoardDAO 객체 생성
	FileBoardDAO fbdao = new FileBoardDAO();
	int result = fbdao.updateFileBoard(fbb);
	
	if(result == 1){
		%>
			<script type="text/javascript">
				alert("수정 완료!");
				location.href="fboard_content.jsp?num=<%=fbb.getNum()%>&pageNum=<%=pageNum%>";
			</script>
		<%
	}else if(result == 0){
		%>
			<script type="text/javascript">
				alert("비밀번호 오류!");
				history.back();
			</script>
		<%
	}else{
		%>
			<script type="text/javascript">
				alert("존재하지 않는 글입니다!");
				history.back();
			</script>
		<%
	}
	
	
	%>
</body>
</html>
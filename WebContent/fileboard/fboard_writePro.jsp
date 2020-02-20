<%@page import="net.fileboard.db.FileBoardDAO"%>
<%@page import="net.fileboard.db.FileBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//파일 업로드
	//파일 업로드할 폴더 (물리적 위치)
	//upload 폴더 사용해서 가상경로로 이용
	String realPath = request.getRealPath("/upload");
	
	//파일 최대 크기
	int maxSize = 10*1024*1024; //10MB
	//파일 업로드 처리 객체 생성
	MultipartRequest multi = new MultipartRequest(
			request,
			realPath,
			maxSize,
			"UTF-8",
			new DefaultFileRenamePolicy()
			);
	
	//자료실 글 저장
	//글쓴이, 비밀번호, 제목, 내용, 첨부파일 전달 받아서 DB로 전달
	//자바빈 객체 생성
	FileBoardBean fbb = new FileBoardBean();
	fbb.setId(multi.getParameter("id"));
	fbb.setPass(multi.getParameter("pass"));
	fbb.setSubject(multi.getParameter("subject"));
	fbb.setContent(multi.getParameter("content"));
	fbb.setIp(request.getRemoteAddr());
	fbb.setFile(multi.getFilesystemName("file"));
	
	System.out.println("파일 업로드 중 정보 확인 : "+fbb.toString());
	System.out.println("upload 폴더에 저장된 파일이름 : "+multi.getFilesystemName("file"));
	System.out.println("사용자가 올린 원본 파일이름 : "+multi.getOriginalFileName("file"));
	
	
	//DB 처리 객체 생성
	//FileBoardDAO
	FileBoardDAO fbdao = new FileBoardDAO();
	
	//insertFile(fbb)
	boolean result = fbdao.insertFile(fbb);
	if(result){
		%>
			<script type="text/javascript">
				alert("자료실 글 쓰기 성공!");
				location.href="fboard_main.jsp";
			</script>
		<%
	}else{
		%>
			<script type="text/javascript">
				alert("자료실 글 쓰기 실패!");
				history.back();
			</script>
		<%
	}
	%>
</body>
</html>
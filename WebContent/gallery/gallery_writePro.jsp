<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="net.gallery.db.GalleryBean"%>
<%@page import="net.gallery.db.GalleryDAO"%>
<%@page import="java.sql.Timestamp"%>
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
	
		//파일 업로드
		//업로드 폴더 설정(upload_img)
		String realPath = request.getRealPath("/upload_img");
		
		//파일 최대 크기
		int maxSize = 100*1024*1024; // 100MB
		
		//파일 업로드 처리 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request,
				realPath,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		//갤러리 글 저장
		//전달받은 값 저장
		GalleryBean gb = new GalleryBean();
		gb.setId(multi.getParameter("id"));
		gb.setImg_name(multi.getFilesystemName("img_name"));
		gb.setSubject(multi.getParameter("subject"));
		gb.setContent(multi.getParameter("content"));
		gb.setPass(multi.getParameter("pass"));
		//등록날짜 저장
		gb.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		System.out.println("이미지 업로드 중 정보 확인 : "+gb.toString());
		System.out.println("upload_img 폴더에 저장된 이미지파일 이름 : "+ multi.getFilesystemName("img_name"));
		System.out.println("사용자가 올린 원본 이미지 파일이름  : "+multi.getOriginalFileName("img_name"));
		
		
		//DB 처리 객체 생성
		GalleryDAO gdao = new GalleryDAO();
		
		//insertGallery(gb) 호출
		boolean result = gdao.insertGallery(gb);
		if(result){
			%>
				<script type="text/javascript">
					alert("갤러리 글 작성 성공!");
					location.href="gallery_main.jsp";
				</script>
			<%
		}else{
			%>
				<script type="text/javascript">
					alert("갤러리 글 작성 실패!");
					history.back();
				</script>
			<%
		}
	%>	
	
</body>
</html>
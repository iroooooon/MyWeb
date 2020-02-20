<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>"WebContent/fileboard/file_down.jsp"</h1>
	
	<%
	//전달한 파라미터 값 저장
	String filename = request.getParameter("file");
	//파라미터 값 확인
	//out.print("file : "+filename);
	// 서버에 업로드 했던 위치(가상 폴더명)
	String savePath = "upload";
	
	ServletContext context = getServletContext();
	String DownloadPath = context.getRealPath(savePath);
	//가상의 폴더(upload) 실제 서버에 위치하고 있는 물리적 경로를 가져옴
	System.out.println("다운로드 경로 : "+DownloadPath);
	
	//다운로드 처리할 파일의 전체 경로
	String FilePath = DownloadPath+"\\"+filename;
	//out.print("파일 경로 : "+FilePath);
	
	//파일을 한번에 읽고 쓰기 할 수 있는 배열
	byte[] b = new byte[4096];
	
	//파일 읽어오는 처리(파일처리를 위한 통로 개설)
	FileInputStream fis = new FileInputStream(FilePath);
	
	//다운로드할 파일의 MIME 타입 정보 불러오기
	String MimeType = getServletContext().getMimeType(FilePath);
	//MIME타입 : 클라이언트에게 전송된 문서의 다양성을 알려주기 위한 메커니즘
	//웹에서는 파일 확장자의 의미가 없음, 각 페이지에서 처리할 때 올바른 타입으로
	//사용될수 있도록 지정(Mime Type)
	
	if(MimeType == null){
		MimeType = "application/octect-stream";
	}
	//MimeType 값이 없을 경우 "application/octect-stream" 값으로 기본값 설정
	
	System.out.println("MimeType : "+MimeType);
	
	response.setContentType(MimeType);
	//응답할 데이터의 MIME 타입을 다운로드할 파일의 MIME 타입으로 지정
	
	//사용자의 브라우저에 따라 처리를 구분
	//IE 인지 판단
	String agent = request.getHeader("User-Agent");
	boolean ieBrowser = (agent.indexOf("MSIE")>-1)||(agent.indexOf("Trident")>-1);
	
	//브라우저에 따라 한글 파일 깨짐 처리
	if(ieBrowser){//IE일 경우
		filename = URLEncoder.encode(filename,"UTF-8").replaceAll("\\+","%20");
	//IE 의 경우 다운로드시 한글파일 깨짐
	//공백문자가 "+"로 변경됨 > 다시 공백문자("%20")로 변경
	}else{ //IE 아닐 경우
		filename = new String(filename.getBytes("UTF-8"),"iso-8859-1");
	}
	
	//브라우저에서도 지금 처리한 파일의 형탵가 다운로드의 형태로 처리되도록 준비
	response.setHeader("Content-Disposition", "attachment; filename="+filename);
	//>> 항상 다운로드 처리 "Content-Disposition" 속성의 값이 attachment 일때
	
	//바이트 기반의 출력 스트림 생성
	ServletOutputStream out2 = response.getOutputStream();
	
	//파일 출력
	int numRead=0;
	while((numRead = fis.read(b,0,b.length)) != -1){
		out2.write(b,0,numRead);
	}
	
	out2.flush();//버퍼의 빈칸을 채워서 전달
	out2.close();
	fis.close();
	%>
</body>
</html>
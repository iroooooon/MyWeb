<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
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
	
	Properties props = System.getProperties();
	props.put("mail.smtp.host", "smtp.naver.com");
	props.put("mail.smtp.port",25);
	props.put("defaultEncoding","utf-8");
	props.put("mail.smtp.auth","true");
	
	final String userId = "seo_ping";
	final String userPw = "#hack2rtarget";
	
	try{
		String sender = request.getParameter("from");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		Session sessions = Session.getInstance(props, new javax.mail.Authenticator(){
			String un = userId;
			String pw = userPw;
			
			protected javax.mail.PasswordAuthentication getPasswordAuthentication(){
				return new javax.mail.PasswordAuthentication(un,pw);
			}
		});
		sessions.setDebug(false);
		
		Message mimeMessage = new MimeMessage(sessions);
		mimeMessage.setFrom(new InternetAddress(sender));
		
		//받는 사람 메일주소 세팅
		InternetAddress[] toAddr = new InternetAddress[1];
		toAddr[0] = new InternetAddress(request.getParameter("recive"));
		
		mimeMessage.setRecipients(Message.RecipientType.TO, toAddr);//수신자 세팅
		
		mimeMessage.setSubject(subject);
		mimeMessage.setText(content);
		
		Transport.send(mimeMessage);
		
		System.out.println("메일 발송 성공!!");
	}catch(Exception e){
		e.printStackTrace();
		System.out.println("메일보내기 오류!!"+e.getMessage());
	}
	
%>
	<script type="text/javascript">
		alert("메일 발송 성공!");
		location.href="../main/main.jsp";
	</script>
</body>
</html>
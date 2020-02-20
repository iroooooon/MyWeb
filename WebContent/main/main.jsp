<%@page import="net.fileboard.db.FileBoardDAO"%>
<%@page import="net.board.db.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyWeb</title>
<link href="../css/myweb_default.css" rel="stylesheet">
</head>
<body>

<!-- header -->
 <jsp:include page="../include/header.jsp" />
<!-- header -->

<%
String id = (String)session.getAttribute("id");
%>

<div class="row">
  <div class="leftcolumn">

 	<!-- Board Preview -->   
 		<jsp:include page="../include/Board_Preview.jsp"></jsp:include>
 	<!-- Board Preview -->   

    <!-- File Board Preview -->
    	<jsp:include page="../include/File_Board_Preview.jsp"></jsp:include>
    <!-- File Board Preview -->
  </div>
  <div class="rightcolumn">
  <!-- rightcolumn_myinfo -->
    <jsp:include page="../include/right_myinfo.jsp"></jsp:include>
  <!-- rightcolumn_myinfo -->
    
  <!-- gallery_preview -->  
  	<jsp:include page="../include/gallery_preview.jsp"></jsp:include>
  <!-- gallery_preview -->  
    
  <!-- banner --> 
  	<jsp:include page="../include/banner.jsp"></jsp:include>
  <!-- banner --> 
  
  </div>
</div>

<!-- footer -->
<jsp:include page="../include/footer.jsp" />
<!-- footer -->
</body>
</html>
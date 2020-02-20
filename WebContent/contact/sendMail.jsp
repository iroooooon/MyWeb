<%@page import="net.member.db.MemberBean"%>
<%@page import="net.member.db.MemberDAO"%>
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
if(id == null){
	response.sendRedirect("../member/loginForm.jsp");
}else{

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

%>

<div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>메일 보내기</h2>
      <form action="sendMailPro.jsp" method="post" name="fr">
      	<div class="write_main">
      		<div class="write_group">
      			<div class="row_group">
 		     		<label>받는 사람</label><br>
      				<input type="text" name="recive">		
      			</div>
      			<div class="row_group">
 		     		<label>보내는 사람</label><br>
      				<input type="email" name="from" value="<%=mb.getEmail() %>">		
      			</div>
      			<div class="row_group">
 		     		<label>제목</label><br>
      				<input type="text" name="subject">		
      			</div>
      			<div class="row_group">
 		     		<label>내용</label><br>
 		     		<textarea name="content" cols="77" rows="20"></textarea>	
      			</div>
      			<div class="row_group" id="row_group_btn">
      				<input type="submit" value="전송">
      				<input type="reset" value="취소">
      			</div>
      		</div>
      	</div>	
      </form>
    </div>
  </div>
  <%
  }
%>
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
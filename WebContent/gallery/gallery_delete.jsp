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
}
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>

<div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>갤러리 글 삭제</h2>
      <h4>삭제하려면 게시글의 비밀번호를 입력해주세요!!</h4>
      <form action="gallery_deletePro.jsp?pageNum=<%=pageNum %>" method="post">
      	<input type="hidden" name="id" value="<%=id%>">
      	<input type="hidden" name="num" value="<%=num %>">
      	<div class="write_main">
      		<div class="write_group">
      			<div class="row_group">
 		     		<label>비밀번호</label><br>
      				<input type="password" name="pass">		
      			</div>
      			<div class="row_group" id="row_group_btn">
      				<input type="submit" value="삭제하기">
      				<input type="reset" value="취소">
      			</div>
      		</div>
      	</div>	
      </form>
    </div>
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
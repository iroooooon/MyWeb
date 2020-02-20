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

//파라미터 값 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));
%>

<div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>자료실 답글 쓰기</h2>
      <form action="fboard_replyPro.jsp?pageNum=<%=pageNum %>" method="post">
      	<input type="hidden" name="num" value="<%=num%>">
      	<input type="hidden" name="re_ref" value="<%=re_ref%>">
      	<input type="hidden" name="re_lev" value="<%=re_lev%>">
      	<input type="hidden" name="re_seq" value="<%=re_seq%>">
      	<div class="write_main">
      		<div class="write_group">
      			<div class="row_group">
 		     		<label>아이디</label><br>
      				<input type="text" name="id" value="<%=id%>" readonly>		
      			</div>
      			<div class="row_group">
 		     		<label>비밀번호</label><br>
      				<input type="password" name="pass">		
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
      				<input type="submit" value="답글쓰기">
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
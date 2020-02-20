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
String id = (String) session.getAttribute("id");
%>
	<div class="card" id="card_welcome">
      <h2>My Info</h2>
      <%
      if(id != null){
    	  %>
    	  <div class="welcome">
    	  	<h3>"<%=id %>" 님 반갑습니다!</h3>
      		<div class="member_Update">
      			<a href="../member/updateForm.jsp">회원정보수정</a> | <a href="../member/deleteForm.jsp">회원탈퇴</a>
      			<%
      			if(id.equals("administrator")){
      				%>
      				| <a href="../member/memberList.jsp">회원목록</a>
      				<%
      			}
      			%>
      		</div>
      	</div>
      <%
      }else{
    	  %>
    	  <h3>로그인을 해주세요!</h2>
    	  <%
      }
      %>
    </div>
</body>
</html>
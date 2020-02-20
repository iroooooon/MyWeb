<%@page import="net.member.db.MemberDAO"%>
<%@page import="net.member.db.MemberBean"%>
<%@page import="net.comment.db.CommentDAO"%>
<%@page import="net.board.db.BoardBean"%>
<%@page import="java.util.List"%>
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
//세션값 가져오기
String id = (String)session.getAttribute("id");

//DB 처리 객체 생성
MemberDAO mdao = new MemberDAO();
//글 개수 계산해오는 메서드 getBoardCount() 호출
int count = mdao.getMemberCount();
/* 페이징 처리 */
//한 페이지에서 보여줄 글의 개수
int pageSize = 15;

//현재 페이지 정보
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";
}

//시작 행
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;

//끝 행
int endRow = currentPage*pageSize;
%>

<div class="row">
  <div class="leftcolumn" id="member_list">
    <div class="card" id="card_bm">
      <h2>회원 목록</h2>
      <div class="board_area">
      	<table class="board_tb">
      		<thead>
      		<tr class="board_col">
  				<th class="tbid">아이디</th>
  				<th class="tbpass">비밀번호</th>
  				<th class="tbname">이름</th>
  				<th class="tbage">나이</th>
  				<th class="tbgender">성별</th>
  				<th class="tbemail">이메일</th>
  				<th class="tbphone">전화번호</th>
  				<th class="tbpostcode">우편번호</th>
  				<th class="tbaddress">주소</th>
  				<th class="tbdaddress">상세주소</th>
  				<th class="tbeaddress">기타주소</th>
  				<th class="tbregdate">가입일자</th>
      		</tr>
      		</thead>
      		<%
      		//글 목록 가져오기
      		List<MemberBean> memberList = null;
      		
      		if(count != 0){
      			//DB에서 정보를 가져오기(getBoardList(startRow,pageSize))
      			memberList = mdao.getMemberList();
      			//가져온 정보의 개수 만큼 페이지에 반복
      			for(int i=0;i<memberList.size();i++){
      				MemberBean mb = memberList.get(i);
      		%>
      		<tbody id="maintbody">
			<tr class="board_con">
      			<td class="tbtd"><%=mb.getId() %></td>
      			<td class="tbtdsubject"><%=mb.getPass() %></td>
      			<td class="tbtd"><%=mb.getName() %></td>
      			<td class="tbtd"><%=mb.getAge() %></td>
      			<td class="tbtd"><%=mb.getGender() %></td>
      			<td class="tbtd"><%=mb.getEmail() %></td>
      			<td class="tbtd"><%=mb.getPhone() %></td>
      			<td class="tbtd"><%=mb.getPostcode() %></td>
      			<td class="tbtd"><%=mb.getAddress() %></td>
      			<td class="tbtd"><%=mb.getD_address() %></td>
      			<td class="tbtd"><%=mb.getE_address() %></td>
      			<td class="tbtd"><%=mb.getReg_date() %></td>
      		</tr>
      		<%
     			}
      		}
      		%>
      		</tbody>
      	</table>
      	<div id="mainbtm">
      	<div id="paging">
      	<span>-</span>
      <%
      	/* 페이징 처리 */
      	//글이 있을 때만 처리
      	if(count != 0){
      		//전체 페이지 수 계산
      		int pageCount = count/pageSize+(count%pageSize==0?0:1);
      		//한 페이지에서 보여줄 페이지 수를 계싼
      		int pageBlock = 10;
      		//시작하는 페이지 번호 계산
      		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
      		//끝나는 페이지 번호 계싼
      		int endPage = startPage+pageBlock-1;
      		if(endPage > pageCount){
      			endPage = pageCount;
      		}
      		
      		//Prev
      		if(startPage > pageBlock){
      			%>
      			<a href="board_main.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
      			<%
      		}
      		//1~10, 11~20 ...
      		for(int i=startPage;i<=endPage;i++){
      			%>
      			<a href="board_main.jsp?pageNum=<%=i%>"><%=i %></a>
      			<%
      		}
      		//Next
      		if(pageCount > endPage){
      			%>
      			<a href="board_main.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
      			<%
      		}
      	
      	}
      %>
      <span>-</span>
       </div>
       <div id="wrbtn">
      		<input class="board_wr_btn" type="button" value="메인페이지" onclick="location.href='../main/main.jsp';">
      	</div>
      </div>
     </div>
    </div>
  </div>
  <%-- <div class="rightcolumn">
  <!-- rightcolumn_myinfo -->
    <jsp:include page="../include/right_myinfo.jsp" />
  <!-- rightcolumn_myinfo -->
  
  <!-- gallery_preview -->  
  	<jsp:include page="../include/gallery_preview.jsp"></jsp:include>
  <!-- gallery_preview -->  
  
  <!-- banner --> 
  	<jsp:include page="../include/banner.jsp"></jsp:include>
  <!-- banner --> 
  </div>
 --%>
</div>
<!-- footer -->
<jsp:include page="../include/footer.jsp" />
<!-- footer -->
</body>
</html>
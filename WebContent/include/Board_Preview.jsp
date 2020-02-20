<%@page import="net.board.db.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="net.board.db.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card" id="card_bp">
      <h2>Board Preview</h2>
      	<ul id="preview_ul">
      	  <%
      		//DB 처리 객체 생성
      		BoardDAO bdao = new BoardDAO();
      		//글 개수 계산해오는 메서드 getBoardCount() 호출
      		int count = bdao.getBoardCount();
      		/* 페이징 처리 */
      		//한 페이지에서 보여줄 글의 개수
	      	int pageSize = 10;
	
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
      		//글 목록 가져오기
      		List<BoardBean> boardList = null;
      		
      		if(count != 0){
      			//DB에서 정보를 가져오기(getBoardList(startRow,pageSize))
      			boardList = bdao.getBoardList(startRow, pageSize);
      			//가져온 정보의 개수 만큼 페이지에 반복
      			for(int i=0;i<boardList.size();i++){
      				BoardBean bb = boardList.get(i);
      		%>
	      			<li id="preview_li">
	      				<div id="li_sub">
	      				<a href="../board/board_content.jsp?num=<%=bb.getNum()%>"><h3>
	      				<%
						for(int j=1;j<=bb.getRe_lev();j++){ 
					%>
						<!-- <img src="../img/gap.png"> -->
						&nbsp;
					<%
						}
						if(bb.getRe_seq() != 0){
					%>
						<img src="../img/arrow3.png">
					<%
						}
						%>
	      				<%=bb.getSubject() %></h3></a>
	      				</div>
	      				<div id="li_dat"><h5><%=bb.getDate() %></h5></div>
	      			</li>
	      	<%		
	      			}
    			}
      		%>
      </ul>
    </div>
</body>
</html>
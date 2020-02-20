<%@page import="net.fileboard.db.FileBoardBean"%>
<%@page import="java.util.List"%>
<%@page import="net.fileboard.db.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card" id="card_fbp">
      <h2>File Board Preview</h2>
      <ul id="preview_ul">
      	  <%
      		//DB 처리 객체 생성
      		FileBoardDAO fbdao = new FileBoardDAO();
      		//글 개수 계산해오는 메서드 getBoardCount() 호출
      		int fcount = fbdao.getFileBoardCount();
      		/* 페이징 처리 */
      		//한 페이지에서 보여줄 글의 개수
	      	int fpageSize = 10;
	
	      	//현재 페이지 정보
	      	String pageNum = request.getParameter("pageNum");
	      	if(pageNum == null){
	      		pageNum = "1";
	      	}
	
	      	//시작 행
	      	int fcurrentPage = Integer.parseInt(pageNum);
	      	int fstartRow = (fcurrentPage-1)*fpageSize+1;
	
	      	//끝 행
	      	int fendRow = fcurrentPage*fpageSize;
      		//글 목록 가져오기
      		List<FileBoardBean> fboardList = null;
      		
      		if(fcount != 0){
      			//DB에서 정보를 가져오기(getBoardList(startRow,pageSize))
      			fboardList = fbdao.getFileBoardList(fstartRow, fpageSize);
      			//가져온 정보의 개수 만큼 페이지에 반복
      			for(int i=0;i<fboardList.size();i++){
      				FileBoardBean fbb = fboardList.get(i);
      		%>
	      			<li id="preview_li">
	      				<div id="li_sub"><a href="../fileboard/fboard_content.jsp?num=<%=fbb.getNum()%>"><h3><%=fbb.getSubject() %></h3></a></div>
	      				<div id="li_dat"><h5><%=fbb.getDate() %></h5></div>
	      			</li>
	      	<%		
	      			}
    			}
      		%>
      </ul>
    </div>
</body>
</html>
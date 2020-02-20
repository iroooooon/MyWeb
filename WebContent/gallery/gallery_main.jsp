<%@page import="net.gallery.db.GalleryDAO"%>
<%@page import="net.gallery.db.GalleryBean"%>
<%@page import="net.fileboard.db.FileBoardDAO"%>
<%@page import="net.fileboard.db.FileBoardBean"%>
<%@page import="net.comment.db.CommentDAO"%>
<%@page import="java.util.List"%>
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
GalleryDAO gdao = new GalleryDAO();
//글 개수 계산해오는 메서드 getBoardCount() 호출
int count = gdao.getGalleryCount();
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
  <div class="leftcolumn">
    <div class="card" id="card_gm">
      <h2>Gallery</h2>
      <div class="board_area">
      	<table class="board_tb">
			<tr class="board_con">
      			<td class="tbtd">      		
      		<%
      		//글 목록 가져오기
      		List<GalleryBean> galleryList = null;
      		/*
      		for(int i = 1; i<9;i++){
				System.out.print("*");
				if(i%4==0){
					System.out.println();
					System.out.println("------");
				}
			}
      		*/
      		if(count != 0){
      			//DB에서 정보를 가져오기(getBoardList(startRow,pageSize))
      			galleryList = gdao.getGalleryList(startRow, pageSize);
      			int i=0;
      			int imgnum = 5;
      			//가져온 정보의 개수 만큼 페이지에 반복		
      				while(i<galleryList.size()){
      					GalleryBean gb = galleryList.get(i);
      		%>			
      				<div class="gall_main">
      					<div class="gallery">
  							<a href="gallery_content.jsp?num=<%=gb.getNum()%>&pageNum=<%=pageNum%>">
    							<img src="../upload_img/<%=gb.getImg_name() %>" alt="Cinque Terre" width="600" height="400" >
  							</a>
  							<div class="desc">
  								<div class="desc_title"><h5><%=gb.getSubject() %></h5></div>
  								<div class="desc_id"><%=gb.getId() %></div>
  							</div>
						</div>
      				</div>
      		<%
      					if((i+1)%imgnum==0){
						%>
						<div><br></div>
						<%
      				}
      			i++;
     			}
      		}
      		%>
      			</td>
      		</tr>
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
      			<a href="gallery_main.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
      			<%
      		}
      		//1~10, 11~20 ...
      		for(int i=startPage;i<=endPage;i++){
      			%>
      			<a href="gallery_main.jsp?pageNum=<%=i%>"><%=i %></a>
      			<%
      		}
      		//Next
      		if(pageCount > endPage){
      			%>
      			<a href="gallery_main.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
      			<%
      		}
      	
      	}
      %>
     	<span>-</span>
      </div>
      	<div id="wrbtn">
      		<input class="board_wr_btn" type="button" value="갤러리 글 쓰기" onclick="location.href='gallery_write.jsp';">
      	</div>
      </div>
     </div>
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
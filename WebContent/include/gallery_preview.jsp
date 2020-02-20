<%@page import="java.util.List"%>
<%@page import="net.gallery.db.GalleryBean"%>
<%@page import="net.gallery.db.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card">
      <h3>Gallery Preview</h3>
		<%
			GalleryDAO gdao = new GalleryDAO();
		
			int gcount = gdao.getGalleryCount();
			
			int gpageSize = 2;
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum = "1";
			}
			
			int gcurrentPage = Integer.parseInt(pageNum);
			int gstartRow = (gcurrentPage-1)*gpageSize+1;
			
			int gendRow = gcurrentPage*gpageSize;
			
			List<GalleryBean> gboardList = null;
			
			if(gcount != 0){
				gboardList = gdao.getGalleryList(gstartRow, gpageSize);
				for(int i=0;i<gboardList.size();i++){
					GalleryBean gb = gboardList.get(i);
		%>
			<div class="gall_main">
    			<div class="gallery_pre">
  					<a href="../gallery/gallery_content.jsp?num=<%=gb.getNum()%>&pageNum=<%=pageNum%>">
    					<img src="../upload_img/<%=gb.getImg_name() %>" alt="Cinque Terre" width="600" height="400">
  					</a>
  					<div class="desc_pre">
  						<div class="desc_title"><h5><%=gb.getSubject() %></h5></div>
  						<div class="desc_id"><%=gb.getId() %></div>
  					</div>
				</div>
      		</div>
			
      	<%
				}
			}
      	%>
    </div>
</body>
</html>
<%@page import="net.comment.db.CommentDAO"%>
<%@page import="net.comment.db.CommentBean"%>
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
if(id == null){
	response.sendRedirect("../member/loginForm.jsp");
}else{

//파라미터 값 저장
int num = (int)Double.parseDouble(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//DB 처리 객체 생성
BoardDAO bdao = new BoardDAO();

//plusReadCount();
bdao.plusReadCount(num);

//getBoard(num);
BoardBean bb = bdao.getBoard(num);

//comment
//DB 처리 객체 생성
CommentDAO cdao = new CommentDAO();

//댓글 개수 확인 메서드 호출
int cmtCount = cdao.getCommentCount(num);

%>
<div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>Board</h2>
      <div class="board_area">
		<div class="content_all">
			<table>
				<tr>
					<td>
						<div class="content_main">
							<table>
								<tr>
									<td>
										<div class="article">
											<table style="clear:both;">
												<tr>
													<td>
														<div class="tbarticle">
															<div class="arthead">
																<div class="artinfo">
																	<div class="artwriter">
																		<span><%=bb.getId() %></span>
																	</div>
																	<div class="artip">
																		<span><%=bb.getIp() %></span>
																	</div>
																	<div class="artdate">
																		<span><%=bb.getDate() %></span>
																	</div>
																	<div class="artread">
																		<span><strong>조회수 : </strong><%=bb.getReadcount() %></span>
																	</div>
																</div>
															</div>
															<div class="artmain">
																<div class="artsubject">
																	<h2><%=bb.getSubject() %></h2>
																</div>
																<div class="artcontent">
																	<p>
																	<%=bb.getContent() %>
																	</p>
																</div>
															</div>
															<div class="artbtn">
																<div class="btn">
																	<%if(id.equals(bb.getId()) || id.equals("administrator")) {%>
																	<a href="board_update.jsp?num=<%=num%>&pageNum=<%=pageNum%>">수정하기</a> |
																	<a href="board_delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>">삭제하기</a> |
																	<%} %>
																	<a href="board_reply.jsp?num=<%=num%>&pageNum=<%=pageNum%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>">답글쓰기</a> |
																	<a href="board_main.jsp?pageNum<%=pageNum%>">목록보기</a> |
																	<a href="#content_cmt">댓글(<%=cmtCount %>)</a>
																</div>
															</div>
														</div>
													</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>	
						</div>
						<div class="content_space"></div>
						<div class="content_cmt" id="content_cmt">
						
						
							<table>
								<tr>
									<td>
										<div class="article">
											<table style="clear:both;">
												<tr>
													<td>
														<div class="tbarticle">
															<div class="arthead">
																<div class="artinfo">
																	<h2>Comment (<%=cmtCount %>)</h2>
																</div>
															</div>
															<%
																//댓글 목록 가져오기
																List<CommentBean> cmtList = null;
																if(cmtCount != 0){
																	//DB에서 댓글 가져오기
																	cmtList = cdao.getCommentList(num);
																	for(int i = 0; i<cmtList.size();i++){
																	CommentBean cb = new CommentBean();
																	cb = cmtList.get(i);
															%>
															<div class="artmain">
																<div class="cmt_head">
																	<span class="cmtId"><%=cb.getId() %></span>
																	<%if(bb.getId().equals(cb.getId())){ %>
																	<span class="icon">작성자</span>
																	<%} %>
																	<span class="cmtd">| <%=cb.getReg_date() %></span>
																</div>
																<div class="cmt_content">
																	<p>
																	<%=cb.getContent() %>
																	</p>
																</div>
															
																<div class="artbtn">
																	<div class="cmt_dbtn">
																		<%if(id.equals(bb.getId())) {%>
																			<%-- <a href="board_cmtDelete.jsp?num=<%=num%>&board_num=<%cb.getBoard_num()%>&pageNum=<%=pageNum%>">삭제하기</a> --%>
																			<input type="button" value="삭제하기" onclick="delCmt();">
																			<script type="text/javascript">
																				function delCmt(){
																					var quest = confirm("삭제하시겠습니까?");
																					if(quest){
																						location.href="board_delCmt.jsp?num=<%=cb.getNum()%>&board_num=<%=num%>";
																					}
																				}
																			</script>
																		<%} %>																	
																	</div>
																</div>
															</div>
															<%
																	}
																}
															%>
															<div class="cmt_write">
																<div class="cwid">
																	<h4><%=id %></h4>
																</div>
																<form action="board_commentPro.jsp" method="post">
																	<input type="hidden" name="pageNum" value="pageNum">
																	<input type="hidden" name="board_num" value="<%=num%>">
																	<input type="hidden" name="id" value="<%=id%>">
																	<div class="cwcont">
																		<textarea class="cw_content" name="content" cols="90" rows="4" placeholder="댓글을 남겨주세요~!"></textarea>
																	</div>
																	<div class="cwbtn">
																		<input type="submit" value="등록">
																	</div>
																</form>
															</div>
														</div>
													</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>	
						</div>
					</td>
				</tr>
			</table>
		</div>	
      </div>
      
    </div>
  </div>
  <div class="rightcolumn">
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
</div>

<!-- footer -->
<jsp:include page="../include/footer.jsp" />
<!-- footer -->
<%
}
%>
</body>

</html>
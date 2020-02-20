package net.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
//import javax.naming.NamingException;
import javax.sql.DataSource;

public class CommentDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	//getConn() 메서드 시작
	private Connection getConn() {
		System.out.println("CommentDAO-getConn() 호출");
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/class7PJDB");
			con = ds.getConnection();
			System.out.println("드라이버 로드 & DB 연결 성공!");
		} catch (Exception e) {
			System.out.println("드라이버 로드 & DB 연결 실패!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
	
	//closeDB() 메서드 시작
	public void closeDB(){
		System.out.println("CommentDAO-closeDB() 호출");
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(con != null)con.close();
			System.out.println("DB 종료 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("DB 종료 실패!");
			e.printStackTrace();
		}
	}
	
	//insertComment(id, board_num);
	public boolean insertComment(CommentBean cb){
		System.out.println("CommentDAO-insertComment() 호출");
		int num = 0;
		boolean result = false;
	
		con = getConn();
		
		try {
			sql = "select max(num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			sql = "insert into comment values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, cb.getId());
			pstmt.setInt(3, num);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setString(6, cb.getContent());
			pstmt.setInt(7, cb.getBoard_num());
			pstmt.setTimestamp(8, cb.getReg_date());
			
			pstmt.executeUpdate();
			
			System.out.println("댓글쓰기 성공! "+cb);
			result = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("댓글쓰기 실패!");
			result = false;
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//getCommentCount(num) 메서드 시작
	public int getCommentCount(int num){
		System.out.println("CommentDAO-getCountComment() 호출");
		int count = 0;
		con = getConn();
		
		try {
			sql = "select count(num) from comment where board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("현재 count : "+count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
	
	
	//getCommentList(num) 메서드 시작
	public List<CommentBean> getCommentList(int num){
		System.out.println("CommentDAO-getCommentList() 호출");
		List<CommentBean> cmtList = new ArrayList<CommentBean>();
		con = getConn();
		
		try {
			sql = "select * from comment where board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CommentBean cb = new CommentBean();
				
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setContent(rs.getString("content"));
				cb.setBoard_num(rs.getInt("board_num"));
				cb.setReg_date(rs.getTimestamp("reg_date"));
				
				cmtList.add(cb);
				System.out.println("cmtList : "+cmtList);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return cmtList;
	}
	
	//cmtDelete(num,board_num)
	public int cmtDelete(int num, int board_num){
		System.out.println("CommentDAO-cmtDelete() 호출");
		int result = 0;
		con = getConn();
		
		try {
			sql = "delete from comment where num=? and board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, board_num);
			pstmt.executeUpdate();
			
			result = 1;
			System.out.println("댓글 삭제 완료!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result = 0;
			System.out.println("댓글 삭제 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
}

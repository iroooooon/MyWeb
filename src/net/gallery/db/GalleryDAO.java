package net.gallery.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GalleryDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	//getConn()
	private Connection getConn(){
		System.out.println("GalleryDAO-getConn() 호출");
		Context init;
		try {
			init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/class7PJDB");
			con = ds.getConnection();
			
			System.out.println("DB 연결 성공!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DB 연결 실패!");
			e.printStackTrace();
		}
		return con;
	}
	
	//closeDB()
	public void closeDB(){
		System.out.println("GalleryDAO-closeDB() 호출");
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//insertGallery(gb)
	public boolean insertGallery(GalleryBean gb){
		System.out.println("GalleryDAO-inserGallery() 호출");
		boolean result = false;
		
		int num = 0;
		con = getConn();

		try {
			sql = "select max(num) from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			sql = "insert into gallery values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, gb.getSubject());
			pstmt.setString(3, gb.getImg_name());
			pstmt.setTimestamp(4, gb.getReg_date());
			pstmt.setString(5, gb.getPass());
			pstmt.setString(6, gb.getContent());
			pstmt.setInt(7, 0);
			pstmt.setString(8, gb.getId());
			
			pstmt.executeUpdate();
			result = true;
			
			System.out.println("갤러리 글 저장 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = false;
		} finally{
			closeDB();
		}
		return result;
	}
	
	//getGalleryCount()
	public int getGalleryCount(){
		System.out.println("GalleryDAO-getGalleryCount() 호출");
		int count = 0;
		
		con = getConn();
		
		try {
			sql = "select count(num) from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("count :"+count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
	
	//getGalleryList(startRow,pageSize)
	public List<GalleryBean> getGalleryList(int startRow,int pageSize){
		System.out.println("GalleryDAO-getGalleryList() 호출");
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		
		con = getConn();
		try {
			sql = "select * from gallery order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				GalleryBean gb = new GalleryBean();
				
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setImg_name(rs.getString("img_name"));
				gb.setReg_date(rs.getTimestamp("reg_date"));
				gb.setPass(rs.getString("pass"));
				gb.setContent(rs.getString("content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setId(rs.getString("id"));
				
				galleryList.add(gb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return galleryList;
	}
	
	//plusReadCount(num)
	public void plusReadCount(int num){
		System.out.println("GalleryDAO-plusReadCount() 호출");
		con = getConn();
		
		try {
			sql = "update gallery set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			System.out.println("조회수 1 증가 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("조회수 1 증가 실패!");
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
	
	//getGallery(num)
	public GalleryBean getGallery(int num){
		System.out.println("GalleryDAO-getGallery() 호출");
		GalleryBean gb = null;
		
		con = getConn();
		
		try {
			sql = "select * from gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				gb = new GalleryBean();
				
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setImg_name(rs.getString("img_name"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setPass(rs.getString("pass"));
				gb.setReg_date(rs.getTimestamp("reg_date"));
				gb.setId(rs.getString("id"));
				gb.setContent(rs.getString("content"));
				
			}
			System.out.println("저장완료!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return gb;
	}
	
	//updateGallery(gb)
	public int updateGallery(GalleryBean gb){
		System.out.println("GalleryDAO-updateGallery() 호출");
		int result = -1;
		
		con = getConn();
		
		try {
			sql = "select pass from gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gb.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString("pass").equals(gb.getPass())){
					sql = "update gallery set subject=?, content=?, img_name=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, gb.getSubject());
					pstmt.setString(2, gb.getContent());
					pstmt.setString(3, gb.getImg_name());
					pstmt.setInt(4, gb.getNum());
					result = pstmt.executeUpdate();
					
					System.out.println("갤러리 글 수정 성공!");
				}else{
					//비밀번호 불일치
					result = 0;
					System.out.println("비밀번호 불일치");
				}
			}else{
				result = -1;
				System.out.println("글 번호 없음");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//deleteGallery(num,id,pass)
	public boolean deleteGallery(int num,String id,String pass){
		System.out.println("GalleryDAO-deleteGallery() 호출");
		boolean result = false;
		con = getConn();
				
		try {
			sql = "select pass from gallery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					sql = "delete from gallery where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
					System.out.println("삭제 완료!");
					result = true;
				}else{
					System.out.println("비밀번호 오류!");
					result = false;
				}
			}else{
				System.out.println("글 없음!");
				result = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
}

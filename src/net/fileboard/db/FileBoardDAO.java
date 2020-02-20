package net.fileboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FileBoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	//getConn() 메서드 시작
	private Connection getConn() {
		System.out.println("FileBoardDAO-getConn() 호출");
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/class7PJDB");
			con = ds.getConnection();
			System.out.println("드라이버 로드 & DB 연결 성공!!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("드라이버 로드 & DB 연결 실패!!");
			e.printStackTrace();
		}
		return con;
	}
	
	//closeDB() 메서드 시작
	public void closeDB(){
		System.out.println("FileBoardDAO-closeDB() 호출");
		try {
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
			System.out.println("DB 연결 종료 성공!");
		} catch (SQLException e) {
			System.out.println("DB 연결 종료 실패!!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//insertFile() 메서드 시작
	public boolean insertFile(FileBoardBean fbb){
		boolean result = false;
		int num = 0;
		con = getConn();
		
		try {
			sql = "select max(num) from fileboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("num : "+num);
			
			sql = "insert into fileboard values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, fbb.getId());
			pstmt.setString(3, fbb.getPass());
			pstmt.setString(4, fbb.getSubject());
			pstmt.setString(5, fbb.getContent());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, num);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setTimestamp(10, fbb.getDate());
			pstmt.setString(11, fbb.getIp());
			pstmt.setString(12, fbb.getFile());
			
			pstmt.executeUpdate();
			result = true;
			System.out.println("글 저장 완료! fbb : "+fbb.toString());
		} catch (SQLException e) {
			result = false;
			System.out.println("글 저장 실패!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//getFileBoardCount() 메서드 시작
	public int getFileBoardCount(){
		System.out.println("FileBoardDAO-getFileBoardCount() 호출");
		int count = 0;
		con = getConn();
		
		try {
			sql = "select count(num) from fileboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("글 개수 계산 완료! count:"+count);
		} catch (SQLException e) {
			System.out.println("글 개수 계산 실패!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
	
	//getFileBoardList() 메서드 시작
	public List<FileBoardBean> getFileBoardList(int startRow, int pageSize){
		System.out.println("FileBoardDAO-getFileBoardList() 호출");
		List<FileBoardBean> fBoardList = new ArrayList<FileBoardBean>();
		con = getConn();
		
		try {
			sql = "select * from fileboard order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				FileBoardBean fbb = new FileBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setId(rs.getString("id"));
				fbb.setPass(rs.getString("pass"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setReadcount(rs.getInt("readcount"));
				fbb.setRe_ref(rs.getInt("re_ref"));
				fbb.setRe_lev(rs.getInt("re_lev"));
				fbb.setRe_seq(rs.getInt("re_seq"));
				fbb.setDate(rs.getTimestamp("date"));
				fbb.setIp(rs.getString("ip"));
				fbb.setFile(rs.getString("file"));
				
				fBoardList.add(fbb);
			}
			System.out.println("글 리스트 저장 완료!");
		} catch (SQLException e) {
			System.out.println("글 리스트 저장 실패!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return fBoardList;
	}
	
	//plusReadCount(num) 메서드 호출
	public void plusReadCount(int num){
		System.out.println("FileBoardDAO-plusReadCount() 호출");
		
		con = getConn();
		
		try {
			sql = "update fileboard set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			System.out.println("조회수 1 증가 완료!");
		} catch (SQLException e) {
			System.out.println("조회수 1 증가 실패!");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	
	
	//getFileBoard(num) 메서드 호출
	public FileBoardBean getFileBoard(int num){
		System.out.println("FileBoardDAO-getFileBoard() 호출");
		FileBoardBean fbb = null;
		con = getConn();
		
		try {
			sql = "select * from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				fbb = new FileBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setId(rs.getString("id"));
				fbb.setPass(rs.getString("pass"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setReadcount(rs.getInt("readcount"));
				fbb.setRe_ref(rs.getInt("re_ref"));
				fbb.setRe_lev(rs.getInt("re_lev"));
				fbb.setRe_seq(rs.getInt("re_seq"));
				fbb.setDate(rs.getTimestamp("date"));
				fbb.setIp(rs.getString("ip"));
				fbb.setFile(rs.getString("file"));
			}
			System.out.println("글 정보 저장 완료! fbb : "+fbb.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("글 정보 저장 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return fbb;
	}
	
	//getIDCheck(id,num) 메서드 시작
	public int getIDCheck(String id,int num){
		System.out.println("FileBoardDAO-getIDCheck() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select id from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//글이 있을 경우
				if(id.equals(rs.getString("id"))){
					//아이디 일치
					result = 1;
					System.out.println("아이디 조회 완료! result(1:일치/0:불일치/-1:글없음) : "+result);
				}else{
					//아이디 불일치
					result = 0;
					System.out.println("아이디 조회 완료! result(1:일치/0:불일치/-1:글없음) : "+result);
				}
			}else{
				//글이 없을 경우
				result = -1;
				System.out.println("아이디 조회 완료! result(1:일치/0:불일치/-1:글없음) : "+result);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("조회 실패!");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return result;
	}
	
	//updateFileBoard(fbb) 메서드 시작
	public int updateFileBoard(FileBoardBean fbb){
		System.out.println("FileBoardDAO-updateFileBoard() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select pass from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fbb.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				//글이 있을 떄
				if(rs.getString("pass").equals(fbb.getPass())){
					//비밀번호 일치
					sql = "update fileboard set subject=?,content=?,file=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, fbb.getSubject());
					pstmt.setString(2, fbb.getContent());
					pstmt.setString(3, fbb.getFile());
					pstmt.setInt(4, fbb.getNum());
					result = pstmt.executeUpdate();
		
					System.out.println("자료실 글 수정 완료! fbb:"+fbb.toString());
				}else{
					//비밀번호 불일치
					result = 0;
					System.out.println("비밀번호 불일치!");
				}
			}else{
				//글이 없을 때
				result = -1;
				System.out.println("글 없음!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//deleteFileBoard() 메서드 호출 
	public boolean deleteFileBoard(int num,String id,String pass){
		System.out.println("FileBoardDAO-deleteFileBoard() 호출");
		boolean result = false;
		con = getConn();
				
		try {
			sql = "select pass from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					sql = "delete from fileboard where num=?";
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
	
	//
}

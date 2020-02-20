package net.board.db;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	//getConn() 메서드 시작
	private Connection getConn(){
		System.out.println("BoardDAO-getConn() 호출");
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/class7PJDB");
			con = ds.getConnection();
			System.out.println("DB 연결 성공!!!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DB 연결 실패!!!!!!!");
			e.printStackTrace();
		}
		return con;
	}
	
	//closeDB() 메서드 시작
	public void closeDB(){
		System.out.println("BoardDAO-closeDB() 호출");
		
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(con != null)con.close();
			System.out.println("DB 연결 종료 완료!!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("DB 연결 종료 실패!!!!!");
			e.printStackTrace();
		}
	}
	
	//getBoardCount() 메서드 호출
	public int getBoardCount(){
		System.out.println("BoardDAO-getBoardCount() 호출");
		int count = 0;
		con = getConn();
		
		try {
			sql = "select count(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("count : "+count);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("글 개수 계산 실패!!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
	
	//insertBoard(bb) 메서드 시작
	public boolean insertBoard(BoardBean bb){
		boolean result = false;
		int num = 0;
		con = getConn();
		
		try {
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("글번호 : "+num);
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);//readcount
			pstmt.setInt(7, num);//re_ref
			pstmt.setInt(8, 0);//re_lev
			pstmt.setInt(9, 0);//re_seq
			pstmt.setTimestamp(10, bb.getDate());
			pstmt.setString(11, bb.getIp());
			pstmt.executeUpdate();
			
			System.out.println("글 쓰기 완료! bb : "+bb.toString());
			result = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("글 쓰기 실패!");
			result = false;
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//getBoardList(startRow, pageSize) 메서드 시작
	public List<BoardBean> getBoardList(int startRow, int pageSize){
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		con = getConn();
		
		try {
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setIp(rs.getString("ip"));
				
				boardList.add(bb);
			}
			System.out.println("글 리스트 가져오기 성공!: "+boardList.size());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("글 리스트 가져오기 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return boardList;
	}
	
	//plusReadCount(num) 메서드 시작
	public void plusReadCount(int num){
		System.out.println("BoardDAO-plusReadCount() 호출");
		con = getConn();
		
		try {
			sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("조회수 1 증가 완료!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("조회수 1 증가 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	
	//getBoard(num) 메서드 시작
	public BoardBean getBoard(int num){
		System.out.println("BoardDAO-getBoard() 호출");
		BoardBean bb = null;
		con = getConn();
		
		try {
			sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setIp(rs.getString("ip"));
					
			}
			System.out.println("글 정보 가져오기 성공! bb : "+bb.toString());	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("글 정보 가져오기 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}return bb;
	}
	
	//updateBoard(bb) 메서드 시작
	public int updateBoard(BoardBean bb){
		System.out.println("BoardDAO-updateBoard() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select pass from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				//글이 있을 경우
				if(rs.getString("pass").equals(bb.getPass())){
					//비밀번호 일치
					sql = "update board set subject=?,content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setInt(3, bb.getNum());
					result = pstmt.executeUpdate();
					
					System.out.println("bb : "+bb);
					System.out.println("글 수정 성공!");
				}else{
					//비밀번호 불일치
					result = 0;
					System.out.println("비밀번호 오류!");
				}
			}else{
				//글이 없을 경우
				result = -1;
				System.out.println("글이 존재하지 않음!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//deleteBoard() 메서드 시작
	public int deleteBoard(String id, String pass, int num){
		System.out.println("BoardDAO-deleteBoard() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select pass from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//아이디 있을 경우
				if(pass.equals(rs.getString("pass"))){
					//비밀번호 일치
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
					result = 1;
					System.out.println("글 삭제 완료!");
				}else{
					//비밀번호 불일치
					result = 0;
					System.out.println("비밀번호 오류!");
				}
			}else{
				//아이디 없을 경우
				result = -1;
				System.out.println("아이디 오류!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//insertReply(bb) 메서드 시작
	public boolean insertReply(BoardBean bb){
		System.out.println("BoardDAO-insertReply() 호출");
		boolean result = false;
		int num = 0;
		con = getConn();
		
		try {
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("num : "+num);
			//답글 순서 재배치
			//re_ref(같은 그룹), re_seq 기존의 값 보다 큰 값이 있을 경우 순서 변경하기 위해 re_seq+1
			sql = "update board set re_seq = re_seq+1 where re_ref=?&re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			pstmt.executeUpdate();
			System.out.println("답글 재정렬 완료!");
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, bb.getRe_ref());
			pstmt.setInt(8, bb.getRe_lev()+1);
			pstmt.setInt(9, bb.getRe_seq()+1);
			pstmt.setTimestamp(10, bb.getDate());
			pstmt.setString(11, bb.getIp());
			
			pstmt.executeUpdate();
			
			result = true;
			System.out.println("답글 쓰기 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result = false;
			System.out.println("답글 쓰기 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}

	//
}
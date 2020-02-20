package net.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import net.member.db.MemberBean;

public class MemberDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	//getConn() 메서드 시작
	private Connection getConn(){
		System.out.println("MemberDAO-getConn() 호출");
		//Context 객체 생성
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/class7PJDB");
			con = ds.getConnection();
			System.out.println("DB연결 성공!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DB 연결 실패!");
			e.printStackTrace();
		}
		return con;
	}
	
	//closeDB() 메서드 시작
	public void closeDB(){
		System.out.println("MemberDAO-closeDB() 호출");
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(con != null)con.close();
			System.out.println("DB 연결 종료 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("DB 연결 종료 실패!");
			e.printStackTrace();
		}
	}
	
	//joinIDCheck() 메서드시작
	public boolean joinIDCheck(String id){
		System.out.println("MemberDAO-joinIDCheck() 호출");
		boolean result = false;
		
		//DB 연결
		con = getConn();
		
		try {
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//아이디 있을 때
				result = true;
			}else{
				//아이디 없을 때
				result = false;
			}
			System.out.println("아이디 조회 완료!(true-있음/false-없음) : " +result);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result = false;
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//insertMember() 메서드 시작
	public int insertMember(MemberBean mb){
		System.out.println("MemberDAO-insertMember() 호출");
		int result = 0;
		
		con = getConn();
		
		try {
			sql = "insert into member values(null,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setInt(4, mb.getAge());
			pstmt.setString(5, mb.getGender());
			pstmt.setString(6, mb.getEmail());
			pstmt.setString(7, mb.getPhone());
			pstmt.setInt(8, mb.getPostcode());
			pstmt.setString(9, mb.getAddress());
			pstmt.setString(10, mb.getD_address());
			pstmt.setString(11, mb.getE_address());
			pstmt.setTimestamp(12, mb.getReg_date());
			
			pstmt.executeUpdate();
			System.out.println("회원 정보 저장 완료! mb : "+mb.toString());
			
			result = 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("회원 정보 저장 실패!");
			result = 0;
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//loginMember() 메서드 시작
	public int loginMember(String id, String pass){
		System.out.println("MemberDAO-loginMember() 호출");
		int result = -1;
		
		con = getConn();
		
		try {
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//아이디 있을 경우
				if(pass.equals(rs.getString("pass"))){
					//로그인 성공
					result = 1;
				}else{
					//비밀번호 오류
					result = 0;
				}
			}else{
				//아이디 없을 경우
				result = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return result;
	}
	
	//getMember() 메서드 시작
	public MemberBean getMember(String id){
		System.out.println("MemberDAO-getMember() 호출");
		MemberBean mb = null;
		
		con = getConn();
		
		try {
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setPostcode(rs.getInt("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setD_address(rs.getString("d_address"));
				mb.setE_address(rs.getString("e_address"));
			}
			System.out.println("회원 정보 가져오기 성공! mb = "+mb.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("회원 정보 가져오기 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return mb;
	}
	
	//updateMember() 호출
	public int updateMember(MemberBean mb){
		System.out.println("MemberDAO-updateMember() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			rs = pstmt.executeQuery();
			if(rs.next()){
				//아이디 있을 때
				if(mb.getPass().equals(rs.getString("pass"))){
					//비밀번호 일치
					sql = "update member set name=?, age=?, gender=?, email=?, phone=?, postcode=?, "
							+ "address=?, d_address=?, e_address=?, reg_date=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, mb.getName());
					pstmt.setInt(2, mb.getAge());
					pstmt.setString(3, mb.getGender());
					pstmt.setString(4, mb.getEmail());
					pstmt.setString(5, mb.getPhone());
					pstmt.setInt(6, mb.getPostcode());
					pstmt.setString(7, mb.getAddress());
					pstmt.setString(8, mb.getD_address());
					pstmt.setString(9, mb.getE_address());
					pstmt.setTimestamp(10, mb.getReg_date());
					pstmt.setString(11, mb.getId());
					
					pstmt.executeUpdate();
					result = 1;
					System.out.println("회원 정보 수정 완료! mb : "+mb.toString());
				}else{
					//비밀번호 불일치
					System.out.println("회원 정보 수정 실패!(0)");
					result = 0;
				}
			}else{
				//아이디 없을 때
				System.out.println("회원 정보 수정 실패!(-1)");
				result = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	//deleteMember(id,pass) 메서드 시작
	public int deleteMember(String id, String pass){
		System.out.println("MemberDAO-deleteMember() 호출");
		int result = -1;
		con = getConn();
		
		try {
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				//아이디 존재
				if(pass.equals(rs.getString("pass"))){
					//비밀번호 일치
					sql = "delete from member where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					
					System.out.println("회원 탈퇴 성공!");
					result = 1;
				}else{
					//비밀번호 오류
					System.out.println("비밀번호 오류!");
					result = 0;
				}
			}else{
				//아이디 없음
				System.out.println("아이디 없음!");
				result = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return result;
	}
	
	
	//getMemberList();
	public List<MemberBean> getMemberList(){
		List<MemberBean> memberList = new ArrayList<MemberBean>();
		con = getConn();
		
		try {
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemberBean mb = new MemberBean();
				
				
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setPostcode(rs.getInt("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setD_address(rs.getString("d_address"));
				mb.setE_address(rs.getString("e_address"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				
				memberList.add(mb);
			}
			System.out.println("회원 목록 가져오기 성공! :" +memberList.size());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("회원 목록 가져오기 실패!");
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return memberList;
	}
	
	//getMemberCount()
	
	public int getMemberCount(){
		int count = 0;
		con = getConn();
		
		try {
			sql = "select count(id) from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("MemberCount :"+count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
}

package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	
	private Connection getConnection()throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con=ds.getConnection();
		return con;
	}
	
	public void freeResource(){
		if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
	}
	
	public void insertMember(MemberBean mb) {
	
		try {
			con=getConnection();
			sql="insert into mem(id,passwd,name,reg_date,mtel,email,birth,postcode,addr1,addr2)"
				+ "values(?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPasswd());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getReg_date());
			pstmt.setString(5, mb.getMtel());
			pstmt.setString(6,mb.getEmail());
			pstmt.setInt(7, mb.getBirth());
			pstmt.setInt(8, mb.getPostcode());
			pstmt.setString(9, mb.getAddr1());
			pstmt.setString(10, mb.getAddr2());
			
			pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("insert 실패 : "+e);
		}finally {
			freeResource();
		}
	}
	
	public int idCheck(String id) {
		int check=0;
		try {
			con=getConnection();
			sql="select * from mem where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				check=1;
			}else {
				check=0;
			}
		}catch (Exception e) {
			System.out.println("idCheck 실패 : "+e);
		}finally {
			freeResource();
		}
		return check;
	}
	
	public int userCheck(String id,String passwd) {
		int check=-1;
		try {
			con=getConnection();
			sql="select * from mem where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))) {
					check=1;
				}else {
					check=0;
				}
			}else {
				check=-1;
			}
		}catch (Exception e) {
			System.out.println("userCheck 실패 : "+e);
		}finally {
			freeResource();
		}
		return check;
	}
	
	
	public int getPass(String id,String passwd) {
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select passwd from mem where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
				}
			}
			
		} catch (Exception e) {
			System.out.println("비밀번호 얻기 실패 :"+e);
		}finally {
			freeResource();
		}
		
		return check;
	}
	
	
	public MemberBean getMember(String id){

			MemberBean mb = null;
			
			try {
				con = getConnection();

				sql = "select * from mem where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);			
				rs = pstmt.executeQuery();  			
				rs.next();
				
				mb = new MemberBean();			
				mb.setAddr1(rs.getString("addr1"));
				mb.setAddr2(rs.getString("addr2"));
				mb.setPostcode(rs.getInt("postcode"));
				mb.setBirth(rs.getInt("birth"));
				mb.setEmail(rs.getString("email"));
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setPasswd(rs.getString("passwd"));
				mb.setMtel(rs.getString("mtel"));
				
			} catch (Exception e) {
				System.out.println("getMember실패 :"+e);
			} finally {
				freeResource();
			}//finally					
			return mb; 
		}//getMember 메소드 끝
	
	
	public int updateMember(MemberBean mb){
		int check = 0;
		
		try {
			con = getConnection();
			
				sql ="update mem set passwd=?, name=?, mtel=?, email=?, birth=?, postcode=?, addr1=?,addr2=? where id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mb.getPasswd());
				pstmt.setString(2, mb.getName());
				pstmt.setString(3, mb.getMtel());
				pstmt.setString(4, mb.getEmail());
				pstmt.setInt(5, mb.getBirth());
				pstmt.setInt(6, mb.getPostcode());
				pstmt.setString(7, mb.getAddr1());
				pstmt.setString(8, mb.getAddr2());
				pstmt.setString(9, mb.getId());
				//UPDATE
				check = pstmt.executeUpdate();
				
		} catch (Exception e) {
			System.out.println("updateMember 실패 : "+e);
	
		}finally {
			freeResource();		
		}	
		return check;
	} //updateMember끝
	
	
	
	
	
	
}//DAO끝

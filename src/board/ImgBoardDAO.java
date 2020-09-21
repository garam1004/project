package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ImgBoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	
	private Connection getConnection() throws Exception{
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
	
	public int getBoardCount() {
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from imgboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("count얻기 실패 : "+e);
		}finally {
			freeResource();
		}
		
		return count;
	} 
	
	public ArrayList<ImgBoardBean> getBoardList() {
		
		ArrayList<ImgBoardBean>  boardList = new ArrayList<ImgBoardBean>();
		
		try {
			con = getConnection();
			sql = "select * from imgboard order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ImgBoardBean iBean = new ImgBoardBean();
				iBean.setContent(rs.getString("content"));
				iBean.setCount(rs.getInt("count"));
				iBean.setFile(rs.getString("file"));
				iBean.setIp(rs.getString("ip"));
				iBean.setName(rs.getString("name"));
				iBean.setNum(rs.getInt("num"));
				iBean.setDate(rs.getTimestamp("date"));
				iBean.setSubject(rs.getString("subject"));
				iBean.setPasswd(rs.getString("passwd"));
				
				boardList.add(iBean);
			}
		} catch (Exception e) {
			System.out.println("getBoardList 얻기 실패 : "+e);
		}finally {
			freeResource();
		}
		
		return boardList;
	}//getBoardList 끝
	
	
	
	public void insertBoard(ImgBoardBean iBean){
			int num = 0;
		try {
			con = getConnection();
			sql = "select max(num) from imgboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			
			sql = "insert into imgboard (num,name,subject,content,count,ip,date,file,passwd)"
				+ " values(?,?,?,?,?,?,?,?,?);";		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, iBean.getName());
			pstmt.setString(3, iBean.getSubject());
			pstmt.setString(4, iBean.getContent());
			pstmt.setInt(5, 0);
			pstmt.setString(6, iBean.getIp());
			pstmt.setTimestamp(7, iBean.getDate()); 
			pstmt.setString(8, iBean.getFile());
			pstmt.setString(9, iBean.getPasswd());
			
			pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			System.out.println("insert 실패 : "+e);
		}finally {
			freeResource();			
		}		
	}
	
	public ImgBoardBean getBoard(int num){
		
		ImgBoardBean iBean = null;
		
		try {
			
			con = getConnection();
			
			sql = "select * from imgboard where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);			
			rs = pstmt.executeQuery();  			
			
			if(rs.next()){
			
			iBean = new ImgBoardBean();			
			iBean.setContent(rs.getString("content"));
			iBean.setCount(rs.getInt("count"));
			iBean.setFile(rs.getString("file"));
			iBean.setIp(rs.getString("ip"));
			iBean.setName(rs.getString("name"));
			iBean.setNum(rs.getInt("num"));
			iBean.setDate(rs.getTimestamp("date"));
			iBean.setSubject(rs.getString("subject"));
			}else iBean = new ImgBoardBean();
			
		} catch (Exception e) {
			System.out.println("getBoard 얻기 실패 : "+e);
		} finally {
			freeResource();
		}//finally					
		return iBean; //getBoard 끝
	}
	
	public int updateBoard(ImgBoardBean iBean) {
		int check=0;
		
		try {
			con=getConnection();
			sql="select passwd from imgboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, iBean.getNum());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(iBean.getPasswd().equals(rs.getString("passwd"))) {
					check=1;
					sql="update imgboard set subject=?, content=?, file=? where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, iBean.getSubject());
					pstmt.setString(2, iBean.getContent());
					pstmt.setString(3, iBean.getFile());
					pstmt.setInt(4, iBean.getNum());
					pstmt.executeUpdate();
				}else {
					check=0;
				}
			}
		}catch (Exception e) {
			System.out.println("updateBoard 얻기 실패 :"+e);
		}finally {
			freeResource();
		}
		return check;
	}
	

	public int deleteBoard(int num, String passwd){
		int check = 0;
	
		try {
			con = getConnection();
			sql = "select passwd from imgboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					sql = "delete from imgboard where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}else { 
					check=0;
			}		
			} 
		}catch (Exception e) {
			System.out.println("deleteBoard 얻기 실패 :"+e);
		} finally {
			freeResource();
		}
		return check;
		}
	
	public String getFilename(int num) {
		String filename="";
		try {
			con=getConnection();
			
			sql="select filename from imgboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			rs.next();
			filename = rs.getString(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return filename;
	}


}//imgBoard 끝

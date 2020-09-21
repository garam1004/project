package commnet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CommentDAO {
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
	
	public List getBoard(int num){ 
		
		List commentList = new ArrayList();
		
		try {
			con=getConnection();
			sql="select * from com where ref=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				CommentBean cBean = new CommentBean();
				cBean.setNum(rs.getInt("num"));
				cBean.setId(rs.getString("id"));
				cBean.setContent(rs.getString("content"));
				cBean.setDate(rs.getTimestamp("date"));
				cBean.setRef(rs.getInt("ref"));
				commentList.add(cBean);
			}
		} catch (Exception e) {
			System.out.println("getBoard 실패 :" + e);
		}finally{
			freeResource();
		}
		return commentList;
	} 
	
	public void insertComment(CommentBean cBean){
		int num =  cBean.getNum();
		int number = 0;
				
		try{
			con = getConnection();
			sql="select max(num) as num from com";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1)+1;
			}else{
				number=1;
			}
			sql = "insert into com(num,id,content,ref,date) values(?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, cBean.getId());
			pstmt.setString(3, cBean.getContent());
			pstmt.setInt(4, cBean.getRef());
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("insertComment 실패 :" + e);
		}finally{
			freeResource();
		}
	}
	
	
	public int deleteComment(int num){
		int check = 0;
		
		try {
			con = getConnection();
			sql = "delete from com where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			check = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteComment 실패 :" + e);
		} finally {
			freeResource();
		}
		return check;
		
	}
	
	
}//CommentDAO 끝

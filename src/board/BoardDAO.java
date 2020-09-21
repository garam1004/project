package board;

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
		int count=0;
		try {
			con=getConnection();
			sql="select count(*) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("getBoardCount 실패 :"+e);
		}finally {
			freeResource();			
		}
		return count;
		
	}
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search){

		List<BoardBean> boardList=new ArrayList<BoardBean>();
		try {
			con=getConnection();
			sql="select * from board where subject like ? order by num desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bBean=new BoardBean();
				
				bBean.setContent(rs.getString("content"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				boardList.add(bBean);
			}
		}catch (Exception e) {
			System.out.println("getBoardList 실패 :"+e);
		}finally {
			freeResource();			
		}
		return boardList;
	}


	public void insertBoard(BoardBean bBean) {
		
		
		int num = 0;
	
		try {
			
			con=getConnection();
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			
			sql="insert into board "
				+"(num,name,subject,content,readcount,ip,date,file,re_seq,passwd)"
				+"values(?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getSubject());
			pstmt.setString(4, bBean.getContent());
			pstmt.setInt(5, bBean.getReadcount());
			pstmt.setString(6, bBean.getIp());
			pstmt.setTimestamp(7, bBean.getDate());
			pstmt.setString(8, bBean.getFile());
			pstmt.setInt(9, bBean.getRe_seq());
			pstmt.setString(10, bBean.getPasswd());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("insertBoard 실패 :" + e);
		}finally {
			freeResource();
		}
	}
	
	public BoardBean getBoard(int num){
		
		BoardBean bBean = new BoardBean();
		
		try {
			
			con = getConnection();
			
			sql = "select * from board where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);			
			rs = pstmt.executeQuery();  			
			
			if(rs.next()){
			
			bBean.setContent(rs.getString("content"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setFile(rs.getString("file"));
			bBean.setIp(rs.getString("ip"));
			bBean.setName(rs.getString("name"));
			bBean.setNum(rs.getInt("num"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setSubject(rs.getString("subject"));
			}
			
		} catch (Exception e) {
			System.out.println("getBoard 얻기 실패 : "+e);
		} finally {
			freeResource();
		}//finally					
		return bBean; //getBoard 끝
	}
	
	public void updateReadCount(int num) {
		try {
			con=getConnection();
			sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("updateReadCount 얻기 실패 :"+e);
		} finally {
			freeResource();
		}
	}
	
	public int updateBoard(BoardBean bBean) {
		int check=0;
		
		try {
			con=getConnection();
			sql="select passwd from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNum());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(bBean.getPasswd().equals(rs.getString("passwd"))) {
					check=1;
					sql="update board set subject=?, content=?, file=? where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, bBean.getSubject());
					pstmt.setString(2, bBean.getContent());
					pstmt.setString(3, bBean.getFile());
					pstmt.setInt(4, bBean.getNum());
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
		int check2 = 0;
	
		try {
			con = getConnection();
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					sql = "delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					check2 = pstmt.executeUpdate();
				}else { 
					check=0;
			}		
				if(check2==1) {
					check2=1;
					sql = "delete from com where ref=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
				}
			} 
		}catch (Exception e) {
			System.out.println("deleteBoard 얻기 실패 :"+e);
		} finally {
			freeResource();
		}
		return check;
		}

}//BoardDAO끝




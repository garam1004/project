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

public class rBoardDAO {
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
			sql="select count(*) from rboard";
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
	
	public List<rBoardBean> getBoardList(int startRow, int pageSize, String search){

		List<rBoardBean> rboardList=new ArrayList<rBoardBean>();
		try {
			con=getConnection();
			sql="select * from rboard where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				rBoardBean rbBean = new rBoardBean();
				
				rbBean.setContent(rs.getString("content"));
				rbBean.setPasswd(rs.getString("passwd"));
				rbBean.setDate(rs.getTimestamp("date"));
				rbBean.setIp(rs.getString("ip"));
				rbBean.setName(rs.getString("name"));
				rbBean.setNum(rs.getInt("num"));
				rbBean.setRe_lev(rs.getInt("re_lev"));
				rbBean.setRe_ref(rs.getInt("re_ref"));
				rbBean.setRe_seq(rs.getInt("re_seq"));
				rbBean.setReadcount(rs.getInt("readcount"));
				rbBean.setSubject(rs.getString("subject"));
				
				rboardList.add(rbBean);
			}
		}catch (Exception e) {
			System.out.println("getBoardList 실패 :"+e);
		}finally {
			freeResource();			
		}
		return rboardList;
	}
	
	public void insertBoard(rBoardBean rbBean) {
		
		
		int num = 0;
	
		try {
			
			con=getConnection();
			sql="select max(num) from rboard";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			
			sql="insert into rboard(num,name,subject,content,readcount,"
					+ "ip,date,re_seq,passwd,re_ref,re_lev)"
				+"values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, rbBean.getName());
			pstmt.setString(3, rbBean.getSubject());
			pstmt.setString(4, rbBean.getContent());
			pstmt.setInt(5, 0);
			pstmt.setString(6, rbBean.getIp());
			pstmt.setTimestamp(7, rbBean.getDate());
			pstmt.setInt(8, 0);
			pstmt.setString(9, rbBean.getPasswd());
			pstmt.setInt(10, num);
			pstmt.setInt(11, 0);

			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("insertBoard 실패 :" + e);
		}finally {
			freeResource();
		}
	}
	
	public rBoardBean getBoard(int num){
		
		rBoardBean rbBean = new rBoardBean();
		
		try {
			
			con = getConnection();
			
			sql = "select * from rboard where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);			
			rs = pstmt.executeQuery();  			
			
			if(rs.next()){
			
			rbBean.setContent(rs.getString("content"));
			rbBean.setReadcount(rs.getInt("readcount"));
			rbBean.setIp(rs.getString("ip"));
			rbBean.setName(rs.getString("name"));
			rbBean.setNum(rs.getInt("num"));
			rbBean.setDate(rs.getTimestamp("date"));
			rbBean.setSubject(rs.getString("subject"));
			rbBean.setRe_ref(rs.getInt("re_ref"));
			rbBean.setRe_lev(rs.getInt("re_lev"));
			rbBean.setRe_seq(rs.getInt("re_seq"));
			}
			
		} catch (Exception e) {
			System.out.println("getBoard 얻기 실패 : "+e);
		} finally {
			freeResource();
		}//finally					
		return rbBean; //getBoard 끝
	}
	
	public void updateReadCount(int num) {
		try {
			con=getConnection();
			sql="update rboard set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("updateReadCount 얻기 실패 :"+e);
		} finally {
			freeResource();
		}
	}
	
	public int updateBoard(rBoardBean rbBean) {
		int check=0;
		
		try {
			con=getConnection();
			sql="select passwd from rboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rbBean.getNum());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(rbBean.getPasswd().equals(rs.getString("passwd"))) {
					check=1;
					sql="update rboard set subject=?, content=? where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, rbBean.getSubject());
					pstmt.setString(2, rbBean.getContent());
					pstmt.setInt(3, rbBean.getNum());
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
			sql = "select passwd from rboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					sql = "delete from rboard where num=?";
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
	
	
	public void reInsertBoard(rBoardBean rbBean) {
			int num=0;
		try {
			con=getConnection();
			sql="select max(num) from rboard";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			sql="update rboard set re_seq=re_seq+1 where re_ref=? and re_seq=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rbBean.getRe_ref()); //부모글 그룹번호
			pstmt.setInt(2, rbBean.getRe_seq()); //부모글의 글 입력 순서
			pstmt.executeUpdate();
			
			/*답변글 달기*/
			//insert //re_seq+1 re_lev+1 답글달기
			sql="insert into rboard values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, rbBean.getName());
			pstmt.setString(3, rbBean.getPasswd());
			pstmt.setString(4, rbBean.getSubject());
			pstmt.setString(5, rbBean.getContent());
			pstmt.setInt(6, rbBean.getRe_ref()); //부모글 그룹번호 re_ref 사용
			pstmt.setInt(7, rbBean.getRe_lev()+1); //부모글의 re_lev에 +1을 하여 들여쓰기
			pstmt.setInt(8, rbBean.getRe_seq()+1); //부모글의 re_seq에 +1을 하여 답글을 단 순서 정하기
			pstmt.setInt(9, 0); //readcount 조회수
			pstmt.setTimestamp(10, rbBean.getDate());
			pstmt.setString(11, rbBean.getIp());
			//4 답변달기 실행
			pstmt.executeUpdate();
		
		}catch (Exception e) {
			System.out.println("reInsertBoard 얻기 실패 :"+e);
		}finally {
			freeResource();
		}
		
	}


}//rBoardDAO 

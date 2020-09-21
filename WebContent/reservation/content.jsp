<%@page import="board.rBoardBean"%>
<%@page import="board.rBoardDAO"%>
<%@page import="commnet.CommentBean"%>
<%@page import="commnet.CommentDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE H0TML>


<html>

	<head>
		<title>Reservation</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<link rel="stylesheet" href="../assets/css/board.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	<style type="text/css">
	.btn2{
		padding: 2px;
	    margin: 0 0 0 5px;
	    width: 90px;
	    height: 23px;
	    border: 1px solid #999;
	    height: 30px;
	    border-radius: 10px;
	    color: #FFF;
	    background-color: #019FE1;
		}
	
}
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active4 > a{
		color: #fff;
	}

	</style>
	
	</head>

<%

		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String id=(String)session.getAttribute("id");
	
		rBoardDAO rbdao = new rBoardDAO();
		
		rBoardBean rbBean = rbdao.getBoard(num);
		rbdao.updateReadCount(num);
		
		int DBnum = rbBean.getNum(); 
		int DBReadcount = rbBean.getReadcount(); 
		String DBName = rbBean.getName();
		Timestamp DBDate = rbBean.getDate(); 
		String DBSubject = rbBean.getSubject(); 
		String DBContent = ""; 
	
		if(rbBean.getContent() != null){
			DBContent = rbBean.getContent().replace("\r\n", "<br/>");
		}
		
		int DBRe_ref=rbBean.getRe_ref();
		int DBRe_lev=rbBean.getRe_lev();
		int DBRe_seq=rbBean.getRe_seq();
		
%>

<body>
<jsp:include page="../inc/top.jsp"/>
<div id="bo1">
<center style="width">
<article>
<h1 align="center" style="FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Reservation</h1><br>

<table align="center" id="notice">
<tr>
	<td style="color: #019FE1;">No.</td>
	<td><%=DBnum %></td>
	<td style="color: #019FE1;">Read</td>
	<td><%=DBReadcount +1%></td>
</tr>
<tr>
	<td style="color: #019FE1;">Writer</td>
	<td><%=DBName %></td>
	<td style="color: #019FE1;">Date</td>
	<td><%=DBDate %></td>
</tr>
<tr>
	<td style="color: #019FE1;">Subject</td>
	<td colspan="3" style="text-align: left;"><b style="color: #000;"><%=DBSubject %></b></td>
</tr>
<tr>
	<td style="color: #019FE1;">Content</td>
	<td colspan="3" style="text-align: left;"><%=DBContent %></td>
</tr>


</table>

<%
	if(id!=null){
%>
	<div id="table_search">
	<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
	<input type="button" value="답글쓰기" class="btn" 
   		onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">	
<%
	}
%>
	<input type="button" value="글목록" class="btn2" onclick="location.href='reservation.jsp?pageNum=<%=pageNum%>'">
</div>
<div class="clear"></div>
<br><br>

</article>
</center>
</div>

		<jsp:include page="../inc/bottom.jsp"/>
		
		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>

	</body>
</html>
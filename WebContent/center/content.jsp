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
		<title>Notice</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<link rel="stylesheet" href="../assets/css/board.css" />
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">		
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
	    font-family: 'Nanum Gothic', sans-serif;
	}

	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active3 > a{
		color: #fff;
	}

	</style>
	
	</head>

<%

		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String id=(String)session.getAttribute("id");
	
		BoardDAO bdao = new BoardDAO();
		
		BoardBean bBean = bdao.getBoard(num);
		bdao.updateReadCount(num);
		
		int DBnum = bBean.getNum(); 
		int DBReadcount = bBean.getReadcount(); 
		String DBName = bBean.getName();
		Timestamp DBDate = bBean.getDate(); 
		String DBSubject = bBean.getSubject(); 
		String DBFile = bBean.getFile();
		String DBContent = ""; 
	
		if(bBean.getContent() != null){
			DBContent = bBean.getContent().replace("\r\n", "<br/>");
		}
		
		CommentDAO cdao = new CommentDAO();
		int count = bdao.getBoardCount();

%>

<body>
<jsp:include page="../inc/top.jsp"/>
<div id="bo">
<center style="width">
<article>
<h1 align="center" style="FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Notice</h1><br>

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
	<td colspan="3" style="text-align: left;"><%=DBContent %></b></td>
</tr>
<tr>
	<td style="color: #019FE1;">File</td>
	<td colspan="3"><a href='download.jsp?fileName=<%=DBFile%>'><%=DBFile %></a></td>
</tr>

</table>

	<div align="center">
	<%

			
			if (id != null) {
	%>
		<form action="commentPro.jsp" method="post" style="padding-left: 10em;">
			<input type="hidden" name="ref" value="<%=bBean.getNum()%>" > 
			<input type="hidden" name="page" value="<%=pageNum%>" > 
			<input type="hidden" name="id" value="<%=id%>">
		<table class="comment" style="width: 100%; align: center; padding: 15px;">
			<tr>
				<td align="center" width="5%">댓글</td><br>
				<td>
				<textarea name="content" rows="3" cols="100" ></textarea>
				<input type="submit" name="register" value="댓글입력" class="btn"
				style="color: #FFF; background-color: #019FE1; height: 35px; border-radius: 10px;"> </td>
			</tr>
		</table>
		</form>
			<%
				}
			%>
			<div style="height: 20px;"></div>
			<%
			 if(count!=0){ 
				 
				List list = null;
				 list = cdao.getBoard(num);	
			%> 
				<table class="comment" style="width:800px; align:center; border: 1px solid gray;">
			<%
				for(int i=0; i<list.size();i++){
					CommentBean cBean = (CommentBean)list.get(i);
					
					// fboard 테이블에 있는 num값과 comment table에있는 ref 값이 같다면	
					if(bBean.getNum()==cBean.getRef()) {
			%>
						<tr style="border-bottom: 1px solid gray;">
							<td align="center" width="150" height="30" style="color:white; background-color: #019FE1;">
								<%=cBean.getId() %>
							</td> 
							<td style="border-left: 1px solid gray;">&nbsp;&nbsp;<%=cBean.getContent()%>
							</td>
							<td width="30">
						<%
							// 게시판 글 작성자 or 댓글 작성자만 삭제 가능
							if (DBName.equals(id)||cBean.getId().equals(id)) {
						%>		<img src="../images/del.PNG" class="del" 
									 onclick="location.href='commentDelete.jsp?commentNum=<%=cBean.getNum()%>&pageNum=<%=pageNum%>&num=<%=bBean.getNum()%>'">
						<%
							}
						%>
							</td>
							<td align="center" width="100" style="border-left: 1px solid gray; background-color:#019FE1; color: white;">
								<%=cBean.getDate() %>
							</td>
						</tr>
					
			<%		}
				}
			%>
				</table>
			<% 
				} 
			%>

<%
	if(id!=null){
%>
	<div id="table_search">
	<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'">
<%
	}
%>
	<input type="button" value="글목록" class="btn2" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
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
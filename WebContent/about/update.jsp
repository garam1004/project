<%@page import="board.ImgBoardBean"%>
<%@page import="board.ImgBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/imgboard.css" rel="stylesheet" type="text/css">
     <style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active2 > a{
		color: #fff;
	}
    </style>
 
<title>Edit</title>
</head>

<%
	String id = (String)session.getAttribute("id");

	if(id==null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	ImgBoardDAO imgboard = new ImgBoardDAO();
	
	ImgBoardBean iBean = imgboard.getBoard(num);
	
 	int DBnum = iBean.getNum(); 
	String DBName = iBean.getName();// 검색한 정보중.. 글작성자 이름 //검색한 정보중..  작성일
	String DBSubject = iBean.getSubject(); //검색한 정보중.. 글제목 
	String DBFile = iBean.getFile();
	String DBContent = ""; //글내용
	
	//글내용이 존재 한다면 // 내용 엔터처리 해서 얻기
	if(iBean.getContent() != null){
		DBContent = iBean.getContent().replace("\r\n", "<br/>");
	}
%>


<body>

 <jsp:include page="../inc/top.jsp" />
 <article id="bo">
 <center>
 <h2 style="text-align: center; margin-top: 100px; FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Edit</h2>

 <div class="container-fluid">
 	<div class="row">
 		<div class="col-sm-8 col-md-offset-2" id="img_div">
<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data" name="fr">
	<input type="hidden" name="num" value="<%=num%>">
<%-- 	<input type="hidden" name="filename" value="<%=DBFile%>"> --%>
	<table id="notice" style="width: 100%">
			<tr>
				<th class="col-20">Name</th>
				<td><input type="text" name="name" readonly="readonly" value="<%=DBName %>"></td>
			</tr>
			<tr>
				<th class="col-20">Password</th>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<th class="col-20">Subject</th>
				<td><input type="text" name="subject" value="<%=DBSubject %>"></td>
			</tr>
			<tr>
				<th class="col-20">Content</th>
				<td><textarea name="content" rows="13" cols="40"><%=DBContent %></textarea></td>
			</tr>	
			
			<tr>
			<th class="col-20">File</th>
			
			<td style="color:#000;" ><input type="file" name="filename" value=""><%=DBFile %></td>
			</tr>
			
		</table>

		<br><br>
<div id="table_search">
	<input type="submit" value="글수정" class="btn" >
	<input type="reset" value="다시쓰기" class="btn">
	<input type="button" value="글목록" class="btn" onclick="location.href='about.jsp?pageNum=<%=pageNum%>'">
</div>

</form>

</div>
</div>
</div>
</center>
</article>
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
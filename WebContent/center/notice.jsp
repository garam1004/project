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
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		
		<script type="text/javascript">
		function check(){
			sear = document.search.searchText.value
			location.href="notice.jsp?search="+sear;
		}
		
		</script>
	<style type="text/css">
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

String search = "";

if(request.getParameter("search")!=null)search=request.getParameter("search");

BoardDAO boardDAO = new BoardDAO();

int count = boardDAO.getBoardCount();

int pageSize = 10;
String num = request.getParameter("num");
String pageNum = request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize;

List<BoardBean> list=null;

if(count>0){
	list=boardDAO.getBoardList(startRow, pageSize, search);
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

%>	
<body>
<jsp:include page="../inc/top.jsp"/>
<div id="bo">
<center style="padding: 3em 0 10em 0;">
<article>
<h1 align="center" style="FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Notice</h1><br>
<table align="center" id="notice">
<tr><th class="tno" style="padding-left: 23px;">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread" style="padding-right: 23px;">Read</th></tr>

<%
	if(count>0){
		for(int i=0; i<list.size(); i++){
			BoardBean bean = list.get(i);
%>
	<tr onclick="location.href='content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
		<td style="padding-left: 23px;"><%=bean.getNum() %></td>
		<td class="left" style="text-align: left; padding-left: 30px;"><%=bean.getSubject()%></td>
		<td><%=bean.getName() %></td>
		<td><%=sdf.format(bean.getDate()) %></td>
		<td style="padding-right: 23px;"><%=bean.getReadcount() %></td>
	</tr>		
<% 			
		}
	}else{
%>
	<tr>
		<td colspan="5" align="center">게시판 글 없음</td>
	</tr>
<%		
	}

%>
</table>

<%
	String id=(String)session.getAttribute("id");
	if(id!=null){
%>
	<div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'">
	</div>
<%
	}
%>

<form action="" name="search">
<div id="table_search">
<input type="text" name="searchText" class="input_box">
<input type="button" value="검색" class="btn" onclick="check()">
</div>
</form>
<div class="clear"></div>
<br><br>
<div id="page_control">
<%
if(count>0){

	int pageCount = count/pageSize+(count%pageSize==0?0:1);
	int pageBlock=5;
	
	int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;

	int endPage=startPage+pageBlock-1; 

	if(endPage > pageCount){
		endPage=pageCount;
	}

	if(startPage>pageBlock){
	%> <a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
	<% 
	}
	
	for(int i=startPage;i<=endPage;i++){
	%><a href="notice.jsp?pageNum=<%=i %>">[<%=i %>]</a>
	<%
	}

	if(endPage<pageCount){
	%><a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
	<% 
	}
}
%>

</div>
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
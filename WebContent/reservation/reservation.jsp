<%@page import="board.rBoardBean"%>
<%@page import="board.rBoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE H0TML>


<html>

	<head>
		<title>Reservation</title>
		<meta charset="utf-8">
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<link rel="stylesheet" href="../assets/css/main.css" />
		<link rel="stylesheet" href="../assets/css/board.css" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

		<script type="text/javascript">
		function check(){
			sear = document.search.searchText.value
			location.href="reservation.jsp?search="+sear;
		}
		
		</script>
			<style type="text/css">
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

String search = "";

if(request.getParameter("search")!=null)search=request.getParameter("search");

rBoardDAO rbdao = new rBoardDAO();

int count = rbdao.getBoardCount();

int pageSize = 10;

String pageNum = request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize;

List<rBoardBean> list=null;

if(count>0){
	list=rbdao.getBoardList(startRow, pageSize, search);
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

%>	
<body>
<jsp:include page="../inc/top.jsp"/>
<div id="bo">
<center style="padding: 3em 0 10em 0;">
<article>
<h1 align="center" style="FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Reservation</h1><br>
<table align="center" id="notice">
<tr><th class="ttitle" style="padding-left: 23px; border-top-left-radius:5px;
border-bottom-left-radius:5px;">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread" style="padding-right: 23px;">Read</th></tr>

<%
	if(count>0){
		for(int i=0; i<list.size(); i++){
			rBoardBean rbBean = list.get(i);
%>
	<tr onclick="location.href='content.jsp?num=<%=rbBean.getNum()%>&pageNum=<%=pageNum%>'">
		<td class="left" style="text-align: left; padding-left: 23px;"">
			<%
				int wid=0; 

				if(rbBean.getRe_lev()>0){
					wid=rbBean.getRe_lev()*10;
			%>
			<img src="../images/null.gif" width="<%=wid%>" height="15">
			<i class="material-icons" style="color:#019FE1;">subdirectory_arrow_right</i>
			<%
				}
			%>
			<%=rbBean.getSubject()%>
		</td>
		<td><%=rbBean.getName() %></td>
		<td><%=sdf.format(rbBean.getDate()) %></td>
		<td style="padding-right: 23px;"><%=rbBean.getReadcount() %></td>
	</tr>		
<% 			
		}
	}else{
%>
	<tr>
		<td colspan="4" align="center">게시판 글 없음</td>
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
	%> <a href="reservation.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
	<% 
	}
	
	for(int i=startPage;i<=endPage;i++){
	%><a href="reservation.jsp?pageNum=<%=i %>">[<%=i %>]</a>
	<%
	}

	if(endPage<pageCount){
	%><a href="reservation.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
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
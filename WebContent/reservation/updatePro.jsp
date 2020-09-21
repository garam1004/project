<%@page import="board.rBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>updatePro.jsp</h1>
<%

request.setCharacterEncoding("UTF-8");

String pageNum=request.getParameter("pageNum");

%>
<jsp:useBean id="rbBean" class="board.rBoardBean"/>
<jsp:setProperty property="*" name="rbBean"/>
<%

rBoardDAO rbdao = new rBoardDAO();

int check=rbdao.updateBoard(rbBean);

if(check==1){
	%>
	<script type="text/javascript">
		alert("수정성공");
		location.href="reservation.jsp?pageNum=<%=pageNum%>";
	</script>
	<% 
}else{
%>
	<script type="text/javascript">
		alert("비밀번호틀림");
		history.back();
	</script>
<% 
}
%>
</body>
</html>
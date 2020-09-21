<%@page import="board.ImgBoardDAO"%>
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
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd = request.getParameter("passwd");
	
	ImgBoardDAO imgdao = new ImgBoardDAO();
	
	int check = imgdao.deleteBoard(num, passwd);
	if(check==1){
%>	
	<script type="text/javascript">
		alert("삭제되었습니다.");
		location.href="about.jsp?pageNum=<%=pageNum%>";
	</script>
<% 		
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다.");
		history.back();
	</script>
<%		
	}
%>

</body>
</html>
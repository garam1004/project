<%@page import="board.ImgBoardDAO"%>
<%@page import="board.ImgBoardBean"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");

	String id = (String) session.getAttribute("id");

	if (id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	ServletContext ctx = getServletContext();
	
	String realPath = ctx.getRealPath("/upload");
	
	int size = 5*1024*1024;
	
	MultipartRequest multi = 
			new MultipartRequest(request,realPath,size,"UTF-8",new DefaultFileRenamePolicy());
	
	ImgBoardBean iBean = new ImgBoardBean();
	
	iBean.setContent(multi.getParameter("content"));
	iBean.setSubject(multi.getParameter("subject"));
	iBean.setNum(Integer.parseInt(multi.getParameter("num")));
	iBean.setPasswd(multi.getParameter("passwd"));
	iBean.setFile(multi.getFilesystemName("filename"));

	ImgBoardDAO imgdao = new ImgBoardDAO();
	int check = imgdao.updateBoard(iBean);  
  
	if(check == 1){
	%>
		<script type="text/javascript">
			alert("수정되었습니다.");
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
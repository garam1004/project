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
	
	BoardBean bBean = new BoardBean();
	
	bBean.setContent(multi.getParameter("content"));
	bBean.setSubject(multi.getParameter("subject"));
	bBean.setNum(Integer.parseInt(multi.getParameter("num")));
	bBean.setPasswd(multi.getParameter("passwd"));
	bBean.setFile(multi.getFilesystemName("filename"));
	bBean.setOrgfilename(multi.getOriginalFileName("filename"));  
	
	BoardDAO bdao = new BoardDAO();
	int check = bdao.updateBoard(bBean);  
  
	if(check == 1){
	%>
		<script type="text/javascript">
			alert("수정되었습니다.");
			location.href="notice.jsp?pageNum=<%=pageNum%>";
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
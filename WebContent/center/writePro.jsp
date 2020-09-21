<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	ServletContext ctx = request.getServletContext();
	String realPath = ctx.getRealPath("upload");
	int max = 10*1024*1024;
	String name="";
	String subject="";
	String content="";
	String filename="";
	String orgfilename="";

	
	try{
		MultipartRequest multi=
				new MultipartRequest(request,realPath,max,"UTF-8",new DefaultFileRenamePolicy());
		Enumeration e = multi.getFileNames();
		String file = (String)e.nextElement();

		filename = multi.getFilesystemName(file);
		
		BoardBean bBean = new BoardBean();
		

		bBean.setName(multi.getParameter("name"));
		bBean.setSubject(multi.getParameter("subject"));
		bBean.setContent(multi.getParameter("content"));
		bBean.setPasswd(multi.getParameter("passwd"));
		bBean.setDate(new Timestamp(System.currentTimeMillis()));
		bBean.setIp(request.getRemoteAddr());
		bBean.setFile(multi.getFilesystemName("filename"));
		bBean.setOrgfilename(multi.getOriginalFileName("filename"));
		BoardDAO bdao = new BoardDAO();
		bdao.insertBoard(bBean);
		
	
	}catch(Exception e){
		System.out.println("insert실패 : "+e);
	}
	
	ParameterBlock pb = new ParameterBlock();
	pb.add(realPath+"/"+filename);

	response.sendRedirect("notice.jsp");
	

%>
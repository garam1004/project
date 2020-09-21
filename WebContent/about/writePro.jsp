<%@page import="board.ImgBoardDAO"%>
<%@page import="board.ImgBoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>




    <%
    ServletContext context = request.getServletContext();
    String imagePath = context.getRealPath("upload");
    int size = 5*1024*1024;	//1mb
    String filename="";
    
    try{
    	MultipartRequest multi = 
    			new MultipartRequest(request,imagePath,size,"UTF-8",new DefaultFileRenamePolicy());
    	
    	Enumeration files = multi.getFileNames();
    	String file = (String)files.nextElement();
    	filename = multi.getFilesystemName(file);
    	
    	
    	ImgBoardBean iBean = new ImgBoardBean();
    	
    	iBean.setName(multi.getParameter("name"));
    	iBean.setContent(multi.getParameter("content"));
    	iBean.setSubject(multi.getParameter("subject"));
		iBean.setPasswd(multi.getParameter("passwd"));
    	iBean.setDate(new Timestamp(System.currentTimeMillis()));
    	iBean.setIp(request.getRemoteAddr());
    	iBean.setFile(filename);
        
        ImgBoardDAO imgdao = new ImgBoardDAO();
        imgdao.insertBoard(iBean);
    	
    }catch(Exception e){
    	e.printStackTrace();
    }
   
    ParameterBlock pb = new ParameterBlock();
    pb.add(imagePath+"/"+filename);
    RenderedOp rOp = JAI.create("fileload",pb);
    
    response.sendRedirect("about.jsp");
    
    
    %>
    
    <html>
    <body>
	</body>
    </html> 
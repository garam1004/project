<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>

 <%
 		request.setCharacterEncoding("UTF-8");
		//다운로드할 파일명을 가져옴
		String fileName = request.getParameter("fileName");

		//파일이 있는 절대경로를 갖옴
		String savePath = "upload";
		ServletContext ctx = request.getSession().getServletContext();
		String folder = ctx.getRealPath(savePath);
		//파일의 절대경로를 만듬
		String filePath = folder + "\\" + fileName;
		
		byte b[] = new byte[4096];	
		File file = new File(filePath);
		
		FileInputStream fi = new FileInputStream(file);
		String mimeType=request.getSession().getServletContext().getMimeType(filePath);
		
		if(mimeType==null)
			mimeType="application/octet-stream";
		
			response.setContentType(mimeType);
			
			String userAgent = request.getHeader("User-Agent");
			boolean ie = (userAgent.indexOf("MSIE")>-1) || (userAgent.indexOf("Trident")>-1);
			String encoding = null;
			
			if(ie){
				encoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
			}else{
				encoding = new String(fileName.getBytes("utf-8"), "8859_1");
			}
			
			response.setHeader("Content-Disposition", "attachment; filename= "+encoding);
			
			ServletOutputStream out2 = response.getOutputStream();
			int numRead;
			
			while((numRead=fi.read(b,0,b.length)) != -1){
				out2.write(b,0,numRead);	
			}
			
			out2.flush();
			out2.close();
			fi.close();
		
			out.clear();
			out = pageContext.pushBody();
			
%>
		
		
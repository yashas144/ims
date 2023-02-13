<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>delete faculty</title>
</head>
<body>
<%  if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
	{
		String id=request.getParameter("id");
		MakeConnection conn=new MakeConnection();
		Connection con= conn.connect();
		DBQuerry newQuerry=new DBQuerry();	
		PreparedStatement pstmt  = con.prepareStatement(newQuerry.DeleteFaculty);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt  = con.prepareStatement(newQuerry.DeleteLeave);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		con.close();
	}
	else
		response.sendRedirect("login.html");
%>
<%@ include file="deletefaculty.html" %>
<center style="color:red">Faculty Deleted</center>
</body>
</html>

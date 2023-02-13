<%@ page import="java.sql.*" errorPage="error.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>login successful</title>
</head>
<body>
<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
		session.setAttribute("session","false");
		response.sendRedirect("login.html");
	
}
else
	response.sendRedirect("login.html");
%>
</body>
</html>
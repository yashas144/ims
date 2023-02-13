<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>add room</title>
	</HEAD>
<BODY>
<% 
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect(); 
	String room=request.getParameter("room");
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.DeleteRoom);
	pstmt.setString(1,room);
	pstmt.executeUpdate();
	con.close();
}
else
	response.sendRedirect("login.html");
%>
<%@ include file="deleteroom.html" %>
<center style="color:red">Room Deleted<BR>Delete another room....</center>
</BODY>
</HTML>
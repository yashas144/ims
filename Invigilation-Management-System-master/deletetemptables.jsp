<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>deleteroster</title>
</head>
<body>
<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	int i;
	Integer shift=(Integer)session.getAttribute("shifts");
	/*int shift=Integer.parseInt("2");*/
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect();
	for(i=0;i<shift;i++){
		String tablename= "Shift"+(i+1);
		String qry="DROP TABLE " + tablename;
		PreparedStatement pstmt  = con.prepareStatement(qry);
		pstmt.executeUpdate();
	}
	con.close();
	response.sendRedirect("downloadroster.html");
}
else
	response.sendRedirect("login.html");
%>
</body>
</html>
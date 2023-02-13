<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>login page</title>
</head>
<body>
<%
	int flag=0;
	String id=request.getParameter("id");
	String pass=request.getParameter("password");
%>
<%
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect(); 
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.AdminLogin);
	pstmt.setString(1,id);	
	pstmt.setString(2,pass);	
	ResultSet rs=pstmt.executeQuery(); 
	while(rs.next())
	{
		if(id.equals(rs.getString(1)) && pass.equals(rs.getString(2)))
		{
		flag=1;
		session.setAttribute("session","true");
%>
		<%@ include file="insertdetails.html" %>
		
<%
		}
	}
	if(flag==0)
	{
%>
		<%@ include file="login.html" %>
		<H4>Invalid user id or password</H4>
<%
	}
	con.close();
%>

</body>
</html>
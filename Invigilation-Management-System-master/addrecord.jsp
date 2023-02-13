<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>add faculty</title>
	</HEAD>
<BODY>
<!-- The following code is to take data of faculty from the form and insert it in to database-->
<% 
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	int i=1;
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect();	
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.GetFacultyColumns);	
	ResultSet rs=pstmt.executeQuery();
	PreparedStatement pstmt2  = con.prepareStatement(newQuerry.InsertFacultyDetails);
	while(rs.next())
	{
		if((rs.getString(2)).equals("active")==false)
		{
			String param=request.getParameter(rs.getString(2));
			if((rs.getString(3)).equals("TEXT"))
			{
				pstmt2.setString(i, param);
			}
			else
			{
				int par=Integer.parseInt(param);
				pstmt2.setInt(i, par);
			}
		i++;
		}
	}
	pstmt2.executeUpdate();
	con.close();
}
else
	response.sendRedirect("login.html");
%>
<%@ include file="addfaculty.jsp" %>
<center style="color:red">Record Added Successfully<BR>Submit another reponse....</center>

</BODY>
</HTML>
<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<%@ page import="java.lang.Math.*" %>

<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>apply for leave</title>
	</HEAD>
<BODY>
<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	final int count_rank;
	int i;
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect(); 
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.CountDistinctRank);
	ResultSet rs=pstmt.executeQuery(); 
	count_rank=Integer.parseInt(rs.getString(1));
    pstmt  = con.prepareStatement(newQuerry.DistinctRank);
	rs=pstmt.executeQuery();
	String ranks[]=new String[count_rank];
	for(i=0;i<count_rank;i++)
	{
		rs.next();
		ranks[i]=rs.getString(1);
	}
	
	int countprofessormale,countprofessorfemale,countassociatemale,countassistantmale,countassociatefemale,countassistantfemale,totalrooms;
	int tempprofessormale=0,tempprofessorfemale=0,tempassociatemale=0,tempassistantmale=0,tempassociatefemale=0,tempassistantfemale=0,num;
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	countprofessormale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	countprofessorfemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	countassociatemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	countassociatefemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	countassistantmale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountDifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	countassistantfemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempprofessormale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempprofessorfemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempassociatemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempassociatefemale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"male");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempassistantmale=Integer.parseInt(rs.getString(1));
	
	pstmt  = con.prepareStatement(newQuerry.CountLeave);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"female");
	rs=pstmt.executeQuery();
	if(rs.next()==true)
		tempassistantfemale=Integer.parseInt(rs.getString(1));
	
	countprofessormale-=tempprofessormale;
	countprofessorfemale-=tempprofessorfemale;
	countassociatefemale-=tempassociatefemale;
	countassociatemale-=tempassociatemale;
	countassistantfemale-=tempassistantfemale;
	countassistantmale-=tempassistantmale;
	
	pstmt  = con.prepareStatement(newQuerry.CountRooms);
	rs=pstmt.executeQuery();
	totalrooms=Integer.parseInt(rs.getString(1));
	
	num=(int)(Math.ceil(totalrooms/2));
%>

<% 
	String id=request.getParameter("id");
	String reason=request.getParameter("reason");
	String rank,sex;
	pstmt  = con.prepareStatement(newQuerry.SelectRankSex);
	pstmt.setString(1,id);
	rs=pstmt.executeQuery();
	rank=rs.getString(1);
	sex=rs.getString(2);
	if(rank .equals(ranks[0])==true && sex .equals("male") && (countprofessormale-1)<=num ||
	rank .equals(ranks[0])==true && sex .equals("female") && (countprofessorfemale-1)<=num ||
	rank .equals(ranks[1])==true && sex .equals("male") && (countassociatemale-1)<=num ||
	rank .equals(ranks[1])==true && sex .equals("female") && (countassociatefemale-1)<=num ||
	rank .equals(ranks[2])==true && sex .equals("male") && (countassistantmale-1)<=(totalrooms+1) ||
	rank .equals(ranks[2])==true && sex .equals("female") && (countassistantfemale-1)<=(totalrooms+1) )
	{
%>
<%@ include file="leaveApplication.html" %>
SORRY...Your leave is not accepted....
<%
	}
	else
	{
		pstmt  = con.prepareStatement(newQuerry.ApplyForLeave);
		pstmt.setString(1,id);
		pstmt.setString(2,sex);
		pstmt.setString(3,rank);
		pstmt.setString(4,reason);
		pstmt.executeUpdate();
%>
<%@ include file="leaveApplication.html" %>
<h4><center>Leave Accepted</center></h4>
<%
	}
	con.close();
}
else
	response.sendRedirect("login.html");
%>
</BODY>
</HTML>
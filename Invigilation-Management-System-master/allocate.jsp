<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<%@ page import="java.util.Random" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>roster</title>
</head>
<body>

<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect();
	int i=0,j=0,k=0;
	int shift=Integer.parseInt(request.getParameter("shifts"));
	int day=Integer.parseInt(request.getParameter("days"));
	String tablename="AllocationShift"+shift+"Day"+day;
	String colname="shift"+shift+"day"+day;
	String qry="CREATE TABLE "+tablename+" ('id'	TEXT NOT NULL,'name'	TEXT NOT NULL,'sex'	TEXT NOT NULL,PRIMARY KEY('id'))";
	ResultSet rs;
	PreparedStatement pstmt  = con.prepareStatement(qry);
		pstmt.executeUpdate();
	qry="SELECT id,name,sex FROM Roster WHERE "+colname+"=?";
	PreparedStatement pstmt2  = con.prepareStatement(qry);
	pstmt2.setString(1,"P");
		ResultSet rs2=pstmt2.executeQuery();
	qry="INSERT INTO "+tablename+"(id,name,sex) values(?,?,?)";
		while(rs2.next()){
			pstmt  = con.prepareStatement(qry);
			String temp=rs2.getString(1);
			String temp2=rs2.getString(2);
			String temp3=rs2.getString(3);
			pstmt.setString(1,temp);
			pstmt.setString(2,temp2);
			pstmt.setString(3,temp3);
			pstmt.executeUpdate();
		}
		qry="ALTER TABLE " + tablename + " ADD COLUMN RoomNo TEXT";
			pstmt  = con.prepareStatement(qry);
			pstmt.executeUpdate();
%>

<%
	ResultSet rooms;
	int totalrooms;
	DBQuerry newQuerry=new DBQuerry();
	pstmt  = con.prepareStatement(newQuerry.SelectRooms);
	rooms=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.CountRooms);
	rs=pstmt.executeQuery();
	totalrooms=Integer.parseInt(rs.getString(1));
	
	Random rand = new Random();
	int random = rand.nextInt(totalrooms)+1;
	for(i=1;i<=random;i++){
		rooms.next();
	}
	qry="SELECT id,sex FROM "+tablename;
	pstmt  = con.prepareStatement(qry);
	rs=pstmt.executeQuery();
	while(rs.next()){
		if((rs.getString(2)).equals("male")==true){
			qry="update "+tablename+" set RoomNo= ? where id= ?";
			pstmt  = con.prepareStatement(qry);
			pstmt.setString(1,(rooms.getString(1)));
			pstmt.setString(2,(rs.getString(1)));
			pstmt.executeUpdate();
			if(rooms.next()==false){
				pstmt  = con.prepareStatement(newQuerry.SelectRooms);
				rooms=pstmt.executeQuery();
				rooms.next();
			}
		}
	}
	
	qry="SELECT id,sex FROM "+tablename;
	pstmt  = con.prepareStatement(qry);
	rs=pstmt.executeQuery();
	while(rs.next()){
		if((rs.getString(2)).equals("female")==true){
			qry="update "+tablename+" set RoomNo= ? where id= ?";
			pstmt  = con.prepareStatement(qry);
			pstmt.setString(1,(rooms.getString(1)));
			pstmt.setString(2,(rs.getString(1)));
			pstmt.executeUpdate();
			if(rooms.next()==false){
				pstmt  = con.prepareStatement(newQuerry.SelectRooms);
				rooms=pstmt.executeQuery();
				rooms.next();
			}
		}
	}
	con.close();
}
else
	response.sendRedirect("login.html");
%>
<%@ include file="allocate.html" %>
<center style="color:red">Duty allocated successfully</center>
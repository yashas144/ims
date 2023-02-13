<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
  <!-- <link rel="stylesheet" href="css\bootstrap.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
<link href="https://fonts.googleapis.com/css?family=Krona+One" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>deleteroster</title>
<link rel="stylesheet" href="http://localhost:8080/inviligate/style2.css">
<link rel="stylesheet" href="http://localhost:8080/inviligate/style3.css">

<nav class="navbar navbar-dark bg-dark" style = "">
  <a class="navbar-brand" href="http://www.abes.ac.in/">
    <img src="http://localhost:8080/inviligate/ABES ICON.jpg" width="60" height="30" class="d-inline-block align-top " alt="">
    <p style = "display:inline"class="p">ABES Engineering College</p>
  </a>
</nav>

</head>
<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="insertdetails.html">Home</a>
  <a href="logout.jsp">LogOut</a>
</div>

<div>
  <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>
</div>

<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("card").style.marginLeft = "250px";
    document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("card").style.marginLeft= "auto";
    document.body.style.backgroundColor = "white";
}
</script>

<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect();
	DBQuerry newQuerry=new DBQuerry();
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.DeleteRoster);
	pstmt.executeUpdate();
	con.close();
}
else
	response.sendRedirect("login.html");
%>
<h2>Roster table deleted</h2>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</html>
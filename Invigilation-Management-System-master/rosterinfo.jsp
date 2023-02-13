<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<HTML>
	<HEAD>
		<title>roster info.</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<!-- <link rel="stylesheet" href="css\bootstrap.css"> -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
		<link href="https://fonts.googleapis.com/css?family=Krona+One" rel="stylesheet">
		<link rel="stylesheet" href="http://localhost:8080/inviligate/style2.css">
		<link rel="stylesheet" href="http://localhost:8080/inviligate/style3.css">
		<link rel="stylesheet" href="http://localhost:8080/inviligate/drawerStyle.css">
		
		<nav class="navbar navbar-dark bg-dark" style = "">
		<a class="navbar-brand" href="http://www.abes.ac.in/">
		<img src="http://localhost:8080/inviligate/ABES ICON.jpg" width="60" height="30" class="d-inline-block align-top " alt="">
		<p style = "display:inline"class="p">ABES Engineering College</p>
		</a>
		</nav>

	</HEAD>
	
	
<BODY>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="insertdetails.html">Home</a>
  <a href="addfaculty.jsp">Add Faculty</a>
  <a href="deletefaculty.html">Delete Faculty</a>
  <a href="addroom.html">Add Room</a>
  <a href="deleteroom.html">Delete Room</a>
  <a href="leaveApplication.html">Application Leave</a>
  <p style="background-color:green">Generate Roaster</p>
  <a href="deleterostertables.jsp">Delete Roaster</a>
  <a href="allocate.html">Allocate Duties</a>
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
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.DistinctRank);	
	ResultSet rs=pstmt.executeQuery();
%>

	<div class = "container">
	<FORM  NAME="login" class="login-form col-md-6 offset-md-3" action="http://localhost:8080/inviligate/makeroster.jsp">
		<h1 class="hero" style="text-align:center">Enter Details</h1>
		<div class= "form-group">	
			<label for="room"><BR>No. of days of exam :</label>
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text" id="validationTooltipUsernamePrepend">@</span>
				</div>
				<input type="number" class="form-control" name="days" id="validationTooltipUsername" placeholder="No. of days" aria-describedby="validationTooltipUsernamePrepend" required>
				<div class="invalid-tooltip">
					Please choose valid entry
				</div>
			</div>
		</div>
		
		<div class= "form-group">	
			<label for="room">No. of shifts in a day :</label>
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text" id="validationTooltipUsernamePrepend">@</span>
				</div>
				<input type="number" class="form-control" name="shifts" id="validationTooltipUsername" placeholder="No. of shifts" aria-describedby="validationTooltipUsernamePrepend" required>
				<div class="invalid-tooltip">
					Please choose valid entry
				</div>
			</div>
		</div>
		<%
			while(rs.next())
			{
		%>
			<div class= "form-group">	
				<label for="room">No. of duties assigned to <%out.print(rs.getString(1) + ":");%></label>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="validationTooltipUsernamePrepend">@</span>
					</div>
					<input type="number" class="form-control" NAME=<%=rs.getString(1)%> id="validationTooltipUsername" placeholder="No. of duties" aria-describedby="validationTooltipUsernamePrepend" required>
					<div class="invalid-tooltip">
						Please choose valid entry
					</div>
				</div>
			</div>			
		<%	
			}
			con.close();
		%>
		<button class = "btn btn-primary btn-block" TYPE="SUBMIT"  >Submit</button>
		<button class = "btn btn-primary btn-block"  TYPE="RESET" VALUE="RESET" >Reset</button>
	</FORM>	
	</div>

<%
}
else
	response.sendRedirect("login.html");
%>
</BODY>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>	
</HTML>
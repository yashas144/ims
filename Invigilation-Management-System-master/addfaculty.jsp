<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="querry.*" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <!-- <link rel="stylesheet" href="css\bootstrap.css"> -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
  <link href="https://fonts.googleapis.com/css?family=Krona+One" rel="stylesheet">
  <link rel="stylesheet" href="http://localhost:8080/inviligate/style2.css">
  <link rel="stylesheet" href="http://localhost:8080/inviligate/style3.css">
  <link rel="stylesheet" href="http://localhost:8080/inviligate/drawerStyle.css">

  <title>Add faculty</title>

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
	  <p style="background-color:green">Add Faculty</p>
	  <a href="deletefaculty.html">Delete Faculty</a>
	  <a href="addroom.html">Add Room</a>
	  <a href="deleteroom.html">Delete Room</a>
	  <a href="leaveApplication.html">Application Leave</a>
	  <a href="rosterinfo.jsp">Generate Roaster</a>
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
		PreparedStatement pstmt  = con.prepareStatement(newQuerry.GetFacultyColumns);	
		ResultSet rs=pstmt.executeQuery();
	%>
	<div class = "container">
		<FORM  NAME="login" class="login-form col-md-6 offset-md-3" action="http://localhost:8080/inviligate/addrecord.jsp">
			<h1 class="hero" style="text-align:center">Enter Faculty Details</h1>

				<%
					while(rs.next())
					{
				%>
					<div class= "form-group">
				<%
						if((rs.getString(2)).equals("rank")==true)
						{
				%>		
						<div>
							<label for="room"><%out.print(rs.getString(2) + ":");%></label>
						</div>
							<div class="form-check form-check-inline mr-3">
							</div>
							<div class="form-check form-check-inline mr-3">
							  <input class="form-check-input" type="radio" name=<%=rs.getString(2)%> id="inlineRadio2" value="professor" checked>
							  <label class="form-check-label" for="inlineRadio2">Professor</label>
							</div>
							<div class="form-check form-check-inline mr-3">
							  <input class="form-check-input" type="radio" name=<%=rs.getString(2)%> id="inlineRadio2" value="associate professor">
							  <label class="form-check-label" for="inlineRadio2">Associate Professor</label>
							</div>
							<div class="form-check form-check-inline mr-2">
								<input class="form-check-input " type="radio" name=<%=rs.getString(2)%> id="inlineRadio1" value="assistant professor">
								<label class="form-check-label" for="inlineRadio1">Assistant Professor</label>
							</div>
				
				<%
						}
						else if((rs.getString(2)).equals("sex")==true)
						{
				%>
						<div>
							<label for="room"><%out.print(rs.getString(2) + ":");%></label>
						</div>
							<div class="form-check form-check-inline mr-5">
							</div>
							<div class="form-check form-check-inline mr-5">
								<input class="form-check-input " type="radio" name=<%=rs.getString(2)%> id="inlineRadio1" value="male" checked>
								<label class="form-check-label" for="inlineRadio1">male</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name=<%=rs.getString(2)%> id="inlineRadio2" value="female">
							  <label class="form-check-label" for="inlineRadio2">female</label>
							</div>
				
				<%
						}
						else if((rs.getString(2)).equals("active")==false)
						{
				%>
							<label for="room"><%out.print(rs.getString(2) + ":");%></label>
						<%
							if((rs.getString(3)).equals("TEXT"))
							{
						%>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text" id="validationTooltipUsernamePrepend">@</span>
								</div>
								<input type="text" class="form-control" name=<%=rs.getString(2)%> id="validationTooltipUsername" placeholder=<%=rs.getString(2)%> aria-describedby="validationTooltipUsernamePrepend" required>
								<div class="invalid-tooltip">
									Please choose valid Entry.
								</div>
							</div>
						<%
							}
							else
							{
						%>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text" id="validationTooltipUsernamePrepend">@</span>
								</div>
								<input type="number" class="form-control" name=<%=rs.getString(2)%> id="validationTooltipUsername" placeholder=<%=rs.getString(2)%> aria-describedby="validationTooltipUsernamePrepend" required>
								<div class="invalid-tooltip">
									Please choose valid Entry.
								</div>
							</div>
						<%
							}
						%>
					</div>
				<%	
						}
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
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- The follwing code is making a dyamic form and taking all information from user about a faculty in the form and then forwards the details to
	addrecord.jsp page-->
<!--<% 
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect(); 		
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.GetFacultyColumns);	
	ResultSet rs=pstmt.executeQuery();
%>
	<FORM  NAME="login" action="http://localhost:8080/inviligate/addrecord.jsp">
	<TABLE BORDER="2" WIDTH="50%" ALIGN="CENTER">
	<TR>
	<TD>
		<TABLE CELLSPACING="4">
			<TR>
			<TD colspan="2" ALIGN="CENTER"><H4><U>ENTER DETAILS</U></H4></TD>
			</TR>
			<%
				while(rs.next())
				{
					if((rs.getString(2)).equals("active")==false)
					{
			%>
				<TR>
					<TD><%out.print(rs.getString(2) + ":");%></TD>
					<%
						if((rs.getString(3)).equals("TEXT"))
						{
					%>
							<TD><INPUT TYPE="text" NAME=<%=rs.getString(2)%>>
					<%
						}
						else
						{
					%>
							<TD><INPUT TYPE="number" NAME=<%=rs.getString(2)%>>
					<%
						}
					%>
				</TR>
			<%	
					}
				}
				con.close();
			%>
			<TR>	
				<TD WIDTH="30%" ALIGN="CENTER" COLSPAN="2">
					<INPUT TYPE="SUBMIT" VALUE="INSERT" NAME="insert"/>
					<INPUT TYPE="RESET" VALUE="RESET"/>
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
	</TABLE>
	</FORM>	
<%
}
else
	response.sendRedirect("login.html");
%>-->
	</BODY>
</HTML>
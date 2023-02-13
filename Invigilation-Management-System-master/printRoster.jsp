<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="java.util.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<%@ page import="java.io.*" %>

<HTML>
	<HEAD>
		<meta charset="UTF-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1.0">
		  <meta http-equiv="X-UA-Compatible" content="ie=edge">
		  <!-- <link rel="stylesheet" href="css\bootstrap.css"> -->
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
		  <link href="https://fonts.googleapis.com/css?family=Krona+One" rel="stylesheet">
		  <link rel="stylesheet" href="http://localhost:8080/inviligate/style2.css">
		  <link rel="stylesheet" href="http://localhost:8080/inviligate/style3.css">
		  <link rel="stylesheet" href="http://localhost:8080/inviligate/drawerStyle.css">

		  <title>download</title>

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
	
	<H1>
	Roster file downloaded<BR/>
	</H1>
<% 
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	int i;
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect(); 
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.RosterData);	
	ResultSet rs=pstmt.executeQuery();
	FileOutputStream fileOut = new FileOutputStream("c:\\excelFile.xls");
  try{		
	HSSFWorkbook wb=new HSSFWorkbook();
	HSSFSheet sheet=wb.createSheet("Excel Sheet1");
	HSSFRow rowheader=sheet.createRow(0);
	int numCols = rs.getMetaData().getColumnCount();
	String colnames[]=new String[numCols+1];
	for( i=1;i<=numCols;i++)
		{
		 String colName=rs.getMetaData().getColumnName(i);
		 colnames[i]=colName;
		 rowheader.createCell(i).setCellValue(colName);
		}
	int index=1;
	while(rs.next())
	{
		HSSFRow row=sheet.createRow(index);
			for( i=1;i<=numCols;i++)
				row.createCell(i).setCellValue(rs.getString(colnames[i]));
		index++;
	}
    wb.write(fileOut);
%>

<%    
    }
	catch(Exception ex){
		ex.printStackTrace();
		out.print(ex);
		}
	finally{
	fileOut.close();
	rs.close();
    con.close();
	//response.sendRedirect("login.html");
	}
}
else
	response.sendRedirect("login.html");
    
%>
	</BODY>
</HTML>
	
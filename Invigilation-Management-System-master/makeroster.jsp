<%@ page import="java.sql.*" errorPage="error.jsp"%>
<%@ page import="querry.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Math.*" %>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<!-- <link rel="stylesheet" href="css\bootstrap.css"> -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
	<link href="https://fonts.googleapis.com/css?family=Krona+One" rel="stylesheet">
	<link rel="stylesheet" href="http://localhost:8080/inviligate/style2.css">
	
	
<title>roster</title>
</head>
<body>
<form>
<div class="modal-body">
	<div>
		<span>Generating roster table........</span>
	</div>
</div>
</form>


<%
if(session.getAttribute("session")!=null && session.getAttribute("session") .equals("true")==true)
{
	MakeConnection conn=new MakeConnection();
	Connection con= conn.connect();
	int i=0,j=0,k=0;
	int shifts=Integer.parseInt(request.getParameter("shifts"));
	int days=Integer.parseInt(request.getParameter("days"));
	final int count_rank;
	DBQuerry newQuerry=new DBQuerry();	
	PreparedStatement pstmt  = con.prepareStatement(newQuerry.CountDistinctRank);
	ResultSet rs=pstmt.executeQuery(); 
	count_rank=Integer.parseInt(rs.getString(1));
    pstmt  = con.prepareStatement(newQuerry.DistinctRank);
	rs=pstmt.executeQuery();
	String ranks[]=new String[count_rank];
	Integer duties[]=new Integer[count_rank];
	Integer duties2[]=new Integer[count_rank];
    Enumeration parameters = request.getParameterNames();
    while(parameters.hasMoreElements()){
        String parameterName = (String)parameters.nextElement();
		if(parameterName.equals("days")==false && parameterName.equals("shifts")==false && parameterName.equals("submit")==false){
			duties2[i] = duties[i] = Integer.parseInt(request.getParameter(parameterName)); 
			i++;
		}
	}   
	for(i=0;i<count_rank;i++)
	{
		rs.next();
		ranks[i]=rs.getString(1);
	}
	
%>
	
<%
	for(i=0;i<shifts;i++){
		String tablename= "Shift"+(i+1);
		String qry="CREATE TABLE " + tablename + " ('RoomNo'	TEXT NOT NULL,PRIMARY KEY('RoomNo'))";
		pstmt  = con.prepareStatement(qry);
		pstmt.executeUpdate();
		qry="INSERT INTO " + tablename + " values(?)";
	}
	for(i=0;i<shifts;i++){
		PreparedStatement pstmt2  = con.prepareStatement(newQuerry.SelectRooms);
		ResultSet rs2=pstmt2.executeQuery(); 
		String tablename= "Shift"+(i+1);
		String qry="INSERT INTO " + tablename + " VALUES(?)";
		while(rs2.next()){
			pstmt  = con.prepareStatement(qry);
			String temp=rs2.getString(1);
			pstmt.setString(1,temp);
			pstmt.executeUpdate();
		}
	}
	for(i=0;i<shifts;i++){
		String tablename= "Shift"+(i+1);
		for(j=1;j<=days;j++){
			String day="day"+j;
			String qry="ALTER TABLE " + tablename + " ADD COLUMN " + day + " TEXT";
			pstmt  = con.prepareStatement(qry);
			pstmt.executeUpdate();
		}
	}
	
	pstmt  = con.prepareStatement(newQuerry.CreateRoster);
		pstmt.executeUpdate();
		
	for(i=1;i<=days;i++){
		String tablename= "Shift"+(i+1);
		for(j=1;j<=shifts;j++){
			String day="shift"+j+"day"+i;
			String temp="A";
			String qry="ALTER TABLE Roster ADD COLUMN " + day + " TEXT DEFAULT "+temp;
			pstmt  = con.prepareStatement(qry);
			pstmt.executeUpdate();
		}
	}
		PreparedStatement pstmt2  = con.prepareStatement(newQuerry.SelectIdNameGender);
		ResultSet rs2=pstmt2.executeQuery(); 
		while(rs2.next()){
			pstmt  = con.prepareStatement(newQuerry.RosterInsert);
			String temp=rs2.getString(1);
			String temp2=rs2.getString(2);
			String temp3=rs2.getString(3);
			pstmt.setString(1,temp);
			pstmt.setString(2,temp2);
			pstmt.setString(3,temp3);
			pstmt.executeUpdate();
		}
%>

<%
	ResultSet professormale,professorfemale,associatemale,assistantmale,associatefemale,assistantfemale,rooms;
	int countprofessormale,countprofessorfemale,countassociatemale,countassistantmale,countassociatefemale,countassistantfemale,totalrooms;
	int tempprofessormale=0,tempprofessorfemale=0,tempassociatemale=0,tempassistantmale=0,tempassociatefemale=0,tempassistantfemale=0;
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"male");
	professormale=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[0]);
	pstmt.setString(2,"female");
	professorfemale=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"male");
	associatemale=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[1]);
	pstmt.setString(2,"female");
	associatefemale=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"male");
	assistantmale=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"female");
	assistantfemale=pstmt.executeQuery();
	
	
	
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
	{
		tempassistantfemale=Integer.parseInt(rs.getString(1));
	}
	
	tempprofessormale=countprofessormale-=tempprofessormale;
	tempprofessorfemale=countprofessorfemale-=tempprofessorfemale;
	tempassociatefemale=countassociatefemale-=tempassociatefemale;
	tempassociatemale=countassociatemale-=tempassociatemale;
	tempassistantfemale=countassistantfemale-=tempassistantfemale;
	tempassistantmale=countassistantmale-=tempassistantmale;
	
	pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
	rooms=pstmt.executeQuery();
	
	pstmt  = con.prepareStatement(newQuerry.CountRooms);
	rs=pstmt.executeQuery();
	totalrooms=Integer.parseInt(rs.getString(1));
%>

<%
	String rosterCol=" ",nameRoster=" ";
	int alter=1;
	String qry=" ";
	String day=" ";
	String tablename=" ";
	String row=" ";
	String name=" ";
	String repeatrowm=" ",repeattablem="Shift1",repeatvaluem=" ";
	String repeatrowf=" ",repeattablef="Shift1",repeatvaluef=" ";
	int initm=1,initf=1;
	for(j=1;j<=days;j++)
	{
		
		day="day"+j;
		for(i=1;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(k=1;k<=totalrooms;k++)
			{
				if(alter==1 && tempassistantmale>0){
					assistantmale.next();
					rooms.next();
					row=rooms.getString(1);
					if(repeatrowm .equals(row)==true && repeatvaluem .equals(assistantmale.getString(1))==true && repeattablem .equals(tablename)==true){
						tempassistantmale--;
						assistantmale.next();
						repeatvaluem=assistantmale.getString(1);
					}
					name=assistantmale.getString(1);
					qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					alter=1-alter;
					tempassistantmale--;
					if(initm==1){
						repeatrowm=row;
						repeatvaluem=assistantmale.getString(1);
						repeattablem=tablename;
						initm++;
					}
				}
				else if(alter==0 && tempassistantfemale>0){
					assistantfemale.next();
					rooms.next();
					row=rooms.getString(1);
					if(repeatrowf .equals(row)==true && repeatvaluef .equals(assistantfemale.getString(1))==true && repeattablef .equals(tablename)==true){
						tempassistantfemale--;
						assistantfemale.next();
						repeatvaluef=assistantfemale.getString(1);
					}
					name=assistantfemale.getString(1);
					qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					alter=1-alter;
					tempassistantfemale--;
					if(initf==1){
						repeatrowf=row;
						repeatvaluef=assistantfemale.getString(1);
						repeattablef=tablename;
						initf++;
					}
				}
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();
				
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,name);
				pstmt.executeUpdate();
				
				if(tempassistantmale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[2]);
					pstmt.setString(2,"male");
					assistantmale=pstmt.executeQuery();
					tempassistantmale=countassistantmale;
				}
				if(tempassistantfemale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[2]);
					pstmt.setString(2,"female");
					assistantfemale=pstmt.executeQuery();
					tempassistantfemale=countassistantfemale;
				}
			}
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();
		}
	}
%>

<%
	
	String repeatrow=" ",repeattable="Shift1",repeatvalue=" ";
	for(j=1;j<=days;j++)
	{
		day="day"+j;
		for(i=1;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(k=1;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				if((rs.getString(1)).equals("female")==true)
					continue;
				else{
					professorfemale.next();
					
					if(repeatrow.equals(row)==true && repeatvalue.equals(professorfemale.getString(1)) && repeattable.equals(tablename)){
						tempprofessorfemale--;
						if(tempprofessorfemale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[0]);
							pstmt.setString(2,"female");
							professorfemale=pstmt.executeQuery();
							tempprofessorfemale=countprofessorfemale;
							duties[0]--;
							professorfemale.next();
						}
						else
							professorfemale.next();
						repeatvalue=professorfemale.getString(1);
					}

					name=previous + " , " + professorfemale.getString(1);
					nameRoster=professorfemale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempprofessorfemale--;
					if(j==1 && i==1 && k==1){
						repeatrow=row;
						repeatvalue=professorfemale.getString(1);
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
				if(tempprofessorfemale==0 && duties[0]==1)
					break;
			    if(tempprofessorfemale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[0]);
					pstmt.setString(2,"female");
					professorfemale=pstmt.executeQuery();
					tempprofessorfemale=countprofessorfemale;
					duties[0]--;
				}
			}
			if(tempprofessorfemale==0 && duties[0]==1)
				break;
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
		}
		if(tempprofessorfemale==0 && duties[0]==1)
			break;
	}
%>

<%
	k++;
	repeatrow=" ";repeattable=" ";repeatvalue=" ";
	String nextroom=" ",nextvalue=" ";
	int initial=1;
	for(;j<=days;j++)
	{
		day="day"+j;
		for(;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				if((rs.getString(1)).equals("female")==true)
					continue;
				else{
					associatefemale.next();
					if(repeatrow.equals(row)==true && repeatvalue.equals(associatefemale.getString(1)) && repeattable.equals(tablename)){
						tempassociatefemale--;
						if(tempassociatefemale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[1]);
							pstmt.setString(2,"female");
							associatefemale=pstmt.executeQuery();
							tempassociatefemale=countassociatefemale;
							duties[1]--;
							associatefemale.next();
						}
						else
							associatefemale.next();
						repeatvalue=associatefemale.getString(1);
					}

					name=previous + " , " + associatefemale.getString(1);
					nameRoster=associatefemale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempassociatefemale--;
					if(initial==1){
						repeatrow=row;
						repeatvalue=associatefemale.getString(1);
						repeattable=tablename;
						initial++;
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
				if(tempassociatefemale==0 && duties[1]==1)
				{
					k++;
					if(k>totalrooms)
					{
						pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
						rooms=pstmt.executeQuery();	
						k=1;
						i++;
						if(i>shifts)
						{
							j++;
							i=1;
						}
						tablename="Shift"+i;
						day="day"+j;
					}
					rooms.next();
					row=rooms.getString(1);
					nextroom=row;
					qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
					pstmt  = con.prepareStatement(qry);
					pstmt.setString(1,row);
					rs=pstmt.executeQuery();
					nextvalue=rs.getString(1);
					break;
				}
			    if(tempassociatefemale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[1]);
					pstmt.setString(2,"female");
					associatefemale=pstmt.executeQuery();
					tempassociatefemale=countassociatefemale;
					duties[1]--;
				}
			}
			if(tempassociatefemale==0 && duties[1]==1)
				break;
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
			k=1;
		}
		if(tempassociatefemale==0 && duties[1]==1)
			break;
		i=1;
	}
%>

<%
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"female");
	assistantfemale=pstmt.executeQuery();
	tempassistantfemale=countassistantfemale;
	assistantfemale.next();
	tempassistantfemale--;
	int x=j;
	int z=0;
	int num=(int)(Math.ceil(totalrooms/2));
	if(j<=days)
	{
		while((assistantfemale.getString(1)).equals(nextvalue)==false)
		{
			assistantfemale.next();
			tempassistantfemale--;
		}
		
		while(z<num)
		{
			if(tempassistantfemale==0){
				pstmt  = con.prepareStatement(newQuerry.DifferentRank);
				pstmt.setString(1,ranks[2]);
				pstmt.setString(2,"female");
				assistantfemale=pstmt.executeQuery();
				tempassistantfemale=countassistantfemale;
			}
			assistantfemale.next();
			tempassistantfemale--;
			z++;
		}
		pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
		rooms=pstmt.executeQuery();	
		rooms.next();
		while((rooms.getString(1)).equals(nextroom)==false)
			rooms.next();
		
		if(tempassistantfemale==0){
			pstmt  = con.prepareStatement(newQuerry.DifferentRank);
			pstmt.setString(1,ranks[2]);
			pstmt.setString(2,"female");
			assistantfemale=pstmt.executeQuery();
			tempassistantfemale=countassistantfemale;
		}
	}
%>

<%
	k++;
	repeatrow=" ";repeattable=" ";repeatvalue=" ";
	initial=1;
	for(;j<=days;j++)
	{
		day="day"+j;
		for(;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				if((rs.getString(1)).equals("female")==true)
					continue;
				else{
					assistantfemale.next();
					if(repeatrow.equals(row)==true && repeatvalue.equals(assistantfemale.getString(1)) && repeattable.equals(tablename)){
						tempassistantfemale--;
						if(tempassistantfemale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[1]);
							pstmt.setString(2,"female");
							assistantfemale=pstmt.executeQuery();
							tempassistantfemale=countassistantfemale;
							assistantfemale.next();
						}
						else
							assistantfemale.next();
						repeatvalue=assistantfemale.getString(1);
					}

					name=previous + " , " + assistantfemale.getString(1);
					nameRoster=assistantfemale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempassistantfemale--;
					if(initial==1){
						repeatrow=row;
						repeatvalue=assistantfemale.getString(1);
						repeattable=tablename;
						initial++;
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
			    if(tempassistantfemale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[2]);
					pstmt.setString(2,"female");
					assistantfemale=pstmt.executeQuery();
					tempassistantfemale=countassistantfemale;
				}
			}
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
			k=1;
		}
		i=1;
	}
%>

<%
	repeatrow=" ";repeattable="Shift1";repeatvalue=" ";
	for(j=1;j<=days;j++)
	{
		day="day"+j;
		for(i=1;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(k=1;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				/*if(rs.next()==false)
					continue;*/
				if((rs.getString(1)).equals("male")==true)
					continue;
				else{
					professormale.next();
					
					if(repeatrow.equals(row)==true && repeatvalue.equals(professormale.getString(1)) && repeattable.equals(tablename)){
						tempprofessormale--;
						if(tempprofessormale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[0]);
							pstmt.setString(2,"male");
							professormale=pstmt.executeQuery();
							tempprofessormale=countprofessormale;
							duties2[0]--;
							professormale.next();
						}
						else
							professormale.next();
						repeatvalue=professormale.getString(1);
					}

					name=previous + " , " + professormale.getString(1);
					nameRoster=professormale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempprofessormale--;
					if(j==1 && i==1 && k==1){
						repeatrow=row;
						repeatvalue=professormale.getString(1);
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
				if(tempprofessormale==0 && duties2[0]==1)
					break;
			    if(tempprofessormale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[0]);
					pstmt.setString(2,"male");
					professormale=pstmt.executeQuery();
					tempprofessormale=countprofessormale;
					duties2[0]--;
				}
			}
			if(tempprofessormale==0 && duties2[0]==1)
				break;
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
		}
		if(tempprofessormale==0 && duties2[0]==1)
			break;
	}
%>

<%
	k++;
	repeatrow=" ";repeattable=" ";repeatvalue=" ";
	nextroom=" ";nextvalue=" ";
	initial=1;
	for(;j<=days;j++)
	{
		day="day"+j;
		for(;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				/*if(rs.next()==false)
					continue;*/
				if((rs.getString(1)).equals("male")==true)
					continue;
				else{
					associatemale.next();
					if(repeatrow.equals(row)==true && repeatvalue.equals(associatemale.getString(1)) && repeattable.equals(tablename)){
						tempassociatemale--;
						if(tempassociatemale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[1]);
							pstmt.setString(2,"male");
							associatemale=pstmt.executeQuery();
							tempassociatemale=countassociatemale;
							duties2[1]--;
							associatemale.next();
						}
						else
							associatemale.next();
						repeatvalue=associatemale.getString(1);
					}

					name=previous + " , " + associatemale.getString(1);
					nameRoster=associatemale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempassociatemale--;
					if(initial==1){
						repeatrow=row;
						repeatvalue=associatemale.getString(1);
						repeattable=tablename;
						initial++;
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
				if(tempassociatemale==0 && duties2[1]==1)
				{
					k++;
					if(k>totalrooms)
					{
						pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
						rooms=pstmt.executeQuery();	
						k=1;
						i++;
						if(i>shifts)
						{
							j++;
							i=1;
						}
						tablename="Shift"+i;
						day="day"+j;
					}
					rooms.next();
					row=rooms.getString(1);
					nextroom=row;
					qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
					pstmt  = con.prepareStatement(qry);
					pstmt.setString(1,row);
					rs=pstmt.executeQuery();
					nextvalue=rs.getString(1);
					break;
				}
			    if(tempassociatemale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[1]);
					pstmt.setString(2,"male");
					associatemale=pstmt.executeQuery();
					tempassociatemale=countassociatemale;
					duties2[1]--;
				}
			}
			if(tempassociatemale==0 && duties2[1]==1)
				break;
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
			k=1;
		}
		if(tempassociatemale==0 && duties2[1]==1)
			break;
		i=1;
	}
%>

<%
	pstmt  = con.prepareStatement(newQuerry.DifferentRank);
	pstmt.setString(1,ranks[2]);
	pstmt.setString(2,"male");
	assistantmale=pstmt.executeQuery();
	tempassistantmale=countassistantmale;
	assistantmale.next();
	tempassistantmale--;
	/*StringTokenizer nextvalue2 = new StringTokenizer(nextvalue," ");  
	nextvalue=nextvalue2.nextToken();*/
	z=0;
	if(j<=days)
	{
		while((assistantmale.getString(1)).equals(nextvalue)==false)
		{
			assistantmale.next();
			tempassistantmale--;
		}
		
		while(z<num)
		{
			if(tempassistantmale==0){
				pstmt  = con.prepareStatement(newQuerry.DifferentRank);
				pstmt.setString(1,ranks[2]);
				pstmt.setString(2,"male");
				assistantmale=pstmt.executeQuery();
				tempassistantmale=countassistantmale;
			}
			assistantmale.next();
			tempassistantmale--;
			z++;
		}
		pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
		rooms=pstmt.executeQuery();	
		rooms.next();
		while((rooms.getString(1)).equals(nextroom)==false)
			rooms.next();
				
		if(tempassistantmale==0){
			pstmt  = con.prepareStatement(newQuerry.DifferentRank);
			pstmt.setString(1,ranks[2]);
			pstmt.setString(2,"male");
			assistantmale=pstmt.executeQuery();
			tempassistantmale=countassistantmale;
		}
	}
%>

<%
	k++;
	repeatrow=" ";repeattable=" ";repeatvalue=" ";
	initial=1;
	for(;j<=days;j++)
	{
		day="day"+j;
		for(;i<=shifts;i++)
		{
			tablename="Shift"+i;
			for(;k<=totalrooms;k++)
			{
				String previous;
				rooms.next();
				row=rooms.getString(1);
				qry="SELECT " + day + " FROM " + tablename + " WHERE RoomNo= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,row);
				rs=pstmt.executeQuery();
				previous=rs.getString(1);
				pstmt  = con.prepareStatement(newQuerry.SelectSex);
				pstmt.setString(1,previous);
				rs=pstmt.executeQuery();
				/*if(rs.next()==false)
					continue;*/
				if((rs.getString(1)).equals("male")==true)
					continue;
				else{
					assistantmale.next();
					if(repeatrow.equals(row)==true && repeatvalue.equals(assistantmale.getString(1)) && repeattable.equals(tablename)){
						tempassistantmale--;
						if(tempassistantmale==0){
							pstmt  = con.prepareStatement(newQuerry.DifferentRank);
							pstmt.setString(1,ranks[1]);
							pstmt.setString(2,"male");
							assistantmale=pstmt.executeQuery();
							tempassistantmale=countassistantmale;
							assistantmale.next();
						}
						else
							assistantmale.next();
						repeatvalue=assistantmale.getString(1);
					}

					name=previous + " , " + assistantmale.getString(1);
					nameRoster=assistantmale.getString(1);
					//qry="update "+tablename+" set "+day+"= ? where RoomNo= ?";
					tempassistantmale--;
					if(initial==1){
						repeatrow=row;
						repeatvalue=assistantmale.getString(1);
						repeattable=tablename;
						initial++;
					}
				}
				
				/*pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,name);
				pstmt.setString(2,row);
				pstmt.executeUpdate();*/
				
				rosterCol="shift"+i+"day"+j;
				qry="update Roster set "+rosterCol+"= ? where id= ?";
				pstmt  = con.prepareStatement(qry);
				pstmt.setString(1,"P");
				pstmt.setString(2,nameRoster);
				pstmt.executeUpdate();
				
			    if(tempassistantmale==0){
					pstmt  = con.prepareStatement(newQuerry.DifferentRank);
					pstmt.setString(1,ranks[2]);
					pstmt.setString(2,"male");
					assistantmale=pstmt.executeQuery();
					tempassistantmale=countassistantmale;
				}
			}
			pstmt  = con.prepareStatement(newQuerry.RoomsInShift);
			rooms=pstmt.executeQuery();	
			k=1;
		}
		i=1;
	}
	session.setAttribute("shifts",shifts);
	con.close();
	response.sendRedirect("deletetemptables.jsp");
}
else
	response.sendRedirect("login.html");
%>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>	
</html>
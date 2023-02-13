package querry;
public class DBQuerry{
	public DBQuerry(){
	}
	public final String AdminLogin= "select id,password from login where id = ? and password = ?";
	public final String InsertFacultyDetails= "INSERT INTO FacultyDetails(id,name,age,sex,rank) VALUES(?,?,?,?,?)";
	public final String DeleteFaculty= "update FacultyDetails set active=0 where id= ?;";
	public final String GetFacultyColumns= "PRAGMA table_info('FacultyDetails')";
	public final String ApplyForLeave= "INSERT INTO LeaveApplication(id,sex,rank,reason) VALUES(?,?,?,?)";
	public final String DeleteLeave= "delete from LeaveApplication where id=?";
	public final String AddRoom= "INSERT INTO RoomInfo(RoomNo) VALUES(?)";
	public final String DeleteRoom= "DELETE FROM RoomInfo WHERE RoomNo= ?";
	public final String DistinctRank= "SELECT DISTINCT rank FROM FacultyDetails WHERE active=1";
	public final String CountDistinctRank= "SELECT count(DISTINCT rank) FROM FacultyDetails WHERE active=1";
	public final String SelectRooms= "SELECT RoomNo FROM RoomInfo";
	public final String DifferentRank= "SELECT id FROM FacultyDetails WHERE rank=? and sex=? and active=1 except SELECT id FROM LeaveApplication";
	public final String CountDifferentRank= "SELECT count(*) FROM FacultyDetails WHERE rank=? and sex=? and active=1";
	public final String RoomsInShift= "SELECT RoomNo FROM RoomInfo";
	public final String CountRooms= "SELECT count(*) FROM RoomInfo";
	public final String SelectSex= "SELECT sex FROM FacultyDetails WHERE id= ? and active=1";
	public final String CountLeave="SELECT count(id) FROM LeaveApplication WHERE rank=? and sex=?";
	public final String SelectRankSex="SELECT rank,sex FROM FacultyDetails WHERE id= ? and active=1";
	public final String SelectIdNameGender="SELECT id,name,sex FROM FacultyDetails WHERE active=1";
	public final String RosterInsert="INSERT INTO Roster(id,name,sex) values(?,?,?)";
	public final String CreateRoster="CREATE TABLE Roster ('id'	TEXT NOT NULL,'name'	TEXT NOT NULL,'sex'	TEXT NOT NULL,PRIMARY KEY('id'))";
	public final String DeleteRoster="DROP TABLE Roster";
	public final String RosterData="SELECT * FROM Roster";
}
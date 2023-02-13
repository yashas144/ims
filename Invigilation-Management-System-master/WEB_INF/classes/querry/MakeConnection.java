package querry;
import java.sql.*;
public class MakeConnection{
	public MakeConnection(){
	}
	public Connection connect() {
        String url = "jdbc:sqlite:C:\\Users\\dell\\Desktop\\New_folder\\JAVA\\database\\inviligate.db";
        Connection conn = null;
		try {
			Class.forName("org.sqlite.JDBC");	
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        try {
            conn = DriverManager.getConnection(url);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return conn;
    }
}
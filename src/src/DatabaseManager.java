import org.postgresql.Driver;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;


/** Utility Singleton class for connecting/disconnecting, running queries and getting results. */
public class DatabaseManager {
    private static final String url = "jdbc:postgresql://comp421.cs.mcgill.ca:5432/cs421";
    private static Connection con = null;
    private static Statement statement = null;
    private static int sqlCode = 0;
    private static String sqlState = "00000";

    public static boolean isConnected(){
        return con != null;
    }

    /** Registers the Driver, attempts to connect to database and stores the connection + statement. */
	public static void connectDatabase(String username, String password) throws SQLException{
        // Register the driver.  You must register the driver before you can use it.
        try {
            DriverManager.registerDriver ( new Driver()) ;
        } catch (Exception cnfe){
            System.out.println("Driver Class not found");
        }

        con = DriverManager.getConnection(url, username, password);
        statement = con.createStatement () ;
	}

	@SuppressWarnings("Duplicates")
	/** Run a piece of SQL code and return the result.*/
	public static ResultSet runQuery(String sql){
	    ResultSet resultSet = null;
	    try{
            resultSet = statement.executeQuery ( sql ) ;

        }catch(SQLException e){
	        System.out.println("Failed to execute query: " + sql);
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE
            System.out.println("SQL Failed with code: " + sqlCode + "  sqlState: " + sqlState);
	        e.printStackTrace();
        }
	    return resultSet;
    }

    @SuppressWarnings("Duplicates")
    public static int runUpdate(String sql){
        int result = -1;
        try{
            result = statement.executeUpdate ( sql ) ;

        }catch(SQLException e){
            System.out.println("Failed to execute query: " + sql);
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE
            System.out.println("SQL Failed with code: " + sqlCode + "  sqlState: " + sqlState);
            e.printStackTrace();
        }
        return result;
    }

	/** Disconnect from the database.*/
	public static void disconnect() {
        try {
            statement.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


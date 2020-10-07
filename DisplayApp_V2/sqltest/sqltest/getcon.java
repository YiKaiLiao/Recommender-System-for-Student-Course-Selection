package sqltest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;



public class getcon {
	static int lport;
	static String rhost;
	static int rport;

	public void go() {
		String user = "yuren";
		String password = "yuren1234";
		String host = "140.123.4.177";
		int port = 22;
		try {
			JSch jsch = new JSch();

			Session session = jsch.getSession(user, host, port);
			lport = 3306;
			rhost = "localhost";
			rport = 3306;
			session.setPassword(password);

			session.setConfig("StrictHostKeyChecking", "no");

			System.out.println("Establishing Connection...");
			session.connect();
			int assinged_port = session.setPortForwardingL(lport, rhost, rport);
			System.out.println("localhost:" + assinged_port + " -> " + rhost + ":" + rport);
			
		} catch (Exception e) {
			System.err.print(e);
		}
	}
	Connection con = null;
	public Connection getcon() {
		
		try {
			go();
			System.out.println("An example for updating a Row from Mysql Database!");
			
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://" + rhost + ":" + lport + "/";
			String db = "Radar";
			String dbUser = "dash";
			String dbPasswd = "crazy4dash@";

			Class.forName(driver);
			con = DriverManager.getConnection(url + db, dbUser, dbPasswd);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		

		return con;
	}
  public void disconnect() {
	  try {
		if(con.isClosed()==false)
		  try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  }
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		System.out.println("An example for updating a Row from Mysql Database!");
		Connection con = null;
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://" + rhost + ":" + lport + "/";
		String db = "Radar";
		String dbUser = "dash";
		String dbPasswd = "crazy4dash@";
	
		getcon p1=new getcon();
		Connection con2=p1.getcon();
		try {
			Statement st=con2.createStatement();

			ResultSet rs=st.executeQuery("SELECT * FROM Radar.Score limit 10;");
			ResultSetMetaData rmsd=rs.getMetaData();
			while(rs.next()){
				for(int i=1;i<=rmsd.getColumnCount();i++){
					System.out.print(rs.getString(i)+" ,");
				}
				System.out.println("");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}

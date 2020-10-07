package sqltest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class getallstuscore {
	public void  writeall() {
		File folder = new File("/media/yuren/D/other/pcaworkstation/departstuno/");
		File[] file = folder.listFiles();
		HashMap<String, List> tempset = new HashMap<>();
		ArrayList<HashMap<String, String>> stugradeleft6id=new ArrayList<>();
		for (File f : file) {
			String departcd = f.getName().toString().split("\\.")[0];
			File f2=new File("/media/yuren/D/other/pcaworkstation/mergestuscore/"+f.getName());
			try(Connection con=new getcon().getcon();){
				Statement st=con.createStatement();
				String DeptID=departcd;//1104
				String q="select distinct (LEFT(Std_no , 6)) FROM Radar.Student_Dept where  DeptID='"+DeptID+"';" ;
				ResultSet rs=st.executeQuery(q);
				while(rs.next()){
					//HashMap<String, String> hs=new HashMap<>();
					 //hs.put(DeptID, rs.getNString(1));
					 //stugradeleft6id.add(hs);
					 write(DeptID,rs.getString(1));
				}
				
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
		}
		
	}
	public void  writeone(String dept) {
		try(Connection con=new getcon().getcon();){
			Statement st=con.createStatement();
			String DeptID=dept;//4104
			String q="select distinct (LEFT(Std_no , 6)) FROM Radar.Student_Dept where  DeptID='"+DeptID+"';" ;
			ResultSet rs=st.executeQuery(q);
			while(rs.next()){
				//HashMap<String, String> hs=new HashMap<>();
				 //hs.put(DeptID, rs.getNString(1));
				 //stugradeleft6id.add(hs);
				 write(DeptID,rs.getString(1));
			}
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
				
		   
	}
	
	public void write(String _std_no,String _DeptID) {
		studentdatatojson  p1 =new studentdatatojson();
		//改成你想要的路徑
		p1.setPath("/media/yuren/D/other/pcaworkstation/allstuscore1/");
		p1.go(_std_no, _DeptID);
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
			//改成你想要的抓的科系
		getallstuscore p1=new getallstuscore();
		p1.writeone("4104");
		
	}

}

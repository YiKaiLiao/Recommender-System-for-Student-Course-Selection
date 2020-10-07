package sqltest;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;


public class studentdatatojson {
	String path="";
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public void go(String _DeptID,String _std_no ){
		getcon gcon=new getcon();
		try(Connection con=gcon.getcon();){
			Statement st=con.createStatement();
			String std_no=_std_no+"%";//"402110%";
			String DeptID=_DeptID;//"1104";
//			ResultSet rs=st.executeQuery("SELECT  distinct(Cour_cd) FROM Radar.Score where Year=104 and Name!='學系服務學習';");
			String q="SELECT distinct b.CourseName,a.Cour_cd,a.Grp,a.Term  FROM Radar.AllScore a inner join Radar.AllCourse b where a.std_no like '"+std_no+"' and a.Cour_cd=b.Cour_cd and a.Grp=b.Grp and a.Year =b.Year"
					+" and a.Term=b.Term and b.DeptID='"+DeptID+"';";
			ResultSet rs=st.executeQuery(q);
			ArrayList<HashMap<String, String>> sub=new ArrayList<>();
//			sub.add("id");
			while(rs.next()){
//				sub.add(rs.getString(1));
				HashMap<String, String> hs=new HashMap<>();
				 hs.put("name", rs.getString("CourseName"));
				 hs.put("subcd", rs.getString("Cour_cd"));
				 hs.put("Term", rs.getString("Term"));
				 hs.put("Grp", rs.getString("Grp"));
				sub.add(hs);
			}
			int row=sub.size()+1;
			int col=0;
//			 rs=st.executeQuery("select count(distinct std_no) from Radar.Score where year='104' and Name!='學系服務學習';");
			rs=st.executeQuery("SELECT count(distinct a.Std_no) FROM Radar.AllScore a join Radar.AllCourse b where a.std_no like '"+std_no+"' and a.Cour_cd=b.Cour_cd and a.Grp=b.Grp"
              +" and a.Term=b.Term and a.Year =b.Year and b.DeptID='"+DeptID+"' ;") ;
			if(rs.next()){
				 col=rs.getInt(1)+1;//加一行label
			}
			
			String[][] output=new String[col][row];
			
			for(int i=0;i<col;i++){
				for(int j=0;j<row;j++){
					if(i==0){
						
							if(j==0){output[i][j]="id";}
							else {
								output[i][j]=sub.get(j-1).get("subcd")+"@"+sub.get(j-1).get("name")
										+"@"+sub.get(j-1).get("Term")+"@"+sub.get(j-1).get("Grp");
							}
						
						
					}else{
						output[i][j]="NaN";
					}
				}
			}
			//大四所有學生
			 rs=st.executeQuery("select b.Cour_cd,b.CourseName,a.Grp,a.Std_no,a.trmgrd,a.Term FROM Radar.AllScore a inner join Radar.AllCourse b where a.std_no like '"+std_no+"' and a.Cour_cd=b.Cour_cd and a.Grp=b.Grp and a.Year =b.Year"
                     +" and a.Term=b.Term and b.DeptID='"+DeptID+"'" );
				ArrayList<HashMap<String, Object>> studata=new ArrayList<>();
				int co=0;
			 while(rs.next()){
				 System.out.println(co+"%");
				 for(int i=0;i<sub.size();i++){
					 if(sub.get(i).get("name").equals(rs.getString("CourseName")) &&
							 sub.get(i).get("subcd").equals(rs.getString("Cour_cd")) &&
							 sub.get(i).get("Term").equals(rs.getString("Term")) &&
							 sub.get(i).get("Grp").equals(rs.getString("Grp"))){
						 for(int j=0;j<col;j++){
							 if(output[j][0].equals("NaN")){
								 output[j][0]=rs.getString("Std_no");
								 output[j][i+1]=rs.getString("trmgrd");
								 break;
							 }else if(output[j][0].equals(rs.getString("Std_no"))){
								 output[j][i+1]=rs.getString("trmgrd");
								 break;
							 }
//						 if(studata.get(i).get("stuname").equals(rs.getString("Std_no")) ){
//							 ArrayList eachsubstusco=(ArrayList)studata.get(i).get("stusco");
//							 eachsubstusco.add(rs.getString("trmgrd"));
//							 ArrayList eachsubsubind=(ArrayList)studata.get(i).get("subind");
//							 eachsubstusco.add(rs.getString("trmgrd"));
//							 
//							 HashMap<String, Object> hs=new HashMap<>();
//							 hs.put("stuname",rs.getString("Std_no"));
//							 hs.put("stusco",rs.getString("trmgrd"));
//							 hs.put("subind", (i+1)+"");
//							 studata.get(i).put("stusco", eachsubstusco);
//							 studata.get(i).put("subind", eachsubsubind);

						 }
						 
					 }
				 }
//				 HashMap<String, String> hs=new HashMap<>();
//				 hs.put("name", rs.getString("Name"));
//				 hs.put("subcd", rs.getString("Cour_cd"));
//				 studata.add(hs);
			}
//			 rs=st.executeQuery("select   Term,Cour_cd,Grp,std_no,trmgrd,Name from Radar.Score where year='104' and Name!='學系服務學習' order by Std_no;");
//			ResultSetMetaData rmsd=rs.getMetaData();
			
//			System.out.println("123131");
//			HashMap<String, Object> stu=new HashMap<>();
//			ArrayList<String> stu=new ArrayList<>();
//			Iterator<HashMap<String, String>> stu=(Iterator<HashMap<String, String>>) studata;
			
			
			
			write(output,col,row,_DeptID,_std_no);
			gcon.disconnect();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	public void write(String[][] f,int col,int row,String DeptID,String stugradeid){
		//File scoreFile = new File("/media/yuren/D/104score2.csv");
		//File foldnew= new File("/media/yuren/D/other/pcaworkstation/allstuscore/"+DeptID);
		File foldnew= new File(path+"/"+DeptID+"/");
		if(foldnew.exists()==false) {
			foldnew.mkdirs();
		}
		File scoreFile = new File(path+"/"+DeptID+"/"+stugradeid+".csv");
		
		try {
		  BufferedWriter Writer = null;
		  Writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(scoreFile), "UTF-8")); // 開啟Append模式
		  System.out.println(col+" "+row);
		  for (int i = 0; i < col; i++) {
			  for (int j = 0; j < row; j++) {
				  	if(f[i][0].equals("NaN")){
				  		break;
				  	}
				  	
				  	Writer.write(f[i][j]);
				  	
					if(j!=row-1)
						{Writer.write(",");}
					
				}
			  if(i%10==0)
			  { double p=(i/col)*100;
				  System.out.println(p+"% "+i);}
			  Writer.newLine();
			}
			Writer.flush();
			Writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		studentdatatojson s1=new studentdatatojson();
		//s1.go();
	}

}

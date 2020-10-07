package sqltest;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;

public class getdepartstu {
	HashMap<String, List> departallstu = new HashMap<>();
	HashMap<String, List> departallstuscore = new HashMap<>();
	HashMap<String, String> departset = new HashMap<>();
	HashMap<String, List> departstu5yearset = new HashMap<>();

	public void go() {
		readfile();

		try (Connection con = new getcon().getcon();) {
			Statement st = con.createStatement();
			for (String key : departset.keySet()) {

				String q = "select  distinct (substring(a.std_no,1,6)) ,count( substring(a.std_no,1,6))  FROM Radar.AllScore  a inner join Radar.AllCourse b on (a.Cour_cd=b.Cour_cd and a.Grp=b.Grp and a.Year =b.Year and a.Term=b.Term )"
						+ "where  a.Year >='103'   and b.DeptID='" + key
						+ "' group by  substring(a.std_no,1,6) order by  count( substring(a.std_no,1,6)) desc ";
				ResultSet rs = st.executeQuery(q);
				if (rs.next()) {
					String t = rs.getString(1);
					List tlist = new ArrayList<String>();
					for (int i = 4; i >= 1; i--) {

						String t2 = t.replace(t, t.substring(0, 2) + i + t.substring(3, t.length()));

						tlist.add(t2);
					}
					departstu5yearset.put(key, tlist);

				}

			}
			int cnt = 1;
			for (String key : departstu5yearset.keySet()) {
				List<String> l1 = departstu5yearset.get(key);
				List<String> tlist = new ArrayList<String>();
				for (String s1 : l1) {

					String q = "SELECT distinct(a.std_no)  FROM Radar.AllScore  a inner join Radar.AllCourse b on (a.Cour_cd=b.Cour_cd and a.Grp=b.Grp and a.Year =b.Year and a.Term=b.Term )"
							+ "where  a.Year >=101    and substring(a.std_no,1,6)  = '" + s1
							+ "'  order by a.std_no asc; ";
					ResultSet rs = st.executeQuery(q);

					while (rs.next()) {
						tlist.add(rs.getString(1));
					}

				}
				departallstu.put(key, tlist);
				System.out.println(cnt);
				cnt++;

			}
			for (String key : departallstu.keySet()) {
				writefile(new File("/media/yuren/D/other/pcaworkstation/departstuno/" + key + ".csv"),
						departallstu.get(key));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void readfile() {
		String csvFile = "/media/yuren/D/other/pcaworkstation/alldept.csv";

		CSVReader reader = null;
		try {
			reader = new CSVReader(new FileReader(csvFile));
			String[] line;
			while ((line = reader.readNext()) != null) {

				departset.put(line[1], line[0]);

				// System.out.println("Country [id= " + line[0] + ", code= " +
				// line[1] +"]");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void readdepartstuscore() {
		File folder = new File("/media/yuren/D/other/pcaworkstation/departstuscore/");
		File[] file = folder.listFiles();
		HashMap<String, List> tempset = new HashMap<>();
		for (File f : file) {
			String departcd = f.getName().toString().split("\\.")[0];
			
			writefile2(new File("/media/yuren/D/other/pcaworkstation/mergestuscore/"+f.getName()),getoridepartstuscore(f));
		}
	}

	public HashMap<String, List<HashMap<String, String>>> getoridepartstuscore(File f) {
		// String csvFile = "/media/yuren/D/other/pcaworkstation/departstuno/" +
		// p + ".csv";
		List<String> list = new ArrayList<>();
		CSVReader reader = null;
		HashMap<String, List<HashMap<String, String>>> data = new HashMap<>();
		try {
			reader = new CSVReader(new FileReader(f));
			String[] line;
			int cnt = 0;

			
			while ((line = reader.readNext()) != null) {
				if (cnt == 0) {
					cnt++;
					continue;
				}
				
				if (data.containsKey(line[0])) {
					HashMap<String, String> t1 = new HashMap<>();
					t1.put("index", line[1]);
					t1.put("score", line[2]);
					data.get(line[0]).add(t1);
				} else {
					HashMap<String, String> t1 = new HashMap<>();
					t1.put("index", line[1]);
					t1.put("score", line[2]);
					List l1 = new ArrayList<>();
					l1.add(t1);
					data.put(line[0], l1);
				}

			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return data;
	}

	public void getdepartstuscore() {
		File folder = new File("/media/yuren/D/other/pcaworkstation/departstuno/");
		File[] file = folder.listFiles();
		HashMap<String, List> tempset = new HashMap<>();
		try (Connection con = new getcon().getcon();) {
			for (File f : file) {
				// tempset.put(f.getName().split(".")[0], getdepartstuno(f));
				// System.out.println(f.getName().split("\\.")[0]);
				String departcd = f.getName().toString().split("\\.")[0];
				List<String> l1 = getdepartstuno(f);

				Statement st = con.createStatement();
				String getstulist = "";
				if (l1.size() < 1) {
					continue;
				}
				for (String s1 : l1) {
					getstulist += "'" + s1 + "',";
				}
				getstulist = getstulist.substring(0, getstulist.length() - 1);
				String q = "select std_no,IndexNum,stuScore   FROM Radar.StuKernelScore where" + " std_no in ("
						+ getstulist + ")  order by std_no asc";
				// System.out.println(q);
				ResultSet rs = st.executeQuery(q);
				List tlist = new ArrayList<String>();
				while (rs.next()) {
					HashMap<String, String> stddata = new HashMap<>();
					stddata.put("std_no", rs.getString("std_no"));
					stddata.put("IndexNum", rs.getString("IndexNum"));
					stddata.put("stuScore", rs.getString("stuScore"));

					tlist.add(stddata);

				}
				tempset.put(departcd, tlist);
				writefile1(new File("/media/yuren/D/other/pcaworkstation/departstuscore/" + f.getName()), tlist);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List getdepartstuno(File f) {
		// String csvFile = "/media/yuren/D/other/pcaworkstation/departstuno/" +
		// p + ".csv";
		List<String> list = new ArrayList<>();
		CSVReader reader = null;
		try {
			reader = new CSVReader(new FileReader(f));
			String[] line;
			int cnt = 0;
			while ((line = reader.readNext()) != null) {
				if (cnt == 0) {
					cnt++;
					continue;
				}
				
				list.add(line[0]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}

	public void writefile1(File f, List<HashMap<String, String>> list) {

		CSVWriter writer;
		try {
			writer = new CSVWriter(new FileWriter(f), ',');
			String[] s = "stu_no,IndexNum,stuScore".split(",");
			writer.writeNext(s);
			// List<String> l1 = set.get(key);

			for (HashMap h1 : list) {
				String[] a = new String[3];
				a[0] = (String) h1.get("std_no");
				a[1] = (String) h1.get("IndexNum");
				a[2] = (String) h1.get("stuScore");
				writer.writeNext(a);

			}

			try {
				writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}
	public void writefile2(File f, HashMap<String, List<HashMap<String, String>>> hs) {

		CSVWriter writer;
		try {
			writer = new CSVWriter(new FileWriter(f), ',');
			if(hs.size()<1){return;}
			HashMap<String, String> h0=new HashMap<>();
			for (String l1 : hs.keySet()) {
				for(HashMap<String, String> ha:hs.get(l1)){
					if(!h0.containsKey(ha.get("index"))){
						h0.put(ha.get("index"),"");
					}
					
				}
			}
			
			List ll1=new ArrayList<>();
			for( String key:h0.keySet()){
				ll1.add(key);
			}
			
			Collections.sort(ll1, new Comparator<String>() {
		        @Override
		        public int compare(String f2, String f1)
		        {

		            return  Integer.parseInt(f2)-Integer.parseInt(f1);
		        }

				
		    });
			
			String[] s = "stu_no,IndexNum".split(",");
			String[] tit=new String[ll1.size()+1];
			tit[0]="stu_no";
			for( int i=0;i<ll1.size();i++){
				tit[i+1]=(String) ll1.get(i);
			}
			writer.writeNext(tit);
			String[] keyset1= hs.keySet().toArray(new String[hs.size()]);
			Arrays.sort(keyset1);
			for (String l1 : keyset1) {
				String[] ta=new String[ll1.size()+1];
				ta[0]=l1;
				for(HashMap<String, String> ha : hs.get(l1)){
					ta[ll1.indexOf(ha.get("index"))+1]=ha.get("score");
				}
				writer.writeNext(ta);
			}
//			writer.writeNext(tit);
			// List<String> l1 = set.get(key);

			
			try {
				writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}
	public void writefile(File f, List<String> list) {

		CSVWriter writer;
		try {
			writer = new CSVWriter(new FileWriter(f), ',');
			String[] s = "stu_no".split(",");
			writer.writeNext(s);
			// List<String> l1 = set.get(key);

			for (String s1 : list) {

				writer.writeNext(s1.split(","));

			}
			try {
				writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		getdepartstu g1 = new getdepartstu();
		g1.readdepartstuscore();
		// g1.go();
		// g1.writefile();
	}

}

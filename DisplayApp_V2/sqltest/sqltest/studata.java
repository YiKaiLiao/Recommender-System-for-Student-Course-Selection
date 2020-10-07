package sqltest;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;

public class studata {
//	String[] sub = { "機率論", "線性代數", "工程數學", "離散數學", "統計學" };
//	int[] substart = { 0, 2, 8, 9, 10, 13, 16 };
//	String[] pos = { "2102701", "4102013", "4101155", "2101013", "4151011", "4301001", "5201007", "N102011", "4102090",
//			"4153913", "4303024", "2103404", "4102085", "3202037", "4102170", "5152022" };
	String name="";
    String year="";
    String term="";
    String cour_cd="";
    String grp="";
    String std_no="";
    int pos=0;
	
    
	public studata(String name, String year, String term, String cour_cd, String grp, String std_no) {
		super();
		this.name = name;
		this.year = year;
		this.term = term;
		this.cour_cd = cour_cd;
		this.grp = grp;
		this.std_no = std_no;
	}
	public void fillpos(String x, String tscore) {
	
	}

	private BufferedWriter Writer = null;

	public void writefile(String l) {
		
//		File scoreFile = new File("mathscore.csv");
//		try {
//			Writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(scoreFile, true), "UTF-8")); // 開啟Append模式
//			Writer.write("name ,");
//			for (int j = 0; j < sub.length; j++) {
//				for (int i = substart[j]; i < substart[j + 1]; i++) {
//					Writer.write(sub[j] + (pos[i]));
//					Writer.write(",");
//				}
//			}
//			Writer.newLine();
//			for (int i = 0; i < pos.length; i++) {
//				Writer.write(score[i]);
//				if (i != pos.length - 1)
//					{Writer.write(",");}
//				Writer.newLine();
//			}
//			Writer.flush();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}

}

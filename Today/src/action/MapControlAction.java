package action;


import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.opensymphony.xwork2.ActionSupport;


public class MapControlAction extends ActionSupport implements SessionAware{

	private String local;
	private Map<String, Object> session;
	private ArrayList<String> itemList;
	
	private String urlStr;
	private String roadDetail = "";
	
	//MapControlAction 기본 생성자
	public MapControlAction() {	
	}//MapControlAction 기본 생성자 end
	
	
	//지역설정 값을 session에 설정(ex: 홍대, 삼청동, 하남)
	public String SessionLocal() {
		
		session.put("local", local);
		
		return SUCCESS;
	}//setSessionLocal end
	
	//사용자가 검색하는 아이템 리스트 설정
	public String valueItemList() {
		for (String string : itemList) {
			System.out.println(session.get("local") + " " + string);
		}
		return SUCCESS;
	}//valueItemList end
	
	

	 public void jsonParsing() throws UnsupportedEncodingException, IOException {
		 
		/* 공통부분 */
		String startX = "14129105.461214";
	    String startY = "4519042.1926406";
	    String endX = "14136027.789587";
	    String endY = "4517571.4945242";
		
		String urlStr = "https://apis.skplanetx.com/tmap/routes?version=1&format=json";
	     urlStr += "&startX="+startX;
	     urlStr += "&startY="+startY;
	     urlStr += "&endX="+endX;
	     urlStr += "&endY="+endY;
	     urlStr += "&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f";
		
	     System.setProperty("jsse.enableSNIExtension", "false") ;
	   	 URL url = new URL(urlStr);
		
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
		JSONObject object = (JSONObject) JSONValue.parse(isr);

		/* Object로 받을 경우 
		JSONObject head = (JSONObject) object.get("head");
		System.out.println(head.get("code").toString());
		System.out.println(head.get("adjust").toString());
		System.out.println(head.get("ADMIN_ADDR").toString());
		System.out.println(head.get("RETCODE").toString());
		*/
		/* Array로 받을 경우 */
		
		JSONArray bodyArray = (JSONArray) object.get("features");
		for (int i = 0; i < bodyArray.size()-1; i++) {
			JSONObject data = (JSONObject) bodyArray.get(i);
			//System.out.println(data.get("properties"));
			JSONObject featuresJson = (JSONObject) data.get("properties");
			//System.out.println(featuresJson.get("description"));
			
			if(!featuresJson.get("description").toString().contains(",")){
				roadDetail = roadDetail + featuresJson.get("description").toString() + "\n";
			}
		}
		
		System.out.println(roadDetail);
    }   

		  
	//경로 1구간 안내 정보
	public String pass_A() throws Exception{
			
		jsonParsing();
		return SUCCESS;
	    
	}
	
	//▼▼▼▼▼▼▼▼ setters getters ▼▼▼▼▼▼▼▼
	public ArrayList<String> getItemList() {
		return itemList;
	}

	public void setItemList(ArrayList<String> itemList) {
		this.itemList = itemList;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}
	
	public String getUrlStr() {
		return urlStr;
	}


	public void setUrlStr(String urlStr) {
		this.urlStr = urlStr;
	}
	
	public String getRoadDetail() {
		return roadDetail;
	}
	
	public void setRoadDetail(String roadDetail) {
		this.roadDetail = roadDetail;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}

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
	private int countItem;
	private String urlStr;
	private String roadDetail = "";
	
	//MapControlAction 기본 생성자
	public MapControlAction() {	
	}//MapControlAction 기본 생성자 end
	
	//추천 경로를 지정하기 위한 알고리즘
	public String recommendSpot() {
		
		return SUCCESS;
	}
	
	//지역설정 값을 session에 설정(ex: 홍대, 삼청동, 하남)
	public String SessionLocal() {
		
		session.put("local", local);
		
		return SUCCESS;
	}//setSessionLocal end
	
	//사용자가 검색하는 아이템 리스트 설정
	public String valueItemList() throws UnsupportedEncodingException, IOException {
		int count = 1;
		for (String item : itemList) {
			String urlStr = "";
			
			if (count <= 5) {
				urlStr += "https://apis.daum.net/local/v1/search/keyword.json?";
				urlStr += "apikey=d0224817161ef3c311a65c73ea03f837";
				urlStr += "&query=" + session.get("local") + "%20" + item;
				urlStr += "&sort=0"; //0정확도 / 1인기순 / 2거리순
				urlStr += "&count=3";//일단 1개씩만 받고 있음
				
				System.setProperty("jsse.enableSNIExtension", "false") ;
				URL url = new URL(urlStr);
				InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
				JSONObject object = (JSONObject) JSONValue.parse(isr);
				
				JSONObject channel = (JSONObject) object.get("channel");
				JSONArray bodyArray = (JSONArray) channel.get("item");
				
				for (int i = 0; i < bodyArray.size(); i++) {
					JSONObject data = (JSONObject) bodyArray.get(i);
					System.out.println(data.get("title").toString());
				}
				count++;
				
			} else {
				urlStr += "https://apis.daum.net/local/v1/search/keyword.json?";
				urlStr += "apikey=d0224817161ef3c311a65c73ea03f837";
				urlStr += "&query=" + session.get("local") + "%20" + item;
				urlStr += "&sort=1"; //0정확도 / 1인기순 / 2거리순
				urlStr += "&count=10";//일단 1개씩만 받고 있음
				

				System.out.println("여기들어와");
			}
		}
		
		return SUCCESS;
	}//valueItemList end
	
	

	 public void jsonParsing() throws UnsupportedEncodingException, IOException {
	     
		
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
		
		//System.out.println(roadDetail);
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

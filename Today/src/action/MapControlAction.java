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

	private String local;						//지역
	private Map<String, Object> session;		//세션
	private ArrayList<String> itemList;			//프론트 단에서 넘어오는 아이템 명(URIEncoding)
	private String urlStr;						//외부 API 사용을 위한 주소
	private String roadDetail = "";				//세부 경로 정보
	
	private ArrayList<String> recommendedItem;	//추천경로를 json 타입으로 리턴
	private String blogItem;					//블로그 검색을 위한 아이템 타이틀명(URIEncoding)
	private String blogInfoReturn;				//블로그 정보값 리턴
	private String blogInfoReturn2;				//블로그 세부정보값 리턴
	
	//MapControlAction 기본 생성자
	public MapControlAction() {
	}//MapControlAction 기본 생성자 end
	
	//지역설정 값을 session에 설정(ex: 홍대, 삼청동, 하남)
	public String SessionLocal() {
		session.put("local", local);
		return SUCCESS;
	}//setSessionLocal end
	
	//사용자가 검색하는 추천 아이템 리스트 설정
	public String valueItemList() throws UnsupportedEncodingException, IOException {
		recommendedItem = new ArrayList<>();
		int count = 1;
		String tempLocation = null;
		for (String item : itemList) {
			
			String urlStr = "";
			if (count == 1) {
				urlStr += "https://apis.daum.net/local/v1/search/keyword.json?";
				urlStr += "apikey=d0224817161ef3c311a65c73ea03f837";
				urlStr += "&query=" + session.get("local") + "%20" + item;
				urlStr += "&sort=0"; //0정확도 / 1인기순 / 2거리순
				urlStr += "&count=3";
				
				System.setProperty("jsse.enableSNIExtension", "false") ;
				URL url = new URL(urlStr);
				InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
				JSONObject object = (JSONObject) JSONValue.parse(isr);
				
				JSONObject channel = (JSONObject) object.get("channel");
				JSONArray bodyArray = (JSONArray) channel.get("item");
				
				recommendedItem.add(channel.toJSONString());
				
				for (int i = 0; i < bodyArray.size(); i++) {
					JSONObject data = (JSONObject) bodyArray.get(i);
					System.out.println("[" + count + "번 아이템] : " + data.get("title").toString());
					if (i == 0) {
						tempLocation = "&location=" + data.get("latitude") + "," +data.get("longitude");
					}
				}
				count++;
			} else {
				
				urlStr += "https://apis.daum.net/local/v1/search/keyword.json?";
				urlStr += "apikey=d0224817161ef3c311a65c73ea03f837";
				urlStr += "&query=" + session.get("local") + "%20" + item;
				urlStr += "&sort=0"; //0정확도 / 1인기순 / 2거리순
				urlStr += "&count=3";
				urlStr += tempLocation;
				urlStr += "&radius=3000";
				
				System.setProperty("jsse.enableSNIExtension", "false") ;
				URL url = new URL(urlStr);
				InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
				JSONObject object = (JSONObject) JSONValue.parse(isr);
				
				JSONObject channel = (JSONObject) object.get("channel");
				JSONArray bodyArray = (JSONArray) channel.get("item");
				
				recommendedItem.add(channel.toJSONString());
				
				for (int i = 0; i < bodyArray.size(); i++) {
					JSONObject data = (JSONObject) bodyArray.get(i);
					System.out.println("[" + count + "번 아이템] : " + data.get("title").toString());
					if (i == 0) {
						tempLocation = "&location=" + data.get("latitude") + "," +data.get("longitude");
					}//if end
				}//for end
				count++;
			}//else end
		}//for end
		
		return SUCCESS;
	}//valueItemList end
	
	public String blogInfoGet() throws Exception{
		blogInfoReturn = "";
		urlStr = "";
		urlStr += "https://apis.daum.net/search/blog";
		urlStr += "?apikey=8b061e21394885aaa3c204bedd0f494e";
		urlStr += "&q=" + blogItem;
		urlStr += "&output=json";
		
		System.setProperty("jsse.enableSNIExtension", "false") ;
		URL url = new URL(urlStr);
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
		JSONObject object = (JSONObject) JSONValue.parse(isr);
		/*JSONObject channel = (JSONObject) object.get("channel");
		JSONArray item = (JSONArray) channel.get("item");
		JSONObject value = (JSONObject) item.get(0);*/
		
		//System.out.println(channel.toJSONString());
		
		blogInfoReturn = object.get("channel").toString();
		// 블로그 정보 크롤링&파싱 end
		
		
		// 이미지 섬네일을 구하기 위한 요청
		blogInfoReturn2 = "";
		urlStr = "";
		urlStr += "https://apis.daum.net/search/image";
		urlStr += "?apikey=8b061e21394885aaa3c204bedd0f494e";
		urlStr += "&q=" + session.get("local") + "%20" + blogItem;
		urlStr += "&output=json";
		
		System.out.println(urlStr);
		
		System.setProperty("jsse.enableSNIExtension", "false") ;
		url = new URL(urlStr);
		isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
		object = (JSONObject) JSONValue.parse(isr);
		System.out.println(object.toJSONString());
		
		blogInfoReturn2 = object.get("channel").toString();
		
		return SUCCESS;
	}

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

	public String getBlogInfoReturn2() {
		return blogInfoReturn2;
	}

	public void setBlogInfoReturn2(String blogInfoReturn2) {
		this.blogInfoReturn2 = blogInfoReturn2;
	}

	public String getBlogInfoReturn() {
		return blogInfoReturn;
	}

	public void setBlogInfoReturn(String blogInfoReturn) {
		this.blogInfoReturn = blogInfoReturn;
	}

	public String getBlogItem() {
		return blogItem;
	}

	public void setBlogItem(String blogItem) {
		this.blogItem = blogItem;
	}

	public ArrayList<String> getRecommendedItem() {
		return recommendedItem;
	}

	public void setRecommendedItem(ArrayList<String> recommendedItem) {
		this.recommendedItem = recommendedItem;
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

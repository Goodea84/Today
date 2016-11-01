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
	private String local2;
	private Map<String, Object> session;		//세션
	private ArrayList<String> itemList;			//프론트 단에서 넘어오는 아이템 명(URIEncoding)
	private String urlStr;						//외부 API 사용을 위한 주소
	private String roadDetail = "";				//세부 경로 정보
	
	private ArrayList<String> recommendedItem;	//추천경로를 json 타입으로 리턴
	private String blogItem;					//블로그 검색을 위한 아이템 타이틀명(URIEncoding)
	private String blogInfoReturn2;				//블로그 세부정보값을 담은 테이블 <Tag> 리턴
	
	//MapControlAction 기본 생성자
	public MapControlAction() {
	}//MapControlAction 기본 생성자 end
	
	//(장민식) 지역설정 값을 session에 설정(ex: 홍대, 삼청동, 하남)
	public String SessionLocal() {
		session.put("local", local);
		session.put("local2", local2);
		return SUCCESS;
	}//setSessionLocal end
	
	//(장민식) 사용자가 검색하는 추천 아이템 리스트 설정
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
					System.out.print(" | [" + count + "-" + i + "번 아이템]:" + data.get("title").toString());
					if (i == 0) {
						tempLocation = "&location=" + data.get("latitude") + "," +data.get("longitude");
					}//if end
				}//for end
				System.out.println();
				count++;
			} else {
				
				urlStr += "https://apis.daum.net/local/v1/search/keyword.json?";
				urlStr += "apikey=d0224817161ef3c311a65c73ea03f837";
				urlStr += "&query=" + session.get("local") + "%20" + item;
				urlStr += "&sort=0"; //0정확도 / 1인기순 / 2거리순
				urlStr += "&count=3";
				urlStr += tempLocation;
				urlStr += "&radius=2000";
				
				System.setProperty("jsse.enableSNIExtension", "false") ;
				URL url = new URL(urlStr);
				InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
				JSONObject object = (JSONObject) JSONValue.parse(isr);
				
				JSONObject channel = (JSONObject) object.get("channel");
				JSONArray bodyArray = (JSONArray) channel.get("item");
				
				recommendedItem.add(channel.toJSONString());
				
				for (int i = 0; i < bodyArray.size(); i++) {
					JSONObject data = (JSONObject) bodyArray.get(i);
					System.out.print(" | [" + count + "-" + i + "번 아이템]:" + data.get("title").toString());
					if (i == 0) {
						tempLocation = "&location=" + data.get("latitude") + "," +data.get("longitude");
					}//if end
				}//for end
				System.out.println();
				count++;
			}//else end
		}//for end
		
		return SUCCESS;
	}//valueItemList end
	
	//(장민식) 블로그 정보를 호출하기 위한 메소드 
	public String blogInfoGet() throws Exception{
		urlStr = "";
		urlStr += "https://apis.daum.net/search/blog";
		urlStr += "?apikey=24e8e748a9e5aa0afc349746fb967077";
		urlStr += "&q=" + session.get("local") + "%20" + blogItem;
		urlStr += "&output=json";
		urlStr += "&sort=accu";
		
		System.setProperty("jsse.enableSNIExtension", "false") ;
		URL url = new URL(urlStr);
		InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
		JSONObject object = (JSONObject) JSONValue.parse(isr);
		JSONObject channel = (JSONObject) object.get("channel");
		JSONArray item = (JSONArray) channel.get("item");
		//System.out.println(object.toJSONString());
		
		ArrayList<String> blogAuthor = new ArrayList<>();			//블로그 명
		ArrayList<String> blogPubDate = new ArrayList<>();			//블로그 글 작성일
		ArrayList<String> blogDescription = new ArrayList<>();		//블로그 글 요약
		ArrayList<String> blogURL = new ArrayList<>();				//블로그 URL
		
		for (int i = 0; i < 3; i++) {
			JSONObject val = (JSONObject) item.get(i);
			blogAuthor.add((String) val.get("author"));
			blogPubDate.add((String) val.get("pubDate"));
			blogDescription.add(((String) val.get("title")).replace("&lt;b&gt;", "").replace("&lt;/b&gt;", ""));	//<b></b>테그 제거
			blogURL.add((String) val.get("link"));
			
			//System.out.println((String) val.get("author") + "   " + (String) val.get("pubDate") + "   " + ((String) val.get("title")).replace("&lt;b&gt;", "").replace("&lt;/b&gt;", ""));
			//System.out.println((String) val.get("link"));
		}
		// 블로그 정보 크롤링&파싱 end
		
		
		// 이미지 섬네일을 구하기 위한 요청
		blogInfoReturn2 = "";
		urlStr = "";
		urlStr += "https://apis.daum.net/search/image";
		urlStr += "?apikey=24e8e748a9e5aa0afc349746fb967077";
		urlStr += "&q=" + session.get("local") + "%20" + blogItem;
		urlStr += "&output=json";
		urlStr += "&result=3";
		
		System.setProperty("jsse.enableSNIExtension", "false") ;
		url = new URL(urlStr);
		isr = new InputStreamReader(url.openConnection().getInputStream(), "utf-8");
		object = (JSONObject) JSONValue.parse(isr);
		channel = (JSONObject) object.get("channel");
		item = (JSONArray) channel.get("item");
		
		ArrayList<String> blogThumbnail = new ArrayList<>();	//블로그 글 요약
		
		//System.out.println(item.toJSONString());
		
		for (int i = 0; i < item.size(); i++) {
			JSONObject val = (JSONObject) item.get(i);
			blogThumbnail.add((String) val.get("thumbnail"));
		}
		//System.out.println(blogThumbnail.size());

		if (item.size() < 3) {
			for (int i = 0; i <= 3 - item.size(); i++) {
				blogThumbnail.add("image/noImage.png");
			}
		}
		
		/*for (int i = 0; i < blogThumbnail.size(); i++) {
			System.out.println(blogThumbnail.get(i));
		}*/
		
		blogInfoReturn2 = "<div class='col-md-12'><section class='widget' id='overayInDiv'><header>"
							+ "<h4>BLOG Search <span class='fw-semi-bold'>Result</span></h4></header>"
							+ "<div class='widget-body'><table class='table table-hover'>"
							+ "<thead><tr><th>Picture</th><th>Description</th><th class='hidden-xs'>Info</th></tr></thead>"
							+ "<tbody><tr><td><img class='img-rounded' src='"
							+ blogThumbnail.get(0) + "' alt='' height='50'></td>"
							+ "<td><span class='fw-semi-bold'><small><a href='"
							+ blogURL.get(0) + "' target='_blank'>" + blogDescription.get(0) + "</a></small></span></td>"
							+ "<td class='hidden-xs'><p class='no-margin'>"
							+ "<small><span class='fw-semi-bold'>Blog Name:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogAuthor.get(0)
							+ "</span></small></p>"
							+ "<p><small><span class='fw-semi-bold'>Date:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogPubDate.get(0).substring(0, 8)
							+ "</span></small></p></td></tr>"
							+ "<tr><td><img class='img-rounded' src='"
							+ blogThumbnail.get(1) + "' alt='' height='50'></td>"
							+ "<td><span class='fw-semi-bold'><small><a href='"
							+ blogURL.get(1) + "' target='_blank'>" + blogDescription.get(1) + "</a></small></span></td>"
							+ "<td class='hidden-xs'><p class='no-margin'><small>"
							+ "<span class='fw-semi-bold'>Blog Name:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogAuthor.get(1)
							+ "</span></small></p>"
							+ "<p><small><span class='fw-semi-bold'>Date:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogPubDate.get(1).substring(0, 8)
							+ "</span></small></p></td></tr>"
							+ "<tr><td><img class='img-rounded' src='"
							+ blogThumbnail.get(2) + "' alt='' height='50'></td>"
							+ "<td><span class='fw-semi-bold'><small><a href='"
							+ blogURL.get(2) + "' target='_blank'>" + blogDescription.get(2) + "</a></small></span></td>"
							+ "<td class='hidden-xs'><p class='no-margin'><small><span class='fw-semi-bold'>Blog Name:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogAuthor.get(2)
							+ "</span></small></p>"
							+ "<p><small><span class='fw-semi-bold'>Date:</span>"
							+ "<span class='text-semi-muted'>&nbsp; " + blogPubDate.get(2).substring(0, 8)
							+ "</span></small></p></td></tr></tbody></table>"
							+ "<div class='clearfix'>"
							+ "<div class='pull-right'><a href='http://search.daum.net/search?w=blog&nil_search=btn&DA=NTB&enc=utf8&q="
							+ session.get("local") + " " + blogItem + "' target='_blank'>"
							+ "<button class='btn btn-default btn-sm'>Search More</button></a></div>"
							+ "<p>Well...what we gonna do today?</p></div></div></section></div>";
		
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

	public String getLocal2() {
		return local2;
	}

	public void setLocal2(String local2) {
		this.local2 = local2;
	}

	public String getBlogInfoReturn2() {
		return blogInfoReturn2;
	}

	public void setBlogInfoReturn2(String blogInfoReturn2) {
		this.blogInfoReturn2 = blogInfoReturn2;
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

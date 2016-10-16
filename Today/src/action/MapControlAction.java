package action;


import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class MapControlAction extends ActionSupport implements SessionAware{

	private String local;
	private Map<String, Object> session;
	private ArrayList<String> itemList;
	
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

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}

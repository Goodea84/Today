package today.action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class todayAction extends ActionSupport implements SessionAware {

	private Map<String, Object> session;
	private String local;
	private String item1;
	
	public String getLocal() {
		session.put("local", local);
		return SUCCESS;
	}
	
	public String sendItem() {
		System.out.println("등러왔엉");
		item1 = session.get("local") + " " + item1;
		return SUCCESS;
	}

	public String getItem1() {
		return item1;
	}
	
	public void setItem1(String item1) {
		this.item1 = item1;
	}
	

	public void setLocal(String local) {
		this.local = local;
	}

	public Map<String, Object> getSession() {
		return session;
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	
}

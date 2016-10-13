package action;


import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class MapControlAction extends ActionSupport implements SessionAware{

	String local;
	Map<String, Object> session;
	
	public MapControlAction() {
	}
	
	public String setSessionLocal(){
		
		session.put("local", local);
		System.out.println(session.get("local"));
		
		return SUCCESS;
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

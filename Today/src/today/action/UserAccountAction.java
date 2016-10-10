package today.action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;


//유저정보(회원가입, 수정, 탈퇴 등의 Action)
public class UserAccountAction extends ActionSupport implements SessionAware {

	private Map<String, Object> session;
	
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}//setSession end

}//UserAccountAction end

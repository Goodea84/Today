package today.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext ctx = ActionContext.getContext();
		Map<String, Object> session = ctx.getSession();
		String loginid = (String)session.get("loginId");
		System.out.println("LoginInterceptor의 ctx에 의해 호출된 session에서 가져온 아이디: "+loginid);
		String result = "";
		if(loginid==null){
			result = Action.LOGIN;
			System.out.println("===================LoginInterceptor if절");
		}else{
			System.out.println("===================LoginInterceptor else절");
			result = invocation.invoke();
		}
		return result;
	}//intercept
	
}//class

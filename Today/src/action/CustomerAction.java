package action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import today.dao.CustomerDAO;
import today.vo.Customer;

public class CustomerAction extends ActionSupport implements SessionAware{
	
	Customer customer;
	CustomerDAO dao = new CustomerDAO();
	String email;
	String password;
	Map<String, Object> session;
	
	/**
	 * 로그인
	 */
	public String login() throws Exception{
		
		System.out.println("<CustomerAction> login");
		
		customer = dao.selectCustomer(email);
		
		//ID가 없거나 비밀번호가 다르면 로그인 실패
		if (customer == null) {
			return INPUT;
		}
		if (!password.equals(customer.getPassword())) {
			return INPUT;
		}
		
		//로그인 성공하는 경우 세션에 로그인 정보 저장
		session.put("loginId", customer.getName());
		System.out.println("loginId session :"+ session.get("loginId"));

		return SUCCESS;
	}
	
	/**
	 * 로그아웃 처리
	 */
	public String logout() {
		session.clear();
		return SUCCESS;
	}
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public CustomerDAO getDao() {
		return dao;
	}

	public void setDao(CustomerDAO dao) {
		this.dao = dao;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
}

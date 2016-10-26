package action;

import java.util.ArrayList;
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
	ArrayList<Integer> list;
	ArrayList<Customer> flist;
	String content;
	int loginFail;//인터셉터 걸렸을 때, jsp페이지에서 보이기 위한 key값
	
	Map<String, Object> session;
	
	/**
	 * 로그인
	 */
	public String login() throws Exception{
		
		System.out.println("<CustomerAction> login");
		
		customer = dao.selectCustomer(email);
		
		//ID가 없거나 비밀번호가 다르면 로그인 실패
		if (customer == null) {
			loginFail = 1;//비로그인 상태일 때, key값 주기
			return INPUT;
		}
		if (!password.equals(customer.getPassword())) {
			
			return INPUT;
		}
		
		
		//로그인 성공하는 경우 세션에 로그인 정보 저장
		session.put("loginId", customer.getEmail());
		session.put("loginName", customer.getName());
		//System.out.println("loginId session :"+ session.get("loginId"));
		
		//친구리스트
		list = dao.friendList(customer.getCust_id()); 
		//custid로 friendcust_id받아옴
		
		flist = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			customer = dao.selectCustomer2(list.get(i));
			flist.add(customer);
		}
		//System.out.println("flist:"+ flist.get(0).getCust_image());

		return SUCCESS;
	}
	
	/**
	 * 로그아웃 처리
	 */
	public String logout() {
		session.clear();
		return SUCCESS;
	}
	
	
/*	*//**
	 * 친구목록
	 *//*
	public String friendList() {
		String loginId = (String) session.get("loginId");
		customer = dao.selectCustomer(loginId);
		friendList = dao.friendList(customer.getCust_id());
		return SUCCESS;
	}*/
	
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

	public ArrayList<Integer> getList() {
		return list;
	}

	public void setList(ArrayList<Integer> list) {
		this.list = list;
	}

	public ArrayList<Customer> getFlist() {
		return flist;
	}

	public void setFlist(ArrayList<Customer> flist) {
		this.flist = flist;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getLoginFail() {
		return loginFail;
	}

	public void setLoginFail(int loginFail) {
		this.loginFail = loginFail;
	}
	
	

}


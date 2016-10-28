package action;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import today.util.FileService;
import today.dao.CardDAO;
import today.dao.CustomerDAO;
import today.vo.Card;
import today.vo.CardList;
import today.vo.Customer;

public class CardAction extends ActionSupport implements SessionAware{
	
	private CardDAO dao = new CardDAO();
	private CustomerDAO cust_dao = new CustomerDAO();
	private Card card;
	private Customer customer;
	private Customer fcustomer;
	private ArrayList<Integer> list;
	private ArrayList<Customer> flist;
	private ArrayList<Integer> cardidlist;
	private ArrayList<Card> clist;
	Map<String, Object> session;
	
	
	public String movecard(){
		
		//친구리스트
		customer = cust_dao.selectCustomer((String) session.get("loginId"));
		list = cust_dao.friendList(customer.getCust_id());

		flist = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			fcustomer = cust_dao.selectCustomer2(list.get(i));
			flist.add(fcustomer);
		}
		
		//카드리스트
		cardidlist = dao.cardidlist(customer.getCust_id());
		clist = new ArrayList<>();
		for(int i=0;i<cardidlist.size();i++){
			card = dao.cardlist(cardidlist.get(i));
			clist.add(card);
		}
		
		return SUCCESS;
	}
	
	/*
	 * 카드만들기.
	 * 아이템저장, 카드저장, 친구리스트 불러오기, 카드리스트 저장, 카드리스트 불러오기 수행
	 **/
	public String makecard(){

		//아이템 테이블에 아이템 삽입, 아이템 키값 받아옴
		
		//넘어오는 카드 데이터들로 insertCard..... 
		//card = new Card(1, "홍대", 1, 2, 3, 4, 5, "1", 0);
		card = new Card();
		card.setLoca_name("홍대");
		card.setItem1(1);
		card.setItem2(1);
		card.setItem3(1);
		card.setItem4(1);
		card.setItem5(1);
		card.setDate("1");
		dao.insertcard(card);
		
		
		//friendlist...
		customer = cust_dao.selectCustomer((String) session.get("loginId"));
		list = cust_dao.friendList(customer.getCust_id());

		flist = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			fcustomer = cust_dao.selectCustomer2(list.get(i));
			flist.add(fcustomer);
		}
		
		// cardlist에 card,custid 추가 !
		
		//카드리스트 객체 만들어 보낸다.
		CardList cardlist = new CardList();
		cardlist.setCard_id(card.getCard_id());
		cardlist.setCust_id(customer.getCust_id());
		dao.insertcardlist(cardlist);
		
	//cardlist 조회해서 cardid 리스트 받아와서 cardid 하나하나에 해당하는 card를 받아와 arraylist에 저장. 이거 이제 뿌려주면 됨....!
		cardidlist = dao.cardidlist(customer.getCust_id());
		clist = new ArrayList<>();
		for(int i=0;i<cardidlist.size();i++){
			card = dao.cardlist(cardidlist.get(i));
			clist.add(card);
		}
		
		return SUCCESS;
	}
	
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}


	public Customer getCustomer() {
		return customer;
	}


	public void setCustomer(Customer customer) {
		this.customer = customer;
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


	public Customer getFcustomer() {
		return fcustomer;
	}


	public void setFcustomer(Customer fcustomer) {
		this.fcustomer = fcustomer;
	}


	public ArrayList<Integer> getCardidlist() {
		return cardidlist;
	}


	public void setCardidlist(ArrayList<Integer> cardidlist) {
		this.cardidlist = cardidlist;
	}


	public ArrayList<Card> getClist() {
		return clist;
	}


	public void setClist(ArrayList<Card> clist) {
		this.clist = clist;
	}
	
	
}

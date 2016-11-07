package action;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.opensymphony.xwork2.ActionSupport;

import today.util.FileService;
import today.dao.CardDAO;
import today.dao.CustomerDAO;
import today.vo.Card;
import today.vo.CardList;
import today.vo.Customer;
import today.vo.Item;
import today.vo.Reply;

public class CardAction extends ActionSupport implements SessionAware{
	
	Map<String, Object> session;
	private CardDAO dao = new CardDAO();
	private CustomerDAO cust_dao = new CustomerDAO();
	private Card card;
	private Customer customer;
	private Customer fcustomer;
	private ArrayList<Integer> list;
	private ArrayList<Customer> flist;
	private ArrayList<Integer> cardidlist;
	private ArrayList<Item> itemlist;
	private ArrayList<Reply> replylist1;
	private ArrayList<Reply> replylist2;
	private ArrayList<Reply> replylist3;
	private ArrayList<Reply> replylist4;
	private ArrayList<Reply> replylist5;
	
	private ArrayList<Card> clist;
	private int card_id;
	private Reply reply;
	
	//카드 보낼 때 중복체크하는 변수
	private boolean checkCard;
	private String cust_img; //댓글 입력 이미지
	
	private String makeCard;
	private ArrayList<Integer> itemidlist;
	private Item item;
	
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
	public String makecard() throws Exception{

		//아이템 테이블에 아이템 삽입, 아이템 키값 받아옴
		
		JSONArray  object =  (JSONArray) JSONValue.parse(makeCard);
		
		
		System.out.println(object.size());
		
		itemidlist = new ArrayList<>();
		
		for (int i = 0; i < object.size(); i++) {
			JSONObject getitem = (JSONObject) object.get(i);
			System.out.println((i + 1) + "번 아이템: " + getitem.get("title").toString());
			Item item2 = new Item(0, getitem.get("title").toString(), Double.parseDouble(getitem.get("latitude").toString()), Double.parseDouble(getitem.get("longitude").toString()), getitem.get("address").toString(), getitem.get("phone").toString(),0);
			dao.insertitem(item2);
			itemidlist.add(item2.getItem_id());
		}
		
		//int item_id1 = dao.insertitem(item);
		
		
		//넘어오는 카드 데이터들로 insertCard..... 
		card = new Card();
		
		System.out.println("local :" + (String) session.get("local2"));

		card.setCard_id(0);
		card.setDate("1");
		card.setLoca_name((String) session.get("local2"));
		card.setRecommend(0);
		
		
		card.setItem1(itemidlist.get(0));
		card.setItem2(itemidlist.get(1));
		
		if(itemidlist.size()==3){
			System.out.println("3개입력");
			card.setItem3(itemidlist.get(2));
		}
		if(itemidlist.size()==4){
			System.out.println("4개입력");
			card.setItem3(itemidlist.get(2));
			card.setItem4(itemidlist.get(3));
		}
		if(itemidlist.size()==5){
			System.out.println("5개입력");
			card.setItem3(itemidlist.get(2));
			card.setItem4(itemidlist.get(3));
			card.setItem5(itemidlist.get(4));
		}
		
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
	
	
	
	
	/*
	 * 타임라인 이동
	 * 친구리스트, 카드에 대한 아이템 갯수 당 한 노드 표현해주기.
	 **/
	public String movetimeline(){
		System.out.println("<ACTION> movetimeline");
		//friendlist
		customer = cust_dao.selectCustomer((String) session.get("loginId"));
		list = cust_dao.friendList(customer.getCust_id());

		flist = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			fcustomer = cust_dao.selectCustomer2(list.get(i));
			flist.add(fcustomer);
		}
		
		cust_img = customer.getCust_image();

		//카드 아이디 이용하여 전체 카드 객체 받아오기
		card = dao.cardlist(card_id);

		//카드객체의 아이템1-5 arraylist 담기
		
		itemlist = new ArrayList<>();
		replylist1 = new ArrayList<>();
		replylist2 = new ArrayList<>();
		replylist3 = new ArrayList<>();
		replylist4 = new ArrayList<>();
		replylist5 = new ArrayList<>();
		
		//item id 이용해서 item객체,reply객체 받아오기.
		if(card.getItem1()!=0){
			Item item = dao.selectItem(card.getItem1());
			System.out.println("=============="+item.getItem_id());
			item = dao.selectItem(card.getItem1());
			item.setIterator_id(1);
			itemlist.add(item);
			replylist1.addAll(dao.selectReply(card.getItem1()));
			
			for (int i = 0; i < replylist1.size(); i++) {
				customer = cust_dao.selectCustomer2(replylist1.get(i).getCust_id());
				replylist1.get(i).setRe_name(customer.getName());
				replylist1.get(i).setRe_image(customer.getCust_image());
			}
		}
		if(card.getItem2()!=0){
			item = dao.selectItem(card.getItem2());
			item.setIterator_id(2);
			itemlist.add(item);
			replylist2.addAll(dao.selectReply(card.getItem2()));
			
			for (int i = 0; i < replylist2.size(); i++) {
				customer = cust_dao.selectCustomer2(replylist2.get(i).getCust_id());
				replylist2.get(i).setRe_name(customer.getName());
				replylist2.get(i).setRe_image(customer.getCust_image());
			}
		}		
		if(card.getItem3()!=0){
			item = dao.selectItem(card.getItem3());
			item.setIterator_id(3);
			itemlist.add(item);
			replylist3.addAll(dao.selectReply(card.getItem3()));
			
			for (int i = 0; i < replylist3.size(); i++) {
				customer = cust_dao.selectCustomer2(replylist3.get(i).getCust_id());
				replylist3.get(i).setRe_name(customer.getName());
				replylist3.get(i).setRe_image(customer.getCust_image());
			}
		}		
		if(card.getItem4()!=0){
			item = dao.selectItem(card.getItem4());
			item.setIterator_id(4);
			itemlist.add(item);
			replylist4.addAll(dao.selectReply(card.getItem4()));
			
			for (int i = 0; i < replylist4.size(); i++) {
				customer = cust_dao.selectCustomer2(replylist4.get(i).getCust_id());
				replylist4.get(i).setRe_name(customer.getName());
				replylist4.get(i).setRe_image(customer.getCust_image());
			}
		}		
		if(card.getItem5()!=0){
			item = dao.selectItem(card.getItem5());
			item.setIterator_id(5);
			itemlist.add(item);
			replylist5.addAll(dao.selectReply(card.getItem5()));
			
			for (int i = 0; i < replylist5.size(); i++) {
				customer = cust_dao.selectCustomer2(replylist5.get(i).getCust_id());
				replylist5.get(i).setRe_name(customer.getName());
				replylist5.get(i).setRe_image(customer.getCust_image());
			}
		}
		return SUCCESS;
	}
	
	//친구에게 카드를 보내는 코드
	public String cardAdd() throws Exception{
		
		System.out.println(customer.getCust_id());
		System.out.println(card.getCard_id());
		System.out.println("customer_id" + customer.getCust_id());
		System.out.println("cust_id" + customer.getCust_id());
		
		cardidlist = dao.cardidlist(customer.getCust_id());
		customer = cust_dao.selectCustomer2(customer.getCust_id());
		
		for(int i : cardidlist){
			
			System.out.println("카드 번호 : " + i);
			
			if(i==card.getCard_id()){
				System.out.println("카드 중복입니다.");
				checkCard = true;
				return SUCCESS;
			} 
		}
		
		CardList sendcard = new CardList(0, customer.getCust_id(), card.getCard_id());
		dao.insertcardlist(sendcard);
		System.out.println("카드를 보냅니다.");
		
		return SUCCESS;
	}
	
	
	//리플입력
	
	public String makereply() throws Exception{
		
		
		customer = cust_dao.selectCustomer((String) session.get("loginId"));
		reply.setCust_id(customer.getCust_id());
		
		dao.insertreply(reply);
		
		reply = dao.selectoneReply(reply.getReply_id());
		reply.setRe_name(customer.getName());
		reply.setRe_image(customer.getCust_image());
		
		
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

	public int getCard_id() {
		return card_id;
	}

	public void setCard_id(int card_id) {
		this.card_id = card_id;
	}

	public ArrayList<Item> getItemlist() {
		return itemlist;
	}

	public void setItemlist(ArrayList<Item> itemlist) {
		this.itemlist = itemlist;
	}

	public Reply getReply() {
		return reply;
	}

	public void setReply(Reply reply) {
		this.reply = reply;
	}

	public ArrayList<Reply> getReplylist1() {
		return replylist1;
	}

	public void setReplylist1(ArrayList<Reply> replylist1) {
		this.replylist1 = replylist1;
	}

	public ArrayList<Reply> getReplylist2() {
		return replylist2;
	}

	public void setReplylist2(ArrayList<Reply> replylist2) {
		this.replylist2 = replylist2;
	}

	public ArrayList<Reply> getReplylist3() {
		return replylist3;
	}

	public void setReplylist3(ArrayList<Reply> replylist3) {
		this.replylist3 = replylist3;
	}

	public ArrayList<Reply> getReplylist4() {
		return replylist4;
	}

	public void setReplylist4(ArrayList<Reply> replylist4) {
		this.replylist4 = replylist4;
	}

	public ArrayList<Reply> getReplylist5() {
		return replylist5;
	}

	public void setReplylist5(ArrayList<Reply> replylist5) {
		this.replylist5 = replylist5;
	}

	public String getCust_img() {
		return cust_img;
	}

	public void setCust_img(String cust_img) {
		this.cust_img = cust_img;
	}




	public boolean isCheckCard() {
		return checkCard;
	}

	public void setCheckCard(boolean checkCard) {
		this.checkCard = checkCard;
	}

	public String getMakeCard() {
		return makeCard;
	}

	public void setMakeCard(String makeCard) {
		this.makeCard = makeCard;
	}

	public ArrayList<Integer> getItemidlist() {
		return itemidlist;
	}

	public void setItemidlist(ArrayList<Integer> itemidlist) {
		this.itemidlist = itemidlist;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}
	
	

}

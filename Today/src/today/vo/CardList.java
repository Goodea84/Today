package today.vo;

public class CardList {
	
	private int cardlist_id;
	private int cust_id;
	private int card_id;
	public CardList() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CardList(int cardlist_id, int cust_id, int card_id) {
		super();
		this.cardlist_id = cardlist_id;
		this.cust_id = cust_id;
		this.card_id = card_id;
	}
	public int getCardlist_id() {
		return cardlist_id;
	}
	public void setCardlist_id(int cardlist_id) {
		this.cardlist_id = cardlist_id;
	}
	public int getCust_id() {
		return cust_id;
	}
	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}
	public int getCard_id() {
		return card_id;
	}
	public void setCard_id(int card_id) {
		this.card_id = card_id;
	}

	
}

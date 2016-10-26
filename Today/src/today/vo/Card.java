package today.vo;

public class Card {
	private int card_id;
	private String loca_name;
	private int item1;
	private int item2;
	private int item3;
	private int item4;
	private int item5;
	private String card_date;
	private int recommend;
	public Card() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Card(int card_id, String loca_name, int item1, int item2, int item3, int item4, int item5, String card_date,
			int recommend) {
		super();
		this.card_id = card_id;
		this.loca_name = loca_name;
		this.item1 = item1;
		this.item2 = item2;
		this.item3 = item3;
		this.item4 = item4;
		this.item5 = item5;
		this.card_date = card_date;
		this.recommend = recommend;
	}
	public int getCard_id() {
		return card_id;
	}
	public void setCard_id(int card_id) {
		this.card_id = card_id;
	}
	public String getLoca_name() {
		return loca_name;
	}
	public void setLoca_name(String loca_name) {
		this.loca_name = loca_name;
	}
	public int getItem1() {
		return item1;
	}
	public void setItem1(int item1) {
		this.item1 = item1;
	}
	public int getItem2() {
		return item2;
	}
	public void setItem2(int item2) {
		this.item2 = item2;
	}
	public int getItem3() {
		return item3;
	}
	public void setItem3(int item3) {
		this.item3 = item3;
	}
	public int getItem4() {
		return item4;
	}
	public void setItem4(int item4) {
		this.item4 = item4;
	}
	public int getItem5() {
		return item5;
	}
	public void setItem5(int item5) {
		this.item5 = item5;
	}
	public String getDate() {
		return card_date;
	}
	public void setDate(String card_date) {
		this.card_date = card_date;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	
	
}
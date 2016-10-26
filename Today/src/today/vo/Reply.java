package today.vo;

public class Reply {
	private int peply_id;
	private int cust_id;
	private int item_id;
	private String content;
	private String re_date;
	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Reply(int peply_id, int cust_id, int item_id, String content, String re_date) {
		super();
		this.peply_id = peply_id;
		this.cust_id = cust_id;
		this.item_id = item_id;
		this.content = content;
		this.re_date = re_date;
	}
	public int getPeply_id() {
		return peply_id;
	}
	public void setPeply_id(int peply_id) {
		this.peply_id = peply_id;
	}
	public int getCust_id() {
		return cust_id;
	}
	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}
	
	
}

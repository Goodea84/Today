package today.vo;

public class Reply {
	private int reply_id;
	private int cust_id;
	private int item_id;
	private String content;
	private String re_date;
	private String re_image; //table에는 없음
	private String re_name; //table에는 없음
	
	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Reply(int reply_id, int cust_id, int item_id, String content, String re_date, String re_image,
			String re_name) {
		super();
		this.reply_id = reply_id;
		this.cust_id = cust_id;
		this.item_id = item_id;
		this.content = content;
		this.re_date = re_date;
		this.re_image = re_image;
		this.re_name = re_name;
	}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
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

	public String getRe_image() {
		return re_image;
	}

	public void setRe_image(String re_image) {
		this.re_image = re_image;
	}

	public String getRe_name() {
		return re_name;
	}

	public void setRe_name(String re_name) {
		this.re_name = re_name;
	}

	
	
}

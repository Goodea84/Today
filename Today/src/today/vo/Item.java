package today.vo;

public class Item {
	
	private int item_id;
	private String item_name;
	private double item_x;
	private double item_y;
	private String linked;
	private String item_phone;
	private String image;
	public Item() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Item(int item_id, String item_name, double item_x, double item_y, String linked, String item_phone,
			String image) {
		super();
		this.item_id = item_id;
		this.item_name = item_name;
		this.item_x = item_x;
		this.item_y = item_y;
		this.linked = linked;
		this.item_phone = item_phone;
		this.image = image;
	}
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public double getItem_x() {
		return item_x;
	}
	public void setItem_x(double item_x) {
		this.item_x = item_x;
	}
	public double getItem_y() {
		return item_y;
	}
	public void setItem_y(double item_y) {
		this.item_y = item_y;
	}
	public String getLinked() {
		return linked;
	}
	public void setLinked(String linked) {
		this.linked = linked;
	}
	public String getItem_phone() {
		return item_phone;
	}
	public void setItem_phone(String item_phone) {
		this.item_phone = item_phone;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	
}
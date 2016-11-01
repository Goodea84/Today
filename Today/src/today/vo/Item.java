package today.vo;

public class Item {
	
	private int item_id;
	private String title;
	private double item_x;
	private double item_y;
	private String address;
	private String phone;
	private int iterator_id;

	public Item() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Item(int item_id, String title, double item_x, double item_y, String address, String phone,
			int iterator_id) {
		super();
		this.item_id = item_id;
		this.title = title;
		this.item_x = item_x;
		this.item_y = item_y;
		this.address = address;
		this.phone = phone;
		this.iterator_id = iterator_id;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getIterator_id() {
		return iterator_id;
	}

	public void setIterator_id(int iterator_id) {
		this.iterator_id = iterator_id;
	}
	
	
}
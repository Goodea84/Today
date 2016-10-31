package today.vo;

public class Image {
	private int image_id;
	private int cust_id;
	private int item_id;
	private String photo;
	
	public Image() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Image(int image_id, int cust_id, int item_id, String photo) {
		super();
		this.image_id = image_id;
		this.cust_id = cust_id;
		this.item_id = item_id;
		this.photo = photo;
	}
	public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
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
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	@Override
	public String toString() {
		return "Image [image_id=" + image_id + ", cust_id=" + cust_id + ", item_id=" + item_id + ", photo=" + photo
				+ "]";
	}
	
	

}
package today.vo;

public class Customer {
	int cust_id;
	String email;
	String name;
	String password;
	String address;
	String phone;
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Customer(int cust_id, String email, String name, String password, String address, String phone) {
		super();
		this.cust_id = cust_id;
		this.email = email;
		this.name = name;
		this.password = password;
		this.address = address;
		this.phone = phone;
	}
	public int getCust_id() {
		return cust_id;
	}
	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	
	
}

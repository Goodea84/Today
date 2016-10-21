package today.vo;

public class FriendList {
	
	private int friendlist_id;
	private int mycust_id;
	private int friendcust_id;
	
	public FriendList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FriendList(int friendlist_id, int mycust_id, int friendcust_id) {
		super();
		this.friendlist_id = friendlist_id;
		this.mycust_id = mycust_id;
		this.friendcust_id = friendcust_id;
	}

	public int getFriendlist_id() {
		return friendlist_id;
	}

	public void setFriendlist_id(int friendlist_id) {
		this.friendlist_id = friendlist_id;
	}

	public int getMycust_id() {
		return mycust_id;
	}

	public void setMycust_id(int mycust_id) {
		this.mycust_id = mycust_id;
	}

	public int getFriendcust_id() {
		return friendcust_id;
	}

	public void setFriendcust_id(int friendcust_id) {
		this.friendcust_id = friendcust_id;
	}
	
	
}

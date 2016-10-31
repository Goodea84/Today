package action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;

import today.dao.CustomerDAO;
import today.dao.FileDAO;
import today.util.FileService;
import today.vo.Customer;
import today.vo.Image;

public class FileUploadAction extends ActionSupport implements ServletRequestAware, SessionAware {

	Map<String, Object> session;//로그인 회원 정보 가져오는 session
	private String userImageContentType;
	private ArrayList<File> userImage = new ArrayList<>();//File 정보
	private ArrayList<String> userImageFileName = new ArrayList<>();//업로드 하는 사진 파일이름
	private HashMap<Integer, Integer> map_itemNo = new HashMap<>();//item_no담는 맵
	private HashMap<Integer, String> map_savedFile = new HashMap<>();//DB에 저장되는 경로명 담는 맵
	private List<Image> list_image;//DB에 저장된 파일명 담아 페이지 열릴 때 뿌리는 데 쓰임
	private HttpServletRequest servletRequest;//파일 저장경로 받기 위함
	private int item_number;//저장할 때 time_line 페이지에서 받아오는 item_no
	
	/**
	 * (2개 이상 가능)사진 저장하는 메소드
	 */
	public String execute() throws IOException{
		FileService fs = new FileService();
		Image image = new Image();
		FileDAO dao = new FileDAO();
		CustomerDAO cust_dao = new CustomerDAO();
		Customer cust = cust_dao.selectCustomer((String)session.get("loginId"));
		if(userImage!=null){
			for(int i=0; i<userImageFileName.size(); i++){
				String realPath = servletRequest.getSession().getServletContext().getRealPath("/");
				String basePath = realPath + "image/" + (String)session.get("loginId") + "/" + item_number;
				System.out.println("Server path:" + basePath);
				//보안을 위해서는 사용자 아이디도 암호화하여 저장할 필요가 있지만, 그건 나중에 하도록...
				String savedFile = fs.saveFile(userImage.get(i), basePath, userImageFileName.get(i));
				//jsp에서 각 아이템 노드 마다 뿌려주기 위해 itemNo와 저장된 파일 주소를 map에 넣어 넘김
				map_itemNo.put(i, item_number);
				map_savedFile.put(i, savedFile);
				image.setPhoto(savedFile);
				image.setCust_id(cust.getCust_id());
				image.setItem_id(item_number);
				dao.insert(image);
			}//for
		}//if
		return SUCCESS;
	}//execute
	
	/**
	 * 페이지 열릴 때 호출되는 메소드. 카드에 맞는 사진을 담아 가져감
	 */
	public String printAll(){
		FileDAO dao = new FileDAO();
		CustomerDAO cust_dao = new CustomerDAO();
		Customer cust = cust_dao.selectCustomer((String)session.get("loginId"));
		list_image = dao.printAll(cust.getCust_id());
//		System.out.println(list_image);
		return SUCCESS;
	}//printAll
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}


	public ArrayList<File> getUserImage() {
		return userImage;
	}


	public void setUserImage(ArrayList<File> userImage) {
		this.userImage = userImage;
	}


	public ArrayList<String> getUserImageFileName() {
		return userImageFileName;
	}


	public void setUserImageFileName(ArrayList<String> userImageFileName) {
		this.userImageFileName = userImageFileName;
	}
	
	public String getUserImageContentType() {
		return userImageContentType;
	}

	public void setUserImageContentType(String userImageContentType) {
		this.userImageContentType = userImageContentType;
	}

	public List<Image> getList_image() {
		return list_image;
	}

	public void setList_image(List<Image> list_image) {
		this.list_image = list_image;
	}

	public int getItem_number() {
		return item_number;
	}

	public void setItem_number(int item_number) {
		this.item_number = item_number;
	}

	public HashMap<Integer, Integer> getMap_itemNo() {
		return map_itemNo;
	}

	public void setMap_itemNo(HashMap<Integer, Integer> map_itemNo) {
		this.map_itemNo = map_itemNo;
	}

	public HashMap<Integer, String> getMap_savedFile() {
		return map_savedFile;
	}

	public void setMap_savedFile(HashMap<Integer, String> map_savedFile) {
		this.map_savedFile = map_savedFile;
	}

	@Override
	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}
	
}//class

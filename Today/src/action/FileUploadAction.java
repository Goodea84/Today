package action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;
import today.dao.FileDAO;
import today.util.FileService;
import today.vo.Image;

public class FileUploadAction extends ActionSupport implements ServletRequestAware ,SessionAware {

	Map<String, Object> session;
	
	private String userImageContentType;
	private ArrayList<File> userImage = new ArrayList<>();
	private ArrayList<String> userImageFileName = new ArrayList<>();
	
	private ArrayList<String> list_savedFile = new ArrayList<>();
	
	private List<Image> list_image;
	
	private HttpServletRequest servletRequest;
	
	
	public String execute() throws IOException{
		FileService fs = new FileService();
		Image image = new Image();
		FileDAO dao = new FileDAO();
		if(userImage!=null){
			for(int i=0; i<userImageFileName.size(); i++){
				//String basePath = "/Users/user/git/Today/Today/WebContent/image"; //혜선이랑 연결하면 사용자 아이디 별로 다르게 폴더 생성 필요
				String basePath = servletRequest.getSession().getServletContext().getRealPath("/");
				System.out.println("Server path:" + basePath);
				//보안을 위해서는 사용자 아이디도 암호화하여 저장할 필요가 있지만, 그건 나중에 하도록...
				String savedFile = fs.saveFile(userImage.get(i), basePath+"image", userImageFileName.get(i));
				list_savedFile.add(savedFile);
				image.setPhoto(savedFile);
				//String loginId = (String)session.get("loginId");
				//int num_loginId = Integer.parseInt(loginId);
				image.setCust_id(1);//session에서 로그인 아이디 받아야함. 일단 임시값
				image.setItem_id(1);//item_id jsp에서 받아와야 함! 일단 임시값
				dao.insert(image);
			}//for
		}//if
		
		return SUCCESS;
	}//execute
	
	public String printAll(){
		//System.out.println("프린트올들어옴");
		FileDAO dao = new FileDAO();
		list_image = dao.printAll();
		//System.out.println(list_image);
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

	public ArrayList<String> getList_savedFile() {
		return list_savedFile;
	}

	public void setList_savedFile(ArrayList<String> list_savedFile) {
		this.list_savedFile = list_savedFile;
	}

	@Override
	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}
	
}//class

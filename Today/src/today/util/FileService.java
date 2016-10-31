package today.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

//업로드한 파일 저장 & 저장된 파일 삭제
public class FileService {
	/**
	 * File객체, 저장할 경로, 파일명을 전달받아 서버에 파일 저장
	 * @param file	서버에 임시로 업로드된 파일 객체
	 * @param basePath	저장할 경로
	 * @param filename	서버에 임시로 업로드된 파일의 이름
	 * @return	변경 저장된 파일의 이름
	 * @throws IOException
	 */
	public String saveFile(File file, String basePath, String filename) throws IOException {
		//파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (file == null || file.length() <= 0) {
			return null; 
		}
		
		/**
		 * 저장디렉토리가 없는 경우 생성하기 위함
		 * File을 실제로 생성하는게 아닌, 생성하기 전 단계
		 * @basePath : 저장할 디렉토리 공간. 그 공간이 있는지 물어보는 과정
		 */
		File dir = new File(basePath);
		if (!dir.isDirectory()) dir.mkdirs();
		/**
		 * if문 안에서 디렉토리가 존재하는지 확인하여 없으면 만들어줌
		 * @dir.mkdir은 디렉토리 하나만
		 * @dir.mkdirs는 서브디렉토리까지 다 만들어줌
		 * 즉, user.properties에서 지정해 놓은 directory주소를 서브까지 지정해줄 경우 mkdirs를 쓰면 됨
		 * 저장위치는 내가 작업하고 있는 공간. 즉, c://가 루트가 되어 폴더가 생성됨
		 */
		
		
		/**
		 * 저장할 파일명을 년/월/일로 생성
		 * UUID클래스를 이용해 난수 발생(절대 중복이 생기지 않음) eg>spring.jpg ==> springXXXXXXXXXX.jpg
		 */
		String savedFilename;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		savedFilename = sdf.format(new Date());
		
		
		//원본 파일의 확장자
		String ext;//원본 파일의 확장자 보존을 위해 만드는 변수
		int lastIndex = filename.lastIndexOf('.');//lastIndexOf():파일명에 여러개의 점이 있으면 마지막 점을 찾음. 인덱스는 무조건 0부터
		if (lastIndex == -1)//확장자가 없는 파일이면,
			ext = "";
		else 
			ext = "." + filename.substring(lastIndex + 1);//원본 파일명 저장
		//e.g> blah.jpg일 경우 lastIndex는 4를 반환하여, substring(lastIndex+1)을 쓰면 j부터 끝까지를 가져옴.

		//저장할 전체 경로
		String serverFullPath = null;
		File serverFile = null;
		
		//같은 이름의 파일이 있는 경우의 처리 (뒤에 시간정보 붙임)
		while (true) {
			//serverFilename = strDate + ext;
			serverFullPath = basePath + "/" + savedFilename + ext;
			//serverFullpath = "/uploadpath/20160831.jpg"
			serverFile = new File(serverFullPath); 
			//db에 저장될 실제파일명을 만들어주고 그파일명이 있는지 검사
			//new File()을 만들면서 확장자가 들어가면 File type의 객체가 만들어짐. 이 때는 아무것도 들어있지 않은 빈 껍데기
			
			//생성된 File객체의 이름과 같은지 검사
			if (!serverFile.isFile()) break;	//같은 이름의 파일이 없으면 break로 나감.
			savedFilename = savedFilename + new Date().getTime(); //이름이 존재(중복)하면 시각을 덧붙임
		}
		
		//파일 저장
		FileInputStream in = new FileInputStream(file);//파일을 읽고
		FileOutputStream out = new FileOutputStream(serverFile);//만들어놓은 file객체에 내용을 저장
		
		int bytesRead = 0;
		byte[] buffer = new byte[1024];//공간 확보
		/**
		 * @in.read() : 읽어들인 data(file)를 buffer에 넣고, 0번부터 1024(최대값)까지 읽는다는 의미
		 * eg> 3000byte짜리 파일이라면 1024b씩 2번 읽고, 52b가 남는데, 이 때 남은 공간만 정확히 맞춰주려면 buffer.length를 넣어줌
		 * in.read()로 읽어들이고 그 값이 bytesRead에 전달됨. 3000b일 때 1024b씩 두번, 나머지 값이 저장되어 총 3번 반복
		 */
		while ((bytesRead = in.read(buffer, 0, 1024)) != -1) { //더이상읽을게없을때 -1을 반환함
			out.write(buffer, 0, bytesRead); //buffer에 있는 것을 0번 위치부터 bytesRead만큼(딱 맞게) 저장한다.
											//bytesRead 대신 1024를 넣으면, 3000-2048빼고 나머지의 값이 들어가고, 그 이후로는 남아있는 데이터가 들어가 파일이 손상된다.
		}
		
		//다 쓰면 닫아준다.
		out.close();
		in.close();
		
		//실제 저장된 파일의 이름을 리턴 
		return savedFilename + ext;
	}//saveFile
	
	
	/**
	 * 서버에 저장된 파일을 삭제
	 * @param fullpath 저장된 파일의 전체 경로
	 * @return 삭제 성공 여부
	 */
	public boolean fileDelete(String fullpath) {
		boolean check = false;
		
		try {
			File file = new File(fullpath);
			if (file.isFile()) {
				file.delete();
				check = true;
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		return check;
	}
}

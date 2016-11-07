package today.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import today.vo.Image;

public class FileDAO {
	
	/**
	 * 파일 저장
	 * @param image : FileUploadAction에서 생성해 받아온 Image객체
	 */
	public void insert(Image image){
		SqlSession ss = MybatisConfig.getSqlSessionFactory().openSession();
		try {
			ss.insert("FileMapper.insert", image);
			ss.commit();
		} catch (Exception e) {
			e.printStackTrace();
			ss.rollback();
		} finally {
			if(ss!=null)ss.close();
		}
	}//insert
	
	/**
	 * 페이지 호출될 때마다 DB에서 카드에 담겨있는 이미지 주소를 받아옴
	 * @param cust_id : 회원 seq
	 * @return List<Image> : 해당되는 Image 객체
	 */
	public List<Image> printAll(HashMap<String, Object> map){
		List<Image> list_image = null;
		SqlSession ss = MybatisConfig.getSqlSessionFactory().openSession();
		try {
			list_image = ss.selectList("FileMapper.printAll", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ss!=null)ss.close();
		}
		return list_image;
	}//printAll
	
}//FileDAO

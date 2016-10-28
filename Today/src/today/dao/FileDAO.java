package today.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import today.vo.Image;

public class FileDAO {
	
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
	
	public List<Image> printAll(){
		List<Image> list_image = null;
		SqlSession ss = MybatisConfig.getSqlSessionFactory().openSession();
		try {
			list_image = ss.selectList("FileMapper.printAll");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ss!=null)ss.close();
		}
		return list_image;
	}//printAll
	
}//FileDAO

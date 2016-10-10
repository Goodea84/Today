package today.dao;

import org.apache.ibatis.session.SqlSession;

public class AccountDAO {

	private SqlSession sqlsession;
	
	//회원가입 DAO메소드
	public int insertUserAccount() {
		sqlsession = MybatisConfig.getSqlSessionFactory().openSession();
		int result = 0;
		
		return result;
	}//insertUserAccount end
	
}//AccountDAO end

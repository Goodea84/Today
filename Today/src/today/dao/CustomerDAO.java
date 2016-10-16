package today.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import today.vo.Customer;

public class CustomerDAO {

	private SqlSessionFactory factory = MybatisConfig.getSqlSessionFactory();
	

	
	/**
	 * 로그인
	 * email(ID)을 전달받아 해당되는 고객의 정보를 읽는다.
	 * @param email 검색할 고객 이메일(아이디)
	 * @return 검색된 고객 정보. 해당되는 email이 없는 경우 null 리턴.
	 */
	
	public Customer selectCustomer(String email) {
		System.out.println("<DAO> selectCustomer");
		System.out.println("email : "+email);
		SqlSession ss = null;
		Customer customer = null;
		
		try {
			ss = factory.openSession();
			customer = ss.selectOne("CustomerMapper.selectCustomer", email);
			ss.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (ss != null) ss.close();
		}
		
		return customer;
	} // selectCustomer end


	
}//AccountDAO end

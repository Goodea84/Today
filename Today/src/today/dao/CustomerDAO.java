package today.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import action.CustomerAction;
import today.vo.Customer;
import today.vo.FriendList;

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


	/**
	 * 친구 목록(친구목록1)
	 * @param custid 로그인한 user ID key 값
	 * @return 해당 user의 friendcust_id
	 */
	public ArrayList<Integer> friendList(int custid) {
		
		System.out.println("<DAO> listFriend");
		SqlSession ss = null;
		ArrayList<Integer> result=null;
		
		try {
			ss = factory.openSession();
			result = (ArrayList) ss.selectList("CustomerMapper.friendList", custid);
			System.out.println("result: "+result.size());
			ss.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (ss != null) ss.close();
		}
		return result;
	}
	
	/**
	 * 팔뤄워수
	 * @param custid 로그인한 user ID key 값
	 * @return 해당 user의 friendcust_id
	 */
	public int follower (int custid) {
		
		System.out.println("<DAO> follower");
		SqlSession ss = null;
		int result=0;
		
		try {
			ss = factory.openSession();
			result = (int) ss.selectOne("CustomerMapper.follower", custid);
			ss.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (ss != null) ss.close();
		}
		return result;
	}

	
	/**
	 * 친구객체 (친구목록2)
	 * custid(key)을 전달받아 해당되는 고객의 정보를 읽는다.
	 * @param custid 검색할 고객 키(아이디)
	 * @return 검색된 고객 정보. 해당되는 custid가 없는 경우 null 리턴.
	 */
	
	public Customer selectCustomer2(int custid) {
		System.out.println("<DAO> selectCustomer2");
		SqlSession ss = null;
		Customer customer = null;
		
		try {
			ss = factory.openSession();
			customer = ss.selectOne("CustomerMapper.selectCustomer2", custid);
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

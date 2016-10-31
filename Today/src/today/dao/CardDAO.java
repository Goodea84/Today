package today.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import today.vo.Card;
import today.vo.CardList;
import today.vo.Item;
import today.vo.Reply;

public class CardDAO {
	private SqlSessionFactory factory = MybatisConfig.getSqlSessionFactory();

	
	/**
	 * 카드생성
	 * @param card 생성할 카드객체
	 */
	public int insertcard(Card card) {
		
		System.out.println("<DAO> insertcard");
		SqlSession ss = null;
		int result = 0;
		
		try {
			ss = factory.openSession();
			result = ss.insert("CardMapper.insertcard", card);
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
	 * 카드아이디리스트
	 * @return result : 모든 카드리스트
	 */
	public ArrayList<Integer> cardidlist(int custid) {
		
		System.out.println("<DAO> cardidlist");
		ArrayList<Integer> result = null;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			result = (ArrayList)ss.selectList("CardMapper.cardidlist",custid);
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
	 * 카드리스트생성
	 * @param cardlist
	 */
	public void insertcardlist(CardList cardlist) {
		
		System.out.println("<DAO> insertcardlist");
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			ss.insert("CardMapper.insertcardlist",cardlist);
			ss.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (ss != null) ss.close();
		}
		
	}
	
	/**
	 * 카드리스트
	 * @return result : 모든 카드리스트
	 */
	public Card cardlist(int cardid) {
		
		System.out.println("<DAO> cardlist");
		Card result = null;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			result = ss.selectOne("CardMapper.cardlist",cardid);
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
	 * 아이템 검색
	 * @param itemid : 아이템 아이디
	 * @return result : 검색한 아이템 객체
	 */
	public Item selectItem(int itemid) {
		
		System.out.println("<DAO> selectItem");
		Item  result = null;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			result = ss.selectOne("CardMapper.selectItem",itemid);
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
	 * 리플 검색
	 * @param itemid : 아이템 아이디
	 * @return result : 검색한 아이템 객체
	 */
	public ArrayList<Reply> selectReply(int itemid) {
		
		System.out.println("<DAO> selectReply");
		ArrayList<Reply>  result = null;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			result = (ArrayList)ss.selectList("CardMapper.selectReply",itemid);
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
	
	
	//댓글입력
	public int insertreply(Reply reply){
		System.out.println("<DAO> insertreply");
		int result = 0;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			ss.insert("CardMapper.insertreply",reply);
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
	
	//입력 후 입력한 댓글 객체 검색
	public Reply selectoneReply(int replyid){
		System.out.println("<DAO> selectoneReply");
		Reply result =null;
		SqlSession ss = null;
		
		try {
			ss = factory.openSession();
			result = ss.selectOne("CardMapper.selectoneReply",replyid);
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
	
}

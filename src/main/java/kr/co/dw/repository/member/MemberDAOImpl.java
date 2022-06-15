package kr.co.dw.repository.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.dw.domain.MemberDTO;

@Repository   //객체 만들어 달라는 표시.
public class MemberDAOImpl implements MemberDAO{

	@Autowired   // 얘 때문에 null이 아님.
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "kr.co.dw.member";

	@Override
	public MemberDTO login(MemberDTO mDto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE+".login", mDto);
	}
	
	




}

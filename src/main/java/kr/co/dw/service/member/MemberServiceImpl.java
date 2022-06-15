package kr.co.dw.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.dw.domain.MemberDTO;
import kr.co.dw.repository.member.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO mDao; // 다형성

	@Override
	public MemberDTO login(MemberDTO mDto) {
		
		return mDao.login(mDto);
	}



	
	
	
}

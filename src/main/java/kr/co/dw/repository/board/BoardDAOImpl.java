package kr.co.dw.repository.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.dw.domain.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSession sqlsession;
	
	private final String NAMESPACE = "kr.co.dw.board";

	@Override
	public void insert(BoardDTO bDto) {
		sqlsession.insert(NAMESPACE+".insert", bDto);
		
	}

	@Override
	public BoardDTO read(int bno) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(NAMESPACE+".read", bno);
	}

	@Override
	public List<BoardDTO> list() {
		// TODO Auto-generated method stub
		return sqlsession.selectList(NAMESPACE+".list");
	}

	@Override
	public BoardDTO updateUI(int bno) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(NAMESPACE+".updateUI", bno);
	}

	@Override
	public void update(BoardDTO bDto) {
		sqlsession.update(NAMESPACE+".update", bDto);
		
	}

	@Override
	public void delete(int bno) {
		sqlsession.delete(NAMESPACE+".delete", bno);
		
	}

	@Override
	public void increaseReadCnt(int bno) {
		sqlsession.update(NAMESPACE+".increaseReadCnt", bno);
		
	}

}

package kr.co.dw.repository.board;

import java.util.List;

import kr.co.dw.domain.BoardDTO;

public interface BoardDAO {

	void insert(BoardDTO bDto);

	BoardDTO read(int bno);

	List<BoardDTO> list();

	BoardDTO updateUI(int bno);

	void update(BoardDTO bDto);

	void delete(int bno);

	void increaseReadCnt(int bno);

}

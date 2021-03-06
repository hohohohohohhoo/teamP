package kr.co.dw.service.board;

import java.util.List;

import kr.co.dw.domain.BoardDTO;

public interface BoardService {

	void insert(BoardDTO bDto);

	BoardDTO read(int bno);

	List<BoardDTO> list();

	BoardDTO updateUI(int bno);

	void update(BoardDTO bDto);

	void delete(int bno);

	void update(BoardDTO bDto, String[] arr);

	void update(BoardDTO bDto, String[] arr, List<String> fileList);

	BoardDTO read(int bno, String ip);

}

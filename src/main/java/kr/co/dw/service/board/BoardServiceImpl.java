package kr.co.dw.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dw.domain.BoardDTO;
import kr.co.dw.repository.board.BoardDAO;
import kr.co.dw.repository.readcnt.ReadCntDAO;
import kr.co.dw.repository.reply.ReplyDAO;
import kr.co.dw.repository.upload.UploadDAO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDAO bDao;

	@Autowired
	private ReplyDAO rDao;
	
	@Autowired
	private UploadDAO uDao;
	
	@Autowired
	private ReadCntDAO readCntDao;
	
	@Transactional
	@Override
	public void insert(BoardDTO bDto) {
		bDao.insert(bDto);
		
		int bno = bDto.getBno();
		List<String> list = bDto.getFilenameList();
		
		for(int i=0;i<list.size();i++) {
			String filename =list.get(i);
			uDao.insert(filename, bno);
		}
		
	}
	
	@Transactional
	@Override
	public BoardDTO read(int bno) {
		// TODO Auto-generated method stub
		
		bDao.increaseReadCnt(bno);
		
		BoardDTO dto = bDao.read(bno);
		String content = dto.getContent().replaceAll("<br>", System.lineSeparator());
		dto.setContent(content);
		
		
		
		//조회수 증가 코드 
		
		return dto;
	}

	@Override
	public List<BoardDTO> list() {
		// TODO Auto-generated method stub
		return bDao.list();
	}

	@Override
	public BoardDTO updateUI(int bno) {
		// TODO Auto-generated method stub
		return bDao.updateUI(bno);
	}

	@Override
	public void update(BoardDTO bDto) {
		bDao.update(bDto);
		
	}
	
	@Transactional
	@Override
	public void delete(int bno) {
		
		rDao.deleteByBno(bno);
		bDao.delete(bno);
		
	}
	@Transactional
	@Override
	public void update(BoardDTO bDto, String[] arr) {
		update(bDto);
		
		for (int i = 0; i < arr.length; i++) {
			String filename = arr[i];
			uDao.deleteUpload(filename);
		}
	}
	
	@Transactional
	@Override
	public void update(BoardDTO bDto, String[] arr, List<String> fileList) {
		update(bDto,arr);
		
		
		for (int i = 0; i < fileList.size(); i++) {
			String filename = fileList.get(i);
			uDao.insert(filename, bDto.getBno());
		}
		
	}
	
	@Transactional
	@Override
	public BoardDTO read(int bno, String ip) {
		// TODO Auto-generated method stub
		String readIp = readCntDao.read(ip, bno);
		
		if(readIp == null) {
			readCntDao.insert(ip,bno);
			bDao.increaseReadCnt(bno);
		}
		BoardDTO bDto = bDao.read(bno);

		
		return bDao.read(bno);
	}

	

}

package kr.co.dw.service.upload;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dw.domain.BoardDTO;
import kr.co.dw.repository.upload.UploadDAO;

@Service
@Transactional
public class UploadServiceImpl implements UploadService{
	
	@Inject
	private UploadDAO uDao;
	
	
	@Override
	public void insert(BoardDTO bDto) {
		List<String> list = bDto.getFilenameList();
		
		for(int i=0;i<list.size();i++) {
			String filename = list.get(i);
			uDao.insert(filename, bDto.getBno());
		}
		
	}



	@Override
	public List<String> getAllUpload(int bno) {
		// TODO Auto-generated method stub
		return uDao.getAllUpload(bno);
	}





	

}

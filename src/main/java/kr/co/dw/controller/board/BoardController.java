package kr.co.dw.controller.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dw.domain.BoardDTO;
import kr.co.dw.service.board.BoardService;
import kr.co.dw.service.upload.UploadService;
import kr.co.dw.utils.DWUtils;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Inject
	private BoardService bService;
	
	private String uploadPath = "C:" + File.separator + "upload";
	
	@Inject
	private UploadService uService;
	
	@RequestMapping(value = "/{bno}/uploadall", method = RequestMethod.GET)
	public ResponseEntity<List<String>> getAllUpload(@PathVariable("bno") int bno){
		
		ResponseEntity<List<String>> entity =null;
		
		try {
			List<String> list =uService.getAllUpload(bno);
			
			entity = new ResponseEntity<List<String>>(list,HttpStatus.OK);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	@RequestMapping(value = "/delete/{bno}", method = RequestMethod.POST )
	public String delete(@PathVariable("bno") int bno) {
		
		List<String> list = uService.getAllUpload(bno);
		System.out.println(list);
		bService.delete(bno);
		
		for(int i=0;i<list.size();i++) {
			String fileaname = list.get(i);
			DWUtils.deleteFile(uploadPath, fileaname);
			
		}
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST )
	public ResponseEntity<String> update(MultipartHttpServletRequest request) {
		
		ResponseEntity<String> entity = null;
		
		try {

			String sBno = request.getParameter("bno");
			int bno = Integer.parseInt(sBno);
			String title = request.getParameter("title");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			
			String deleteFilenames = request.getParameter("deleteFilenameArr");
			
			//문자열 -> 배열
			String[] arr = deleteFilenames.split(",");
			
			Map<String, MultipartFile> map= request.getFileMap();
			List<String> fileList = new ArrayList<String>();
			

				Set<String> set= map.keySet(); //인덱스 x
				
				//인덱스가없으므로 key 값을 받아온다.
				Iterator<String> it = set.iterator();
				while (it.hasNext()) {
					String key =it.next();
					
					MultipartFile file= map.get(key);
					String orgFilename = file.getOriginalFilename();
					
					try {
						String uploadedFilename = DWUtils.uploadFile(uploadPath, orgFilename, file.getBytes());
						fileList.add(uploadedFilename);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}

			
			
			
			BoardDTO bDto = new BoardDTO(bno, title, content, writer, null, null, 0, null);
			
			bService.update(bDto, arr, fileList);
			
			for(int i=0;i<arr.length;i++) {
				String deleteFilename = arr[i];
				DWUtils.deleteFile(uploadPath, deleteFilename);
			}
			
			
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>("FAIL",HttpStatus.BAD_REQUEST);
		}
		

		return entity;
	}
	
//	@RequestMapping(value = "/update", method = RequestMethod.POST )
//	public String update(BoardDTO bDto) {
//			
//		bService.update(bDto);
//		
//		
//		return "redirect:/board/read/"+bDto.getBno();
//	}
	
	
	
	@RequestMapping(value = "/update/{bno}", method = RequestMethod.GET )
	public String updateUI(@PathVariable("bno") int bno, Model model) {
		
		BoardDTO bDto = bService.updateUI(bno);
		model.addAttribute("bDto", bDto);
		
		return "/board/update";
	}
	
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET )
	public void list(Model model) {
		
		List<BoardDTO> bList = bService.list();

		
		model.addAttribute("bList", bList);
		
	}
	
	
	
	
	
	@RequestMapping(value = "/read/{bno}", method = RequestMethod.GET )
	public String read(@PathVariable("bno") int bno, Model model, 
			HttpServletRequest request) {

		String ip = request.getRemoteAddr();
		
		
		BoardDTO bDto = bService.read(bno, ip);
		
		model.addAttribute("bDto", bDto);
		
		return "/board/read";
	}
	
	
	
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST,
					produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(MultipartHttpServletRequest request) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		BoardDTO bDto = new BoardDTO(0, title, content, writer, null, null, 0);
		
		
	
	try {
		
			Map<String, MultipartFile> map = request.getFileMap();
			
				Set<String> set= map.keySet(); 
				Iterator<String> it = set.iterator();
				
				List<String> fileList = new ArrayList<String>();
				while (it.hasNext()) {
					String key =it.next();
					
					MultipartFile file= map.get(key);
	
					String orgFilename = file.getOriginalFilename();
					
					try {
						String uploadedFilename = DWUtils.uploadFile(uploadPath, orgFilename, file.getBytes());
						fileList.add(uploadedFilename);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}


			bDto.setFilenameList(fileList);
			
			bService.insert(bDto);
			
			entity = new ResponseEntity<String>(bDto.getBno()+"",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(-1+"",HttpStatus.BAD_REQUEST);
			
		}
		

		return entity;
	}
	
	
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET )
	public String insertUI() {
		
		
		return "/board/insert";
	}

}

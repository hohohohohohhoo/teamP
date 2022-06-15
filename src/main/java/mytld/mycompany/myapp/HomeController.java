package mytld.mycompany.myapp;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dw.domain.MemberDTO;
import kr.co.dw.utils.DWUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private String uploadPath = "C:" + File.separator + "upload";
	
	
	@RequestMapping(value = "/test11", method = RequestMethod.GET)
	public String test11() {
		return "test11";
	}
	
	@RequestMapping(value = "/ajaxform", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> ajaxform(MultipartHttpServletRequest request, Model model) throws Exception {
		
		String id = request.getParameter("id");
		System.out.println(id);
		System.out.println("id를 데이터베이스에 저장함.");
		System.out.println("저장이 잘 됐으면, 아래의 파일 저장하는 코드 실행");
		System.out.println("저장이 안 됐으면, 아래의 파일 저장하는 코드 미실행");
		
		
		ResponseEntity<String> entity = null;
		
		try {
			
			// 여러개 파일 가져오는 코드
			List<MultipartFile> list = request.getFiles("file");

			// 가져온코드 저장할 리스트
			List<String> filenameList = new ArrayList<String>();

			// 업로드된 파일들 저장
			for (int i = 0; i < list.size(); i++) {
				// 리스트안의 객체 하나씩 희득
				MultipartFile file = list.get(i);
				// 파일데이터를 파일로 저장하는 코드
				String uploadedFilename = DWUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
				
				//여러 개의 업로드된 파일명을 저장
				filenameList.add(uploadedFilename);
			}

			
			entity = new ResponseEntity<String>(filenameList.toString(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL",HttpStatus.BAD_REQUEST);
			
		}
		
		
		
		

		return entity;
	}
	
	
	@RequestMapping(value = "/ajaxform", method = RequestMethod.GET)
	public String ajaxForm() {
		
		return "ajaxform";
	}
	

	@RequestMapping(value = "/deletefile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String filename) {
		ResponseEntity<String> entity = null;

		try {

			DWUtils.deleteFile(uploadPath, filename);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/displayfile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename) {

		ResponseEntity<byte[]> entity = null;

		InputStream in = null;

		try {
			in = new FileInputStream(new File(uploadPath, filename));

			MediaType mType = DWUtils.getMediaType(filename);

			HttpHeaders headers = new HttpHeaders();

			if (mType != null) { // 파일업로드하고 이미지파일의 썸네일보여줄 때
				// jsp파일에서 이미지파일의 썸네일을 클릭할 때 원본파일 보여줄 떼
				headers.setContentType(mType);
				// 이미지파일 보여주기

			} else { // 일반파일 썸네일을 클릭하면 실행되는 코드

				// 파일을 다운로드하게 하는 마임타입(OCTET_STREAM)
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

				// 파일명: /2022/06/02/a13ffez13e_show.txt uuid+파일명 오지지널네임 추출
				int idx = filename.indexOf("_") + 1;
				String oriName = filename.substring(idx);
				// 브라우저에서 안깨지기위한 형변환
				oriName = new String(oriName.getBytes("UTF-8"), "ISO-8859-1");

				headers.add("Content-Disposition", "attachment;filename=\"" + oriName + "\"");
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();

			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return entity;
	}

	@RequestMapping(value = "/uploadform", method = RequestMethod.POST)
	public String uploadForm(MultipartHttpServletRequest request, Model model) throws Exception {

		String id = request.getParameter("id");

		// 여러개 파일 가져오는 코드
		List<MultipartFile> list = request.getFiles("file");

		// 가져온코드 저장할 리스트
		List<String> filenameList = new ArrayList<String>();

		// 업로드된 파일들 저장
		for (int i = 0; i < list.size(); i++) {
			// 리스트안의 객체 하나씩 희득
			MultipartFile file = list.get(i);
			// 파일데이터를 파일로 저장하는 코드
			String uploadedFilename = DWUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());

			filenameList.add(uploadedFilename);
		}

		model.addAttribute("filenameList", filenameList);

		return "test";
	}

	/*
	  @RequestMapping(value = "/uploadform", method = RequestMethod.POST) public
	  String uploadForm(MultipartHttpServletRequest request, Model model) throws
	  Exception {
	  
	  String id = request.getParameter("id");
	  
	  MultipartFile file = request.getFile("file");
	  
	  String uploadedFilename = DWUtils.uploadFile(uploadPath,
	  file.getOriginalFilename(), file.getBytes());
	  
	  
	  model.addAttribute("uploadedFilename",uploadedFilename);
	  
	  return "test2"; }
	 */

	@RequestMapping(value = "/uploadform", method = RequestMethod.GET)
	public String uploadForm() {

		return "uploadform";
	}

	@RequestMapping(value = "/jsontest", method = RequestMethod.GET)
	@ResponseBody
	public /* @ResponseBody */ MemberDTO jsonTest() {
		return new MemberDTO("S001", "111", "utaka", "0000-01-01");
	} // json 파일이라는 것을 알려주어 변환한다.

	@RequestMapping(value = "/makefolder", method = RequestMethod.GET)
	public String makefolder() { // 폴더만드는거 할꺼임.

		String uploadPath = DWUtils.makefolder("C:" + File.separator + "upload");

		return "redirect:/"; // 애가 uri 값으로 넘어감.
	}

	@RequestMapping(value = "/hello", method = RequestMethod.GET)
	public String hello(Model model) { // void 는 uri값을 자동으로 넘겨중 --> 위에 hello를 넘겨줌.

		String say = "sssssssssssssssSSSSSSSSSSSS";

		model.addAttribute("say", say);

		return "hello"; // 애가 uri 값으로 넘어감.
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

	

		String serverTime = "안녕하세요";

		model.addAttribute("serverTime", serverTime);

		return "home";
	}

}

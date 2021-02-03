package egovframework.example.board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.Calendar;
import java.text.SimpleDateFormat;

@Controller
public class BoardController {
	
	/** BoardService */
	@Resource(name = "boardService") // name과 일치하는 객체를 자동 주입
	private BoardService boardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") // name과 일치하는 객체를 자동 주입
	protected EgovPropertyService propertiesService;
	
/** 사용자 */
	
	/** 회원가입 */
	@RequestMapping(value = "/boardSignUp.do")
	public String BoardSignUp(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
						
		
		/**
		 * 회원가입 부분 짜다가 user_id값이 자꾸 넘어오질 않아서 이 부분은 시간이 없어서 못해봤습니다.
		 * boardService.insertSignUp(boardVO);
		*/
		
		return "board/boardSignUp";
	}
	
	/** 로그인 */
	@RequestMapping(value = "/login.do") // "/login.do"로 접속하면 login메소드 호출(맵핑)
	public String login(@RequestParam("user_id") String user_id, @RequestParam("password") String password, ModelMap model, HttpServletRequest request) throws Exception {
						// 서버로 요청이 들어온 파라미터(아이디) 맵핑			 // 서버로 요청이 들어온 파라미터(비밀번호) 맵핑			// 데이터만 사용		// 서버로 요청이 들어오면 서블릿에게 전달
		
		/*String aa = request.getParameter("user_id");
		String bb = request.getParameter("password");*/
		
		// boardVO에 아이디와 비밀번호 설정
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		boardVO.setPassword(password);
		
		// 설정된 로그인 정보로 service 호출 후 리턴값을 저장
		String user_name = boardService.selectLoginCheck(boardVO);
		
		// 저장된 유저 이름이 존재하면 세션에 아이디와 이름 저장
		if(user_name != null && !"".equals(user_name)) {
			request.getSession().setAttribute("user_id", user_id);
			request.getSession().setAttribute("user_name", user_name);
			
		}else { // 저장된 유저 이름이 존재하지 않을 경우
			request.getSession().setAttribute("user_id", "");
			request.getSession().setAttribute("user_name", "");
			model.addAttribute("msg","사용자 정보가 올바르지 않습니다.");
		}
		
		return "redirect:/boardList.do";
	}
	
	/** 로그아웃 */
	@RequestMapping(value = "/logout.do") // "/logout.do"로 접속하면 login메소드 호출(맵핑)
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
						 // 데이터만 사용	 // 서버로 요청이 들어오면 서블릿에게 전달
		
		// 세션 무효화
		request.getSession().invalidate();
		
		return "redirect:/boardList.do";
	}
	
/** 게시판 */
	
	/** 게시물 목록 */
	@RequestMapping(value = "/boardList.do") // "/boardList.do"로 접속하면 BoardList메소드 호출(맵핑)
	public String BoardList(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
							// 생성된 object로 넘어온 값들을 자동 바인딩				// 데이터만 사용
		
		/** EgovPropertyService.sample */
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// service 호출 후 리턴값을 boardList에 저장 => "resultList"로 전달
		List<?> boardList = boardService.selectBoardList(boardVO);
		model.addAttribute("resultList", boardList);

		// service 호출 후 리턴값을 totCnt에 저장
		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "board/boardList";
	}
	
	/** 게시물 등록 */
	@RequestMapping(value = "/boardRegister.do", method = RequestMethod.GET) // "/boardRegister.do"로 접속하면 BoardList메소드 호출(맵핑), GET방식
	public String BoardRegister(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
								// 생성된 object로 넘어온 값들을 자동 바인딩				// 데이터만 사용		// 서버로 요청이 들어오면 서블릿에게 전달
		
		// 오늘 날짜를 문자 포맷으로 내보내기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        
        // service 호출 후 리턴값을 다시 boardVO객체에 저장 (게시물 작성화면 불러오기)
        boardVO = boardService.selectBoard(boardVO);
        
        // 오늘 날짜로 설정
        boardVO.setIndate(strToday);
        
        // 저장된 세션값에서 유저 아이디와 이름 string으로 접근
        boardVO.setWriter(request.getSession().getAttribute("user_id").toString());
        boardVO.setWriterNm(request.getSession().getAttribute("user_name").toString());
        
        // 위에서 board에 저장된 데이터들을 "boardVO"로 전달
        model.addAttribute("boardVO", boardVO);
        
		return "board/boardRegister";
	}
	
	/** 게시물 상세화면에서 원하는 service 수행 */
	@RequestMapping(value = "/boardRegister.do", method = RequestMethod.POST) // "/boardRegister.do"로 접속하면 BoardList 호출(맵핑), POST방식
	public String BoardRegister2(@ModelAttribute("boardVO") BoardVO boardVO, @RequestParam("mode") String mode, ModelMap model) throws Exception {
								 // 생성된 object로 넘어온 값들을 자동 바인딩			 // 서버로 요청이 들어온 파라미터 맵핑			// 데이터만 사용	
		
		// 등록, 수정, 삭제 중 원하는 service 호출
		if("register".equals(mode)){
			boardService.insertBoard(boardVO);
			
		}else if("mod".equals(mode)){
			boardService.updateBoard(boardVO);
			
		}else if("del".equals(mode)){
			boardService.deleteBoard(boardVO);
			boardService.deleteReply(boardVO); // 게시물에 달린 모든 댓글도 같이 삭제
		}
		
		return "redirect:/boardList.do";
	}
	
	/** 게시물 상세화면 */
	@RequestMapping(value = "/boardView.do") // "/boardView.do"로 접속하면 BoardList 호출(맵핑)
	public String BoardView(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
							// 생성된 object로 넘어온 값들을 자동 바인딩				// 데이터만 사용
		
		// 오늘 날짜를 문자 포맷으로 내보내기///////////////////////////////
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
		////////////////////////////////////////////////////////
        
        // 조회수 service 호출
        boardService.updateBoardCount(boardVO);
        
        // 게시물 정보 service 호출
		boardVO = boardService.selectBoard(boardVO);
		
		// 게시물 정보 "boardVO"로 전달
		model.addAttribute("boardVO", boardVO);
		
		/////////////////////////////////////////
		model.addAttribute("strToday", strToday);
		/////////////////////////////////////////
		
		// 댓글 목록 service 호출 후 "resultList"로 전달
		List<?> boardList = boardService.selectReplyList(boardVO);
        model.addAttribute("resultList", boardList);
		
		return "board/boardView";
	}
	
/** 댓글 */
	
	/** 댓글 등록 */
	@RequestMapping(value = "/reply.do", method = RequestMethod.POST) // "/reply.do"로 접속하면 reply메소드 호출(맵핑), POST방식
	public String reply(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
						// 생성된 object로 넘어온 값들을 자동 바인딩				// 데이터만 사용
		
		// 댓글 등록 service 호출
		boardService.insertReply(boardVO);
		
		// 댓글 등록 후 다시 게시물 상세화면으로 이동
		return "redirect:/boardView.do?idx="+boardVO.getIdx();
	}
}
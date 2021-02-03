package egovframework.example.board.service.impl;

import java.util.List;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	// 
	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);

	/** BoardDAO */
	// TODO mybatis 사용
	@Resource(name="boardMapper") // name과 일치하는 객체를 자동 주입
	private BoardMapper boardDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService") // name과 일치하는 객체를 자동 주입
	private EgovIdGnrService egovIdGnrService;

/** 로그인 */
	
	/* 회원가입 mapper 호출 */
	public void insertSignUp(BoardVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		boardDAO.insertSignUp(vo);
	}
	
	/* 로그인 체크 mapper 호출 */
	public String selectLoginCheck(BoardVO searchVO) {
		return boardDAO.selectLoginCheck(searchVO);
	}
	
/** 게시물 */
	
	/* 게시물 등록 mapper 호출 */
	public String insertBoard(BoardVO vo) throws Exception {
		//
		LOGGER.debug(vo.toString());

		/** ID Generation Service */
		/*String id = egovIdGnrService.getNextStringId();
		vo.setId(id);
		LOGGER.debug(vo.toString());*/

		boardDAO.insertBoard(vo);
		return vo.getIdx();
	}

	/* 게시물 수정 mapper 호출 */
	public void updateBoard(BoardVO vo) throws Exception {
		boardDAO.updateBoard(vo);
	}

	/* 게시물 조회 mapper 호출수 */
	public void updateBoardCount(BoardVO vo) throws Exception {
		boardDAO.updateBoardCount(vo);
	}
	
	/* 게시물 삭제 mapper 호출 */
	public void deleteBoard(BoardVO vo) throws Exception {
		boardDAO.deleteBoard(vo);
	}

	/* 게시물 정보 mapper 호출 */
	public BoardVO selectBoard(BoardVO vo) throws Exception {
		BoardVO resultVO = boardDAO.selectBoard(vo);
		
		// 데이터가 없을 때 예외처리 대신 빈 데이터 전달
		if (resultVO == null) {
			resultVO = new BoardVO(); // 데이터 없을 떄 빈 껍데기 보내기
		}
			
		return resultVO;
	}

	/* 게시물 목록 mapper 호출 */
	public List<?> selectBoardList(BoardVO searchVO) throws Exception {
		return boardDAO.selectBoardList(searchVO);
	}

	/* 게시물 총 개수 mapper 호출 */
	public int selectBoardListTotCnt(BoardVO searchVO) {
		return boardDAO.selectBoardListTotCnt(searchVO);
	}

/** 댓글 */
	
	/* 댓글 등록 mapper 호출 */
	public void insertReply(BoardVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		boardDAO.insertReply(vo);
	}
	
	/* 댓글 목록 mapper 호출 */
	public List<?> selectReplyList(BoardVO searchVO) throws Exception {
		return boardDAO.selectReplyList(searchVO);
	}
	
	/* 게시물에 달린 모든 댓글 삭제 mapper 호출 */
	public void deleteReply(BoardVO vo) throws Exception {
		boardDAO.deleteReply(vo);
	}
}
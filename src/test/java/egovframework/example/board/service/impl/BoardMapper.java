package egovframework.example.board.service.impl;

import java.util.List;

import egovframework.example.board.service.BoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper") // mapper 지정
public interface BoardMapper {
	
/** 로그인 */	
	
	/* 회원가입 */
	void insertSignUp(BoardVO vo) throws Exception;
	
	/* 로그인 정보 체크 */
	String selectLoginCheck(BoardVO searchVO);
	
/** 게시물 */
	
	/* 게시물 등록 */
	void insertBoard(BoardVO vo) throws Exception;

	/* 게시물 수정 */
	void updateBoard(BoardVO vo) throws Exception;
	
	/* 게시물 조회수 */
	void updateBoardCount(BoardVO vo) throws Exception;

	/* 게시물 삭제 */
	void deleteBoard(BoardVO vo) throws Exception;

	/* 게시물 정보 */
	BoardVO selectBoard(BoardVO vo) throws Exception;

	/* 게시물 목록 */
	List<?> selectBoardList(BoardVO searchVO) throws Exception;

	/* 게시물 총 개수 */
	int selectBoardListTotCnt(BoardVO searchVO);
	
/** 댓글 */
	
	/* 댓글 등록 */
	void insertReply(BoardVO vo) throws Exception;

	/* 댓글 목록 */
	List<?> selectReplyList(BoardVO searchVO) throws Exception;
	
	/* 게시물에 달린 모든 댓글 삭제 */
	void deleteReply(BoardVO vo) throws Exception;
}
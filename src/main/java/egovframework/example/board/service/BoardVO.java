package egovframework.example.board.service;

import egovframework.example.sample.service.SampleDefaultVO;

public class BoardVO extends SampleDefaultVO {

	/* 사용자 db (tb_user) */
	private String user_id;		// 아이디
	private String password;	// 비밀번호
	private String writerNm;	// 사용자 이름
	private String user_name;
	
	/* 게시판 db (tb_board) */
	private String idx;			// 게시물ID
	private String title;		// 제목
	private String contents;	// 내용
	private String writer;		// 작성자
	private String count;		// 조회수
	private String indate;		// 작성일
	
	/* 댓글 db (tb_reply) */
	private String seq;			// 순번
	private String reply;		// 댓글
	
	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	/* getter, setter */
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getWriterNm() {
		return writerNm;
	}
	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
}
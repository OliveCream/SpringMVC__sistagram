package com.sist.web.model;

import java.io.Serializable;

public class InsCommentLike implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long insLikeNum;
	private long commentNum;
	private String userId;
	
	public InsCommentLike() {
		insLikeNum = 0;
		commentNum = 0;
		userId = "";
	}
	
	public Long getInsLikeNum() {
		return insLikeNum;
	}
	public void setInsLikeNum(Long insLikeNum) {
		this.insLikeNum = insLikeNum;
	}
	public Long getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(Long commentNum) {
		this.commentNum = commentNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}

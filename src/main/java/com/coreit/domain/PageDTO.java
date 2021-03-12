package com.coreit.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage; // 현재 페이지 그룹 내에서의 시작 페이지
	private int endPage; // 현재 페이지 그룹 내에서의 마지막 페이지
	private int realEnd; // 최종 페이지
	private boolean prev; // 이전 페이지 그룹이 존재하는지
	private boolean next; // 다음 페이지 그룹이 존재하는지
	private int total; // 총 게시물 갯수
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.endPage = (int)(Math.ceil(cri.getPageNum() / (float)cri.getGroupSize())) * cri.getGroupSize(); // ceil : 소수점을 버리고 1을 더함
		this.startPage = this.endPage - (cri.getGroupSize() - 1);
		this.realEnd = (int)(Math.ceil((total) / (float)cri.getAmount()));
		if (realEnd < this.endPage) {
			this.endPage = this.realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		/*
		System.out.println("startPage : " + startPage);
		System.out.println("endPage : " + endPage);
		System.out.println("realEnd : " + realEnd);
		System.out.println("prev : " + prev);
		System.out.println("next : " + next);
		System.out.println("total : " + total);
		*/
	}
}

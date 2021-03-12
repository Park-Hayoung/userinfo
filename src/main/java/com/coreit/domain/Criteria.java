package com.coreit.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private int groupSize;
	private int offset;
	
	public Criteria() {
		this(1, 10, 5); // 기본값은 1페이지에 10개씩 5페이지를 표시
	}
	
	public Criteria(int pageNum, int amount, int groupSize) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.groupSize = groupSize;
		this.offset = (pageNum - 1) * amount;
	}
}

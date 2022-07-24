package com.spring.javagreenS_ljs.pagination;

import lombok.Data;

@Data
public class PageVO {
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int blockSize;
	private int curBlock;
	private int lastBlock;
	private int pag;

	private String part; // 검색 조건
}

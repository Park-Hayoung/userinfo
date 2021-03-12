package com.coreit.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.coreit.domain.Criteria;
import com.coreit.domain.SearchVO;
import com.coreit.domain.UserInfoVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserInfoMapperTest {
	
	@Setter(onMethod_= @Autowired)
	private UserInfoMapper mapper;
	
//	@Test
	public void testGetList() {
		log.info("Test UserInfoMapper getList...");
		mapper.getList().forEach(user -> log.info(user));
	}
	
//	@Test
	public void testGetListWithPaging() {
		log.info("Test UserInfoMapper getListWithPaging...");
		Criteria cri = new Criteria(29, 10, 5);
		log.info("amount : " + cri.getAmount() + ", offset : " + cri.getOffset());
		mapper.getListWithPaging(cri).forEach(user -> log.info(user));
	}
	
//	@Test
	public void testSearchList() {
		log.info("Test UserInfoMapper searchList...");
		SearchVO search = new SearchVO();
		search.setKeyword("박하영");
		search.setCri(new Criteria(2, 10, 5));
		log.info("amount : " + search.getCri().getAmount() + ", offset : " + search.getCri().getOffset());
		mapper.searchList(search).forEach(user -> log.info(user));
	}
	
//	@Test
	public void testGetUserInfo() {
		log.info("Test UserInfoMapper getUserInfo...");
		log.info(mapper.getUserInfo(1805));
	}
	
//	@Test
	public void testInsert() {
		log.info("Test UserInfoMapper insertUserInfo...");
		UserInfoVO userInfo = new UserInfoVO();
		userInfo.setU_id("testid");
		userInfo.setU_pw("1234");
		userInfo.setU_name("테스트");
		userInfo.setU_birth("2021-02-09");
		userInfo.setU_gender("M");
		userInfo.setU_email("9404@coreit.co.kr");
		userInfo.setU_phone("010-1234-5678");
		userInfo.setU_tel("043-249-1858");
		userInfo.setU_hobby("빵만들기,여행");
		userInfo.setU_edu("univ");
		userInfo.setCret_id("testid");
		userInfo.setCret_ip("192.168.0.115");
		log.info(mapper.insertUserInfo(userInfo) != 0 ? "삽입 성공..." : "삽입 실패...");
	}
	
//	@Test
	public void testUpdate() {
		log.info("Test UserInfoMapper updateUserInfo...");
		UserInfoVO userInfo = new UserInfoVO();
		userInfo.setU_idx(1803);
		userInfo.setU_email("test@coreit.co.kr");
		userInfo.setU_phone("010-1313-4646");
		userInfo.setU_tel("043-249-1857");
		userInfo.setU_hobby("해킹,요트타기");
		userInfo.setU_edu("middle");
		log.info(mapper.updateUserInfo(userInfo) == 1 ? "수정 성공..." : "수정 실패...");
	}
	
//	@Test
	public void testDelete() {
		log.info("Test UserInfoMapper deleteUserInfo...");
		log.info(mapper.deleteUserInfo(1803) == 1 ? "삭제 성공..." : "삭제 실패...");
	}
	
//	@Test
	public void testGetTotal() {
		log.info("Test UserInfoMapper getTotal...");
		log.info(mapper.getTotal());
	}
	
	@Test
	public void testGetSearchTotal() {
		log.info("Test UserInfoMapper getSearchTotal...");
		log.info(mapper.getSearchTotal("박하영"));
	}
}

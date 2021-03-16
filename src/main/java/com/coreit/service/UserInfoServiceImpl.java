package com.coreit.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coreit.domain.Criteria;
import com.coreit.domain.SearchVO;
import com.coreit.domain.UserInfoVO;
import com.coreit.mapper.UserInfoMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserInfoServiceImpl implements UserInfoService {
	
	@Setter(onMethod_= @Autowired)
	private UserInfoMapper mapper;

	@Override
	public List<UserInfoVO> getList() {
		log.info("UserInfoService getList...");
		return mapper.getList();
	}
	
	@Override
	public List<UserInfoVO> getListWithPaging(Criteria cri) {
		log.info("UserInfoService getListWithPaging...");
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<UserInfoVO> searchList(SearchVO search) {
		log.info("UserInfoService searchList...");
		return mapper.searchList(search);
	}
	
	@Override
	public UserInfoVO getUserInfo(int u_idx) {
		log.info("UserInfoService getUserInfo...");
		return mapper.getUserInfo(u_idx);
	}

	@Override
	public int insertUserInfo(UserInfoVO userInfo) {
		log.info("UserInfoService insertUserInfo...");
		return mapper.insertUserInfo(userInfo);
	}

	@Override
	public int updateUserInfo(UserInfoVO userInfo) {
		log.info("UserInfoService updateUserInfo...");
		return mapper.updateUserInfo(userInfo);
	}
	
	/*
	@Override
	public UserInfoVO parseUserInfoData(HttpServletRequest request, UserInfoVO userInfo) {
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		String[] hobby = request.getParameterValues("hobby[]");
		String edu = request.getParameter("edu");
		
		userInfo.setU_email(email1 + "@" + email2);
		userInfo.setU_phone(phone1 + "-" + phone2 + "-" + phone3);
		userInfo.setU_tel(tel1 + "-" + tel2 + "-" + tel3);
		StringBuilder hobbyBuilder = new StringBuilder();
		for (int i = 0; i < hobby.length; i++) {
			hobbyBuilder.append(hobby[i]);
			hobbyBuilder.append(",");
		}
		hobbyBuilder.deleteCharAt(hobbyBuilder.length() - 1); // 마지막에 붙은 , 제거
		userInfo.setU_hobby(hobbyBuilder.toString());
		userInfo.setU_edu(edu);
		
		return userInfo;
	}
	*/

	@Override
	public int deleteUserInfo(int u_idx) {
		log.info("UserInfoService deleteUserInfo...");
		return mapper.deleteUserInfo(u_idx);
	}
	
	@Override
	public int deleteUserInfoReal(int u_idx) {
		log.info("UserInfoService deleteUserInfoReal...");
		return mapper.deleteUserInfoReal(u_idx);
	}
	
	@Override
	public int getTotal() {
		log.info("UserInfoService getTotal...");
		return mapper.getTotal();
	}

	@Override
	public int getSearchTotal(String keyword) {
		log.info("UserInfoService getSearchTotal...");
		return mapper.getSearchTotal(keyword);
	}
	
	@Override
	public List<String> getHobbyList() {
		String[] hobbyArray = { "해킹", "요트타기", "빵만들기", "TV보기", "게임", "공부", "여행", "수영" };
		return Arrays.asList(hobbyArray); // Array to List
	}
	
	@Override
	public HashMap<String, Boolean> getHobbyMap(String hobby) {
		String[] hobbyArray = hobby.split(",");
		HashMap<String, Boolean> map = new HashMap<String, Boolean>();
		for (String s : hobbyArray) {
			map.put(s, true);
		}
		return map;
	}
	
	@Override
	public int pwCheck(UserInfoVO userInfo) {
		log.info("UserInfoService pwCheck... " + userInfo);
		return mapper.pwCheck(userInfo);
	}
}

package com.coreit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.coreit.domain.Criteria;
import com.coreit.domain.PageDTO;
import com.coreit.domain.SearchVO;
import com.coreit.domain.UserInfoVO;
import com.coreit.service.UserInfoService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/userinfo")
@Log4j
public class UserInfoController {
	
	@Setter(onMethod_= @Autowired)
	private UserInfoService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Criteria cri, String keyword, Model model) {
		log.info("UserInfo list 요청...");
		log.info(cri);
		
		if (cri.getPageNum() <= 0) {
			cri.setPageNum(1);
		}
		
		// 파라미터를 2개만 넘겨도 내부적으로 파라미터
		// 3개짜리 생성자를 호출하여 인스턴스를 생성하는 듯 싶음 (설마 lombok 때문에...?)
		// 그래서 계산이 필요한 offset은 따로 설정해줌
		cri.setOffset((cri.getPageNum() - 1) * cri.getAmount());
		
		int total;
		PageDTO pageDto;
		List<UserInfoVO> list;
		if (keyword == null || keyword.trim().equals("")) { // 검색하지 않았을 경우
			total = service.getTotal();
			pageDto = new PageDTO(cri, total);
			list = service.getListWithPaging(cri);
		} else { // 검색했을 경우
			total = service.getSearchTotal(keyword);
			pageDto = new PageDTO(cri, total);
			SearchVO search = new SearchVO(keyword, cri);
			list = service.searchList(search);
		}
		String keywordForLog = keyword == null || keyword.trim().equals("") ?
					 "검색어 없음" : keyword;
		log.info(keywordForLog + " (" + total + "개)");
		
		model.addAttribute("list", list);
		model.addAttribute("page", pageDto);
		model.addAttribute("keyword", keyword);
		
		return "/userinfo/list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerForm(Criteria cri, String keyword, Model model) {
		log.info("UserInfo registerForm 요청...");
		
		model.addAttribute("cri", cri);
		model.addAttribute("keyword", keyword);
		
		return "/userinfo/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(UserInfoVO userInfo, Criteria cri, String keyword,
			RedirectAttributes rttr) {
		log.info("UserInfo register 요청... " + userInfo);
		
		// cret_id, ip 등등 초기화하는 것부터 하면 됨
		
		
		int result = service.insertUserInfo(userInfo); // 성공시 생성된 u_idx 반환
		log.info(result == 1 ? "등록 성공..." : "등록 실패...");
		
		rttr.addAttribute("u_idx", result);
		rttr.addAttribute("result", result);
		rttr.addFlashAttribute(cri);
		rttr.addAttribute("keyword", keyword);
		
		return "redirect:/userinfo/view";
	}
	
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(int u_idx, Criteria cri, String keyword, Model model) {
		log.info("UserInfo view 요청... u_idx : " + u_idx);
		
//		int total = service.getTotal();
//		PageDTO pageDto = new PageDTO(cri, total);
		
		model.addAttribute("userInfo", service.getUserInfo(u_idx));
		model.addAttribute("cri", cri);
		model.addAttribute("keyword", keyword);
		
		return "/userinfo/view";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateForm(int u_idx, Criteria cri, String keyword, Model model) {
		log.info("UserInfo updateForm 요청... u_idx : " + u_idx);
		log.info(cri);
		
		UserInfoVO userInfo = service.getUserInfo(u_idx);
		
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("hobbyList", service.getHobbyList());
		model.addAttribute("hobbyMap", service.getHobbyMap(userInfo.getU_hobby()));
		model.addAttribute("cri", cri);
		model.addAttribute("keyword", keyword);
		
		return "/userinfo/update";
	}
	
	// 업데이트 완료후 result 값에 따라 alert창 띄워주는 기능 추가
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(UserInfoVO userInfo, Criteria cri, String keyword,
			RedirectAttributes rttr) {
		log.info("UserInfo update 요청... " + userInfo);
		
		int result = service.updateUserInfo(userInfo);
		log.info(result == 1 ? "수정 성공..." : "수정 실패...");
		
		rttr.addAttribute("u_idx", userInfo.getU_idx());
		rttr.addAttribute("result", result);
		rttr.addFlashAttribute(cri);
		rttr.addAttribute("keyword", keyword);
		
		return "redirect:/userinfo/view";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(int u_idx, Criteria cri, String keyword, 
			RedirectAttributes rttr) {
		log.info("UserInfo delete 요청... u_idx : " + u_idx);
		
		int result = service.deleteUserInfo(u_idx);
		log.info(result == 1 ? "삭제 성공..." : "삭제 실패...");
		
		rttr.addAttribute("result", result);
		rttr.addFlashAttribute(cri);
		rttr.addAttribute("keyword", keyword);
		
		return "redirect:/userinfo/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwCheck", produces = "application/json", method = RequestMethod.POST)
	public String pwCheck(UserInfoVO userInfo) {
		log.info("UserInfo pwCheck 요청... " + userInfo);
		return Integer.toString(service.pwCheck(userInfo));
	}
}

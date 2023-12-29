package com.spring.app.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.domain.EmployeeVO;
import com.spring.app.reservation.service.ReservationService;

/** 
* @FileName  : ReservationController.java 
* @Project   : TempFinal 
* @Date      : Dec 28, 2023 
* @작성자      : hada 
* @변경이력    : 
* @프로그램설명    : 예약 컨트롤러입니다.
*/
@Controller
@RequestMapping(value = "/reservation/*")
public class ReservationController {
	
	@Autowired
	private ReservationService service;

	
	
	@GetMapping("myReservationList.gw")
	public ModelAndView myReservationList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

/* 로그인 확인을 위한 테스트코드 시작 */
HttpSession session = request.getSession();
EmployeeVO loginUser = new EmployeeVO();
loginUser.setEmpId((long) 9999); 
session.setAttribute("loginUser", loginUser);
/* 로그인 확인을 위한 테스트코드 끝 */		
		

//		long loginEmpId = loginUser.getEmpId();
//
//		Map<String, Object> paraMap = new HashMap<>();
//		paraMap.put("loginEmpId", loginEmpId);
//		paraMap.put("mailType",  mailType);
//		//	paraMap.put("personalMailboxTypeId", personalMailboxTypeId);
//		paraMap.put("mailId", mailId);
		
		//----- 개인편지함 가져오기 시작 ----- //
//		List<Map<String, String>> personalMailboxList = null;
//		personalMailboxList = service.getPersonalMailbox(paraMap);
//		mav.addObject("personalMailboxList", personalMailboxList);
		//----- 개인편지함 가져오기 끝 ----- //	


		//----- 자원카테고리 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceCategoryList = null;
		resourceCategoryList = service.getResourceCategoryList();
		mav.addObject("resourceCategoryList", resourceCategoryList);
		//----- 자원카테고리 목록 가져오기 끝 ----- //	



		mav.setViewName("myReservationList.reservation");
		
		return mav;
		
	}	
	
	
	
	@GetMapping("resourceList.gw")
	public ModelAndView resourceList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

	
		//----- 자원카테고리 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceCategoryList = null;
		resourceCategoryList = service.getResourceCategoryList();
		mav.addObject("resourceCategoryList", resourceCategoryList);
		//----- 자원카테고리 목록 가져오기 끝 ----- //	
		
		
		String resourceCategoryId = request.getParameter("resourceCategoryId");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("resourceCategoryId", resourceCategoryId);
	
		
		//----- 자원카테고리 정보 가져오기 시작 ----- //
		Map<String, Object> resourceCategoryInfo_map = new HashMap<>();
		resourceCategoryInfo_map = service.getResourceCategoryInfo(paraMap);
		mav.addObject("resourceCategoryInfo_map", resourceCategoryInfo_map);
		//----- 자원카테고리 정보 가져오기 끝 ----- //
		
		//----- 자원 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceList = null;
		resourceList = service.getResourceList(paraMap);
		mav.addObject("resourceList", resourceList);
		//----- 자원 목록 가져오기 끝 ----- //				
		
		mav.setViewName("resourceList.reservation");
		
		return mav;
	
	}	
	
	
	/** 
	* @Method Name  : getResourceInfo 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원 정보 가져오기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("getResourceInfo.gw")
	public String getResourceInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String resourceId = request.getParameter("resourceId"); 
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("resourceId", resourceId);
		
		
	//	int n = service.getResourceInfo(paraMap); // 자원 정보 가져오기

		JSONObject jsonObj = new JSONObject(); // {}
	//	jsonObj.put("n", n);
		
		
		
		
		
	
		return jsonObj.toString();
	}	
		
}

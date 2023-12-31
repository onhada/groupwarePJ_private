package com.spring.app.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.domain.EmployeeVO;
import com.spring.app.reservation.domain.ReservationVO;
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

	
	
	/** 
	* @Method Name  : myReservationList 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 나의 예약 목록 페이지 보여주기 
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@GetMapping("myReservationList.gw")
	public ModelAndView myReservationList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

/* 로그인 확인을 위한 테스트코드 시작 */
HttpSession session = request.getSession();
EmployeeVO loginUser = new EmployeeVO();
loginUser.setEmpId((long) 9999); 
session.setAttribute("loginUser", loginUser);
/* 로그인 확인을 위한 테스트코드 끝 */		
		

		long loginEmpId = loginUser.getEmpId();
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("loginEmpId", loginEmpId);
		
		
		// ----- 자원카테고리 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceCategoryList = null;
		resourceCategoryList = service.getResourceCategoryList();
		mav.addObject("resourceCategoryList", resourceCategoryList);
		// ----- 자원카테고리 목록 가져오기 끝 ----- //	

		
		List<ReservationVO> myReservationList = null;
		
		// ----- 예약된 자원 목록 가져오기 시작 ----- // 
		paraMap.put("type", "reserved");
		myReservationList = service.getmyReservationList(paraMap); 
		mav.addObject("reservedList", myReservationList);
		// ----- 예약된 자원 목록 가져오기 끝 ----- // 
		
		// ----- 대기 자원 목록 가져오기 시작 ----- // 
		paraMap.put("type", "waiting");
		myReservationList = service.getmyReservationList(paraMap);
		mav.addObject("waitingForApprovalList", myReservationList);
		// ----- 대기 자원 목록 가져오기 끝 ----- // 
		
		
		mav.setViewName("myReservationList.reservation");
		
		return mav;
		
	}	
	
	
	/** 
	* @Method Name  : resourceList 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원카테고리별 예약 페이지 보여주기 
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@GetMapping("reservationResource.gw")
	public ModelAndView reservationResource(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

	
		// ----- 자원카테고리 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceCategoryList = null;
		resourceCategoryList = service.getResourceCategoryList();
		mav.addObject("resourceCategoryList", resourceCategoryList);
		// ----- 자원카테고리 목록 가져오기 끝 ----- //	
		
		
		String resourceCategoryId = request.getParameter("resourceCategoryId");
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("resourceCategoryId", resourceCategoryId);
	
		
		// ----- 자원카테고리 정보 가져오기 시작 ----- //
		Map<String, Object> resourceCategoryInfo_map = new HashMap<>();
		resourceCategoryInfo_map = service.getResourceCategoryInfo(paraMap);
		mav.addObject("resourceCategoryInfo_map", resourceCategoryInfo_map);
		// ----- 자원카테고리 정보 가져오기 끝 ----- //
		
		// ----- 자원 목록 가져오기 시작 ----- //
		List<Map<String, String>> resourceList = null;
		resourceList = service.getResourceList(paraMap);
		mav.addObject("resourceList", resourceList);
		// ----- 자원 목록 가져오기 끝 ----- //				
		
		
		// ----- 예약된 자원 목록 가져오기 시작 ----- // 
		
		// ----- 예약된 자원 목록 가져오기 끝 ----- // 
		
		
		
		
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
		
		// ----- 자원 정보 가져오기 시작 ----- //
		Map<String, Object> resourceInfo_map = new HashMap<>();
		resourceInfo_map = service.getResourceInfo(paraMap); 
		request.setAttribute("resourceInfo_map", resourceInfo_map);
		// ----- 자원 정보 가져오기 끝 ----- //
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("resourceInfo_map", resourceInfo_map);
		
		
		return jsonObj.toString();
	}		
	
	
	/** 
	* @Method Name  : getResourceList 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 :모든 자원목록 정보 가져오기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("getResourceList.gw")
	public String getResourceList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
//		// ----- 모든 자원 목록 가져오기 시작 ----- //
//		List<Map<String, String>> allResourceList = null;
//		
//		mav.addObject("allResourceList", allResourceList);
//		// ----- 모든 자원 목록 가져오기 끝 ----- //

		List<Map<String, String>> allResourceList = null;
		allResourceList = service.getAllResourceList(); // 모든 자원 목록 가져오기
				
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(allResourceList != null) {
			for(Map<String, String> allResource_map : allResourceList) {
				JSONObject jsonObj = new JSONObject(); // {} 
				jsonObj.put("resourceId", allResource_map.get("resourceId"));
				jsonObj.put("fk_resourceCategoryId", allResource_map.get("fk_resourceCategoryId"));
				jsonObj.put("resourceName", allResource_map.get("resourceName"));
				
				jsonArr.put(jsonObj); // [{},{},{}]
			}// end of for------------
		}
		
		return jsonArr.toString();
	}
	
	
	/** 
	* @Method Name  : addReservation 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원 예약하기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("addReservation.gw")
	public String addReservation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
/* 로그인 확인을 위한 테스트코드 시작 */
HttpSession session = request.getSession();
EmployeeVO loginUser = new EmployeeVO();
loginUser.setEmpId((long) 9999); 
session.setAttribute("loginUser", loginUser);
/* 로그인 확인을 위한 테스트코드 끝 */		
		
		long loginEmpId = loginUser.getEmpId();
		String resourceId = request.getParameter("resourceId");
		String rsvStartDayTime = request.getParameter("rsvStartDayTime");
		String rsvEndDayTime = request.getParameter("rsvEndDayTime");
		String rsvReason = request.getParameter("rsvReason");
		
		
		Map<String, Object> option_map = new HashMap<>();
		option_map = service.getResourceOption(resourceId); // 승인여부, 반납필수여부 알아오기
		
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("loginEmpId", loginEmpId);
		paraMap.put("resourceId", resourceId);
		paraMap.put("rsvStartDayTime", rsvStartDayTime);
		paraMap.put("rsvEndDayTime", rsvEndDayTime);
		paraMap.put("rsvReason", rsvReason);
		paraMap.put("isApproval", option_map.get("isApproval")); // 승인여부 (0:승인없이예약가능, 1:승인필요함)
		paraMap.put("isReturn", option_map.get("isReturn")); // 반납필수여부 (0:반납필요없음, 1:반납필수임)
	
		
		int result = 0;
		List<Map<String, String>> existReservationList = null;
		existReservationList = service.selectReservation(paraMap); // 해당일시에 등록된 예약이 있는지 조회
		
		if(existReservationList.size() == 0) {// 해당일시에 등록된 예약이 없을 경우
			result = 1;
			service.addReservation(paraMap); // 예약하기 (자원예약 table에 insert)
		}
	
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("result", result);
	
		
		return jsonObj.toString();
	}
	
	
	
	/** 
	* @Method Name  : getReservationInfoDetail 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원예약 한 건에 대한 정보 가져오기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("getReservationInfoDetail.gw")
	public String getReservationInfoDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

/* 로그인 확인을 위한 테스트코드 시작 */
HttpSession session = request.getSession();
EmployeeVO loginUser = new EmployeeVO();
loginUser.setEmpId((long) 9999);
loginUser.setEmpName("어드민");		// @@@@@@@@@@ 여기는 이것도 있으니까 확인할 때 잊지마 
session.setAttribute("loginUser", loginUser);
/* 로그인 확인을 위한 테스트코드 끝 */		
		
		long loginEmpId = loginUser.getEmpId();
		String rsvResourceId = request.getParameter("rsvResourceId");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("loginEmpId", loginEmpId);
		
		
		List<ReservationVO> myReservationDetailInfo = null;
		
				
		// ----- 예약 상세정보 가져오기 시작 ----- // 
		paraMap.put("type", "oneDetailInfo");
		paraMap.put("rsvResourceId", rsvResourceId);
		myReservationDetailInfo = service.getmyReservationList(paraMap); 
	
	//	mav.addObject("myReservationDetailInfo", myReservationDetailInfo);
		// ----- 예약 상세정보 가져오기 끝 ----- // 
		
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(myReservationDetailInfo != null) {
			for(ReservationVO rsvvo : myReservationDetailInfo) {
				
				JSONObject jsonObj = new JSONObject(); // {} 
				jsonObj.put("rsvResourceId", rsvvo.getRsvResourceId());
				jsonObj.put("fk_empId", loginUser.getEmpName()); 
				
				jsonObj.put("resourceId", rsvvo.getResourceId());
				jsonObj.put("resourceName", rsvvo.getResourceName());
				jsonObj.put("resourceCategoryId", rsvvo.getResourceCategoryId());
				jsonObj.put("resourceCategoryName", rsvvo.getResourceCategoryName());
				
				jsonObj.put("rsvStartDayTime", rsvvo.getRsvStartDayTime());
				jsonObj.put("rsvEndDayTime", rsvvo.getRsvEndDayTime());
				jsonObj.put("rsvReason", rsvvo.getRsvReason());
				jsonObj.put("rsvStatus", rsvvo.getRsvStatus());
				
				jsonObj.put("approvalStatus", rsvvo.getApprovalStatus());
				jsonObj.put("approvalDay", rsvvo.getApprovalDay());
				jsonObj.put("fk_approvalEmpId", rsvvo.getFk_approvalEmpId());

				jsonObj.put("returnStatus", rsvvo.getReturnStatus());
				jsonObj.put("registerDay", rsvvo.getRegisterDay());
				jsonObj.put("updateDay", rsvvo.getUpdateDay());
				
				jsonArr.put(jsonObj); // [{},{},{}]
			}// end of for------------
		}
		
		return jsonArr.toString();
	}
	
	
	/** 
	* @Method Name  : getEmpInfo 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 사원 정보 가져오기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("getEmpInfo.gw")
	public Map<String, String> getEmpInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String empId = request.getParameter("empId");
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("empId", empId);
		
		Map<String, String> empInfo_map = new HashMap<>();
		empInfo_map = service.getEmpInfo(paraMap); // 사원 정보 가져오기

		return empInfo_map;
	}
	
	
	
	/** 
	* @Method Name  : delRservation 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약 삭제하기
	* @param request
	* @param response
	* @param mav
	* @return 
	*/
	@ResponseBody
	@GetMapping("delReservation.gw")
	public String delReservation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String rsvResourceId = request.getParameter("rsvResourceId");
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("rsvResourceId", rsvResourceId);
		
		
		int result = 0;
		result = service.delReservation(paraMap);

	
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("result", result);
	
		return jsonObj.toString();
	}
	
	
	
}

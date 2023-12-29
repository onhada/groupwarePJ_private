package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

public interface ReservationService {

	/** 
	* @Method Name  : getResourceCategory 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원카테고리 목록 가져오기
	* @return 
	*/
	List<Map<String, String>> getResourceCategoryList();

	/** 
	 * @param paraMap 
	* @Method Name  : getResourceList 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원 목록 가져오기
	* @return 
	*/
	List<Map<String, String>> getResourceList(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getResourceCategoryInfo_map 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원카테고리 정보 가져오기
	* @param paraMap
	* @return 
	*/
	Map<String, Object> getResourceCategoryInfo(Map<String, Object> paraMap);

}

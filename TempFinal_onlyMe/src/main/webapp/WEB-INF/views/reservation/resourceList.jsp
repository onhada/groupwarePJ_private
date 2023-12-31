<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<script type="text/javascript">

$(document).ready(function() {
	
	<%-- 카테고리설명 모달 열기 --%>
	$("span.category_detail_view").click(function() {
		if ($("div#category_detail_layer").hasClass("hide") == true) {
			$("div#category_detail_layer").removeClass("hide");
		}
	});

	
	<%-- 자원설명 모달 열기 --%>
	$("span.resource_detail_view").click(function(e) {
		if ($("div#resource_detail_layer").hasClass("hide") == true) {
			$.ajax({
	        	url : "<%=ctxPath%>/reservation/getResourceInfo.gw",
				type : "get",
				data : {"resourceId" : $(e.target).attr("resourceId")},
				dataType : "json",
				async : false,
				success : function(json) {
					$("div#resource_detail_layer").find(".rs-name").text(json.resourceInfo_map.resourceName);
					$("div#resource_detail_layer").find(".rs-detail-text").text(json.resourceInfo_map.description);
					$("div#resource_detail_layer").find(".rs-imgFile").attr("src", "<%= ctxPath%>/resources/image/reservation/"+json.resourceInfo_map.imageFile);
				},
				error : function(request, status, error) {
					alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				}
			});
			
			$("div#resource_detail_layer").removeClass("hide");
		}
	});
	
	
	
	
	
	
})// end of $(document).ready(function(){})-------------------------



// Function Declaration




</script>




<div id="contents" style="left: 276px;">
	<div class="setting_title">
		<h3>
			${requestScope.resourceCategoryInfo_map.resourceCategoryName}
			<span class="show-rs-info category_detail_view">i</span>
		</h3>
	</div>
	<div class="content_inbox" style="overflow-y: hidden;">
		<!-- Contents -->
		<div class="rs-wrap" style="margin: 0;">
			<!-- 검색이 존재할 경우 -->
			<ul class="tabType1 mgb_30 hide" id="booking_search_tab_ul">
				<input type="hidden" value="" id="booking_search_name_hidden">
			</ul>
			<!-- // 검색이 존재할 경우 -->
			
		<!-- 이거 쓸거면 맞게 수정해 수정필 
			<input type="hidden" value="287" id="category_no_hidden">
			<input type="hidden" value="T" id="resource_type_hidden">
		 -->	
			<div class="cal_head" id="cal_head_fixed_div" style="padding-right: 28px; padding-left: 20px;">
				
				<div id="cal_head_fixed_div_area">
					<button type="button" class="icon directleft" id="moveDate" onclick="moveDate('prev');">
						<span class="blind">전일 이동</span>
					</button>
					<input type="text" id="viewReservationDate" class="num datepicker" style="width: 110px; border: none; margin-right: 5px;" readonly="">
					<!-- <span id="week_name_span">(금)</span> -->
					<label for="viewReservationDate"> 
						<img class="ui-datepicker-trigger icon month" src="<%=ctxPath%>/resources/image/icon/sp_icon.png" alt="예약 날짜 선택" title="예약 날짜 선택">
					</label>
					<button type="button" class="icon directright" onclick="moveDate('next');">
						<span class="blind">익일 이동</span>
					</button>
					<button type="button" class="today-btn vt" onclick="moveDate('today');">오늘</button>
				</div>
				
				<div id="tbl_head_fixed_div_area">
					<table class="rs-cal-table" id="booking_clone_tbl">
						<colgroup id="resource_list_colgroup">
							<col width="80">
							<c:forEach var="item" varStatus="i" begin="1" end="${fn:length(requestScope.resourceList)}" step="1">
								<col width="">
							</c:forEach>
							<col width="80">
						</colgroup>
						<tbody>
							<tr>

								<td style="border-bottom: none;">
									<table>
										<thead class="booking_resource_img_top">
											<tr>
												<th scope="col" style="padding: 7px 0;"></th>
											</tr>
											<tr class="rs-bg">
												<td class="rs-btn left cpointer" style="cursor: default;" id="booking_prev_page"></td>
											</tr>
											<tr>
												<td class="rs-divider-td">
													<hr class="rs-divider">
												</td>
											</tr>
										</thead>
									</table>
								</td>

								<%-- 자원 목록 가져오기 --%>
								<c:if test="${not empty requestScope.resourceList || fn:length(requestScope.resourceList) > 0}">
									<c:forEach var="resource" items="${requestScope.resourceList}">
										<td style="border-bottom: none;">
											<table class="rs-resource-tbl" resourceId="${resource.resourceId}">
												<thead class="rs-view booking_resource_img_top">
													<tr>
														<th scope="col">
															<span class="resource_name_span" title="${resource.resourceName}">${resource.resourceName}</span>
															<span class="show-rs-info resource_detail_view" r_type="R" resourceId="${resource.resourceId}">i</span>
														</th>
													</tr>
													<tr class="rs-bg">
														<td class="">
															<img src="<%= ctxPath%>/resources/image/reservation/${resource.imageFile}" alt="">
														</td>
													</tr>
													<tr>
														<td class="rs-divider-td">
															<hr class="rs-divider">
														</td>
													</tr>
												</thead>
											</table>
										</td>
									</c:forEach>
								</c:if>

							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="rs-view" id="tbl_body_div" style="height: 435px;">
				<div class="dropdown hide" id="showMoreResource">
					<ul class="dropdown-menu" id="page_list_ul">
					</ul>
				</div>
				<table class="rs-cal-table" id="booking_main_tbl">
					<colgroup id="resource_list_colgroup">
						<col width="80">
						<c:forEach var="item" varStatus="i" begin="1" end="${fn:length(requestScope.resourceList)}" step="1">
							<col width="">
						</c:forEach>
						<col width="80">
					</colgroup>
					<tbody>
						<tr id="resource_list_tr">
							<td style="border-bottom: none;">
								<table>
									<tbody class="time-div rs-time-title h1032 time_table_tbody_area">
										<c:forEach var="item" varStatus="i" begin="0" end="23" step="1">
											<tr>
												<th class="rs-time-pri">${item}시</th>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</td>
							
							<%-- 자원 목록 수만큼 테이블 만들기 --%>
							<c:if test="${not empty requestScope.resourceList || fn:length(requestScope.resourceList) > 0}">
								<c:forEach var="resource" items="${requestScope.resourceList}">
									<td style="border-bottom: none;">
										<table class="rs-resource-tbl" no="405">
											<tbody class="marker-wrapper resource_selectable_area h1032 time_table_tbody_area ui-selectable">
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="0"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="0"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="1"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="1"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="2"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="2"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="3"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="3"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="4"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="4"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="5"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="5"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="6"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="6"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before BKCP booking_detail_view ui-selectee" time="7" booking_no="1761" mode="start" rowspan="6" style="height: 132px;">관리자</td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="7" style="display: none;"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="8" style="display: none;"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="8" style="display: none;"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="9" style="display: none;"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after BKCP booking_detail_view ui-selectee" time="9" booking_no="1761" mode="end" style="display: none;">관리자</td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="10"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="10"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="11"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="11"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="12"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="12"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="13"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="13"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="14"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="14"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="15"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="15"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="16"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="16"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="17"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="17"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="18"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="18"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="19"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="19"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="20"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="20"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="21"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="21"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="22"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="22"></td>
												</tr>
												<tr>
													<td class="rs-dualmarker rs_time_before ui-selectee" time="23"></td>
												</tr>
												<tr class="rs-dualmarker-21">
													<td class="rs_time_after ui-selectee" time="23"></td>
												</tr>
											</tbody>
										</table>
									</td>
								</c:forEach>
							</c:if>	
							
							<!-- 
							<td style="border-bottom: none;">
								<table class="rs-resource-tbl" no="405">
									<tbody class="marker-wrapper resource_selectable_area h1032 time_table_tbody_area ui-selectable">
										<tr>
											<td class="rs-dualmarker rs_time_before BKCP booking_detail_view ui-selectee" time="0" booking_no="1756" mode="start" rowspan="48" style="height: 1056px;">관리자</td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="0" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="1" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="1" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="2" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="2" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="3" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="3" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="4" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="4" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="5" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="5" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="6" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="6" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="7" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="7" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="8" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="8" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="9" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="9" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="10" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="10" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="11" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="11" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="12" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="12" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="13" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="13" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="14" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="14" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="15" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="15" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="16" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="16" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="17" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="17" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="18" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="18" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="19" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="19" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="20" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="20" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="21" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="21" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="22" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="22" style="display: none;"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="23" style="display: none;"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after BKCP booking_detail_view ui-selectee" time="23" booking_no="1756" mode="end" style="display: none;">관리자</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td style="border-bottom: none;">
								<table class="rs-resource-tbl" no="431">
									<tbody class="marker-wrapper resource_selectable_area h1032 time_table_tbody_area ui-selectable">
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="0"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="0"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="1"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="1"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="2"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="2"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="3"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="3"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="4"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="4"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="5"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="5"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="6"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="6"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="7"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="7"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="8"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="8"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="9"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="9"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="10"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="10"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="11"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="11"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="12"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="12"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="13"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="13"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="14"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="14"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="15"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="15"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="16"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="16"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="17"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="17"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="18"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="18"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="19"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="19"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="20"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="20"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="21"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="21"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="22"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="22"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="23"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="23"></td>
										</tr>
									</tbody>
								</table>
							</td>
							<td style="border-bottom: none;">
								<table class="rs-resource-tbl" no="432">
									<tbody class="marker-wrapper resource_selectable_area h1032 time_table_tbody_area ui-selectable">
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="0"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="0"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="1"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="1"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="2"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="2"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="3"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="3"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="4"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="4"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="5"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="5"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="6"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="6"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="7"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="7"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="8"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="8"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="9"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="9"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="10"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="10"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="11"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="11"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="12"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="12"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="13"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="13"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="14"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="14"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="15"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="15"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="16"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="16"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="17"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="17"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="18"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="18"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="19"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="19"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="20"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="20"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="21"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="21"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="22"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="22"></td>
										</tr>
										<tr>
											<td class="rs-dualmarker rs_time_before ui-selectee" time="23"></td>
										</tr>
										<tr class="rs-dualmarker-21">
											<td class="rs_time_after ui-selectee" time="23"></td>
										</tr>
									</tbody>
								</table>
							</td> 
							-->
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- Contents End-->
	</div>

</div>





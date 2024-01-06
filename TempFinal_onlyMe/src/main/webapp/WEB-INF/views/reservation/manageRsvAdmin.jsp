<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>






<div id="contents" style="left: 276px;">
	<div class="setting_title">
		<h3>예약 관리자</h3>
	</div>
	<div class="content_inbox">
		<!-- Contents -->
		<div class="setting_field">
			<a href="javascript:void(0)" onclick="rsvAdminAddModalOpen();" class="weakblue">
				<span class="sms_plus"></span>
				관리자 추가
			</a>
			<div class="pdt_20">
				<table class="tableType01 rs-table">
					<colgroup>
						<col width="">
						<col width="">
						<col width="">
						<col width="">
						<col width="">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">이름</th>
							<th scope="col">아이디</th>
							<th scope="col">소속</th>
							<th scope="col">등록일</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody id="booking_admin_list">
						<c:if test="${not empty requestScope.rsvAdminList || fn:length(requestScope.rsvAdminList) > 0}">
						<c:forEach var="rsvAdmin" items="${requestScope.rsvAdminList}">
							<tr no="${rsvAdmin.empId}">
								<td>${rsvAdmin.empName}</td>
								<td>${rsvAdmin.email}</td>
								<td>[${rsvAdmin.depName}] ${rsvAdmin.teamName}</td>
								<td>${rsvAdmin.registerDay}</td>
								<td>
									<c:if test="${rsvAdmin.email != 'admin'}">
										<button type="button" name="button" class="weakblue del_admin_btn">삭제</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="pdt_20">
				<p>
					총
					<span id="total_cnt">${requestScope.rsvAdmintotalCount}</span>
					명
				</p>
			</div>
		</div>
		<!-- Contents End-->
	</div>
</div>
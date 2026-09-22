<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp"/>

<style>
    .dashboard-container { padding: 20px; }
    .dashboard-container h1 { margin: 0 0 20px; color: #333; }
    .summary-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 16px; }
    .summary-card, .dashboard-section { background: #fff; border-radius: 8px; padding: 22px; box-shadow: 0 2px 6px rgba(0,0,0,.1); }
    .summary-card { border-left: 4px solid #4CAF50; }
    .summary-card h3 { margin: 0 0 10px; color: #666; font-size: 14px; }
    .summary-card strong { font-size: 30px; color: #333; }
    .dashboard-section { margin-top: 20px; }
    .dashboard-section h2 { margin: 0 0 15px; padding-bottom: 10px; border-bottom: 2px solid #4CAF50; font-size: 18px; }
    .stats-table { width: 100%; border-collapse: collapse; }
    .stats-table th, .stats-table td { padding: 11px; border-bottom: 1px solid #eee; text-align: left; }
    .stats-table th { background: #f8f9fa; }
    .empty { padding: 30px; color: #888; text-align: center; }
</style>

<div class="dashboard-container">
    <h1>${pageTitle}</h1>
    <div class="summary-grid">
        <div class="summary-card"><h3>전체 게시글</h3><strong><fmt:formatNumber value="${postStatusStats.total_cnt != null ? postStatusStats.total_cnt : 0}" pattern="#,##0"/></strong></div>
        <div class="summary-card"><h3>대기</h3><strong><fmt:formatNumber value="${postStatusStats.wait_cnt != null ? postStatusStats.wait_cnt : 0}" pattern="#,##0"/></strong></div>
        <div class="summary-card"><h3>처리중</h3><strong><fmt:formatNumber value="${postStatusStats.proc_cnt != null ? postStatusStats.proc_cnt : 0}" pattern="#,##0"/></strong></div>
        <div class="summary-card"><h3>완료</h3><strong><fmt:formatNumber value="${postStatusStats.comp_cnt != null ? postStatusStats.comp_cnt : 0}" pattern="#,##0"/></strong></div>
        <div class="summary-card"><h3>보류</h3><strong><fmt:formatNumber value="${postStatusStats.hold_cnt != null ? postStatusStats.hold_cnt : 0}" pattern="#,##0"/></strong></div>
    </div>
    <div class="dashboard-section">
        <h2>오늘의 접속 현황</h2>
        <c:choose>
            <c:when test="${empty dailyStats}"><div class="empty">오늘 집계된 접속 데이터가 없습니다.</div></c:when>
            <c:otherwise>
                <table class="stats-table"><thead><tr><th>기준일</th><th>접속 사용자</th><th>접속 횟수</th><th>게시글 수</th></tr></thead><tbody>
                    <c:forEach items="${dailyStats}" var="stat"><tr>
                        <td><fmt:formatDate value="${stat.stat_date}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatNumber value="${stat.user_cnt}" pattern="#,##0"/></td>
                        <td><fmt:formatNumber value="${stat.access_cnt}" pattern="#,##0"/></td>
                        <td><fmt:formatNumber value="${stat.board_cnt}" pattern="#,##0"/></td>
                    </tr></c:forEach>
                </tbody></table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp"/>
<style>
 .detail{max-width:1100px;margin:20px auto}.card{background:#fff;padding:24px;margin-bottom:20px;border-radius:8px;box-shadow:0 2px 6px #0001}
 h1{margin:0 0 18px}.info{width:100%;border-collapse:collapse}.info th,.info td{padding:12px;border-bottom:1px solid #eee;text-align:left}.info th{width:180px;background:#f8f9fa}.actions{text-align:center;margin-top:20px}.btn{display:inline-block;padding:9px 18px;margin:0 4px;border:0;border-radius:4px;text-decoration:none;cursor:pointer}.primary{background:#4caf50;color:#fff}.secondary{background:#777;color:#fff}.danger{background:#e53935;color:#fff}.empty{text-align:center;padding:30px;color:#888}
</style>
<div class="detail">
 <div class="card"><h1>${pageTitle}</h1>
  <table class="info">
   <tr><th>게시판 ID</th><td>${boardInfo.board_id}</td><th>시스템</th><td>${boardInfo.sys_id}</td></tr>
   <tr><th>게시판명</th><td>${boardInfo.board_title}</td><th>유형</th><td>${boardInfo.board_type}</td></tr>
   <tr><th>게시판 설명</th><td colspan="3">${boardInfo.board_desc}</td></tr>
   <tr><th>페이지당 게시물</th><td>${boardInfo.page_post_cnt}</td><th>첨부파일 최대 개수</th><td>${boardInfo.file_max_cnt}</td></tr>
   <tr><th>답변</th><td>${boardInfo.reply_yn eq 'Y' ? '사용' : '미사용'}</td><th>비밀글</th><td>${boardInfo.secret_use_yn eq 'Y' ? '사용' : '미사용'}</td></tr>
   <tr><th>등록일</th><td colspan="3"><fmt:formatDate value="${boardInfo.reg_dt}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
  </table>
  <div class="actions"><a class="btn primary" href="${pageContext.request.contextPath}/admin/board/form?boardId=${boardInfo.board_id}">수정</a><button class="btn danger" onclick="deleteBoard()">삭제</button><a class="btn secondary" href="${pageContext.request.contextPath}/admin/board/list">목록</a></div>
 </div>
 <div class="card"><h2>추가 입력 항목</h2>
  <c:choose><c:when test="${empty boardFieldList}"><div class="empty">등록된 추가 항목이 없습니다.</div></c:when><c:otherwise><table class="info"><thead><tr><th>항목명</th><th>유형</th><th>필수</th><th>목록 표시</th></tr></thead><tbody><c:forEach items="${boardFieldList}" var="field"><tr><td>${field.field_nm}</td><td>${field.field_type}</td><td>${field.required_yn eq 'Y' ? '예' : '아니오'}</td><td>${field.list_use_yn eq 'Y' ? '예' : '아니오'}</td></tr></c:forEach></tbody></table></c:otherwise></c:choose>
 </div>
</div>
<script>
function deleteBoard(){if(!confirm('게시판을 삭제하시겠습니까?'))return;fetch('${pageContext.request.contextPath}/admin/board/delete',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'boardId=${boardInfo.board_id}'}).then(r=>r.json()).then(d=>{if(d.success)location.href='${pageContext.request.contextPath}/admin/board/list';else alert(d.message||'삭제에 실패했습니다.');}).catch(()=>alert('삭제 중 오류가 발생했습니다.'));}
</script>
<jsp:include page="../layout/footer.jsp"/>

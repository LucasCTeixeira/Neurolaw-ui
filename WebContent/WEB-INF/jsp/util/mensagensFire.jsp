<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/sweetalert2.all.min.js"></script>
<!-- Optional: include a polyfill for ES6 Promises for IE11 -->
<script src="//cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js"></script>

<c:if test="${ requestScope.msg_success ne null }">
	<script>
	Swal.fire({
		  title: '<fmt:message key="dlg.success.title" />',
		  text: '${requestScope.msg_success}',
		  icon: 'success',
		  confirmButtonText: 'Fechar'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_error ne null }">
	<script>
	Swal.fire({
		  title: '<fmt:message key="dlg.error.title" />',
		  text: '${requestScope.msg_error}',
		  icon: 'error',
		  confirmButtonText: 'Fechar'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_alert ne null }">
	<script>
	Swal.fire({
		  title: '<fmt:message key="dlg.alert.title" />',
		  text: '${requestScope.msg_alert}',
		  icon: 'warning',
		  confirmButtonText: 'Fechar'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_info ne null }">
	<script>
	Swal.fire({
		  title: '<fmt:message key="dlg.info.title" />',
		  text: '${requestScope.msg_info}',
		  icon: 'info',
		  confirmButtonText: 'Fechar'
		})
	</script>
</c:if>
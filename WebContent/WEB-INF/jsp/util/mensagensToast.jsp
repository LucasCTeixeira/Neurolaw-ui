<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/sweetalert2.all.min.js"></script>
<!-- Optional: include a polyfill for ES6 Promises for IE11 -->
<script src="//cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js"></script>

<c:if test="${ requestScope.msg_success ne null }">
	<script>
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'top-end',
		  showConfirmButton: false,
		  timer: 2000,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})
	
		Toast.fire({
		  icon: 'success',
		  title: '${requestScope.msg_success}'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_error ne null }">
	<script>
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'top',
		  showConfirmButton: false,
		  timer: 5000,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})
	
		Toast.fire({
		  icon: 'error',
		  title: '${requestScope.msg_error}'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_danger ne null }">
	<script>
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'top',
		  showConfirmButton: false,
		  timer: 5000,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})
	
		Toast.fire({
		  icon: 'error',
		  title: '${requestScope.msg_danger}'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_alert ne null }">
	<script>
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'top',
		  showConfirmButton: false,
		  timer: 5000,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})
	
		Toast.fire({
		  icon: 'warning',
		  title: '${requestScope.msg_alert}'
		})
	</script>
</c:if>

<c:if test="${ requestScope.msg_info ne null }">
	<script>
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'center',
		  showConfirmButton: false,
		  timer: 5000,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})
	
		Toast.fire({
		  icon: 'info',
		  title: '${requestScope.msg_info}'
		})
	</script>
</c:if>
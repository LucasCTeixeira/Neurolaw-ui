<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Toastr -->
<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/jquery/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.servletConfig.servletContext.contextPath}/plugins/toastr/toastr.min.css">
<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/toastr/toastr.min.js"></script>

	<script>
		function exibirToast(tipo, tempo, msg){
		toastr.options = {
				  "closeButton": true,
				  "debug": false,
				  "newestOnTop": true,
				  "progressBar": true,
				  "positionClass": "toast-top-right",
				  "preventDuplicates": false,
				  "onclick": null,
				  "showDuration": "300",
				  "hideDuration": "1000",
				  "timeOut": tempo,
				  "extendedTimeOut": "1000",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				}

			switch (tipo) {
			  case 'success':
				  toastr.success(msg)
			    break;
			  case 'error':
				  toastr.error(msg)
			    break;
			  case 'warning':
				  toastr.warning(msg)
			    break;
			  case 'info':
				  toastr.info(msg)
			    break;
			  default:			    
			}			
			
		}	
	</script>


<c:if test="${requestScope.msg_success ne null}">
	<script>
		exibirToast('success', 2000, '${requestScope.msg_success}');
	</script>
</c:if>

<c:if test="${ requestScope.msg_error ne null }">
	<script>
		exibirToast('error', 5000, '${requestScope.msg_error}');
	</script>
</c:if>

<c:if test="${ requestScope.msg_danger ne null }">
	<script>
		exibirToast('error', 5000, '${requestScope.msg_danger}');
	</script>
</c:if>

<c:if test="${ requestScope.msg_alert ne null }">
	<script>
		exibirToast('warning', 5000, '${requestScope.msg_alert}');
	</script>
</c:if>

<c:if test="${ requestScope.msg_info ne null }">
	<script>
		exibirToast('info', 5000, '${requestScope.msg_info}');
	</script>
</c:if>
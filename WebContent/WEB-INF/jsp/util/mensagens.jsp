<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
	window.setTimeout(function() {
		posicionarMsg();
	}, 1);
	window.setTimeout(function() {
		cronometro();
	}, 1000);
	var cronometros = [ "cronomsgSuccess", "cronomsgDanger", "cronomsgError",
			"cronomsgInfo", "cronomsgAlert" ];
	function posicionarMsg() {
		var menu = document.getElementById("divMenu");
		if (menu == null) {
			$('.alert').each(function() {
				$(this).css('top', '0px');
			});
		}
		for ( var i = 0; i < cronometros.length; i++) {
			div = document.getElementById(cronometros[i]);
			if (div != null) {
				if (div.innerHTML == 0) {
					div = document.getElementById(cronometros[i].replace(
							"crono", "auto"));
					$(div).remove();
				}
			}
		}
	}
	function cronometro() {
		var div = null;
		for ( var i = 0; i < cronometros.length; i++) {
			div = document.getElementById(cronometros[i]);
			if (div != null) {
				div.innerHTML = parseInt(div.innerHTML) - 1;
				if (div.innerHTML == 0) {
					div = document.getElementById(cronometros[i].replace(
							"crono", ""));
					$(div).remove();
				}
			}
		}
		var looping = false;
		for ( var i = 0; i < cronometros.length; i++) {
			div = document.getElementById(cronometros[i]);
			if (div != null) {
				if (parseInt(div.innerHTML) > 0) {
					looping = true;
					break;
				}
			}
		}
		if (looping) {
			window.setTimeout(function() {
				cronometro();
			}, 1000);
		}
	}
	function cancelAutoClose(msgId) {
		div = document.getElementById(msgId);
		$(div).remove();
	}
</script>

<style>
.autoclose {
	color: #888;
	font-style: normal;
	font-weight: bold;
	float: right;
	font-size: 12px;
}

</style>

<!-- 
.alert-info {
    background-color: #d9edf7;
    border-color: #bcdff1;
    color: #31708f;
}


.alert-warning {
    background-color: #fcf8e3;
    border-color: #faf2cc;
    color: #8a6d3b;
}

.alert-danger {
    background-color: #f2dede;
    border-color: #ebcccc;
    color: #a94442;
}
 -->
 
<c:if test="${ requestScope.msg_success ne null }">
	<div id="msgSuccess" class="alert alert-success" role="alert" style="background-color: #dff0d8; border-color: #d0e9c6; color: #3c763d; 
	position: relative; text-align: center; width: 70%; margin:0 auto; margin-top: 1px; margin-bottom: 0px">
		<a class="close" data-dismiss="alert" href="#"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/close.png"></a>
		<div id="automsgSuccess" class='autoclose'>
			<img
				onmouseover="this.style.cursor='pointer';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_2_16x16.png'"
				onmouseout="this.style.cursor='default';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'"
				border='0' onclick="javascript:cancelAutoClose('automsgSuccess');"
				src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'> [<span
				id='cronomsgSuccess'>5</span>]
		</div>
		<h4 class="success-heading"><fmt:message key="dlg.success.title" /></h4>
		${requestScope.msg_success}
	</div>
</c:if>

<c:if test="${ requestScope.msg_danger ne null }">
	<div id="msgDanger" class="alert alert-danger" role="alert" style="background-color: #f2dede; border-color: #ebcccc; color: #a94442; 
	position: relative; text-align: center; width: 70%; margin:0 auto; margin-top: 1px; margin-bottom: 0px">
		<a class="close" data-dismiss="alert" href="#"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/close.png"></a>
		<div id="automsgDanger" class='autoclose'>
			<img
				onmouseover="this.style.cursor='pointer';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_2_16x16.png'"
				onmouseout="this.style.cursor='default';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'"
				border='0' onclick="javascript:cancelAutoClose('automsgDanger');"
				src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'> [<span
				id='cronomsgDanger'>15</span>]
		</div>
		<h4 class="danger-heading"><fmt:message key="dlg.danger.title" /></h4>
		${requestScope.msg_danger}
	</div>
</c:if>

<c:if test="${ requestScope.msg_error ne null }">
	<div id="msgError" class="alert alert-error" role="alert" style="background-color: #f2dede; border-color: #ebcccc; color: #a94442; 
	position: relative; text-align: center; width: 70%; margin:0 auto; margin-top: 1px; margin-bottom: 0px">
		<a class="close" data-dismiss="alert" href="#"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/close.png"></a>
		<div id="automsgError" class='autoclose'>
			<img
				onmouseover="this.style.cursor='pointer';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_2_16x16.png'"
				onmouseout="this.style.cursor='default';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'"
				border='0' onclick="javascript:cancelAutoClose('automsgError');"
				src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'> [<span
				id='cronomsgError'>15</span>]
		</div>
		<h4 class="error-heading"><fmt:message key="dlg.error.title" /></h4>
		${requestScope.msg_error}
	</div>
</c:if>

<c:if test="${ requestScope.msg_info ne null }">
	<div id="msgInfo" class="alert alert-info" role="alert" style="background-color: #d9edf7; border-color: #bcdff1; color: #31708f; 
	position: relative; text-align: center; width: 70%; margin:0 auto; margin-top: 1px; margin-bottom: 0px">
		<a class="close" data-dismiss="alert" href="#"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/close.png"></a>
		<div id="automsgInfo" class='autoclose'>
			<img
				onmouseover="this.style.cursor='pointer';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_2_16x16.png'"
				onmouseout="this.style.cursor='default';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'"
				border='0' onclick="javascript:cancelAutoClose('automsgInfo');"
				src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'> [<span
				id='cronomsgInfo'>15</span>]
		</div>
		<h4 class="info-heading"><fmt:message key="dlg.info.title" /></h4>
		${requestScope.msg_info}
	</div>
</c:if>

<c:if test="${ requestScope.msg_alert ne null }">
	<div id="msgAlert" class="alert alert-warning" role="alert" style="background-color: #fcf8e3; border-color: #faf2cc; color: #8a6d3b; 
	position: relative; text-align: center; width: 70%; margin:0 auto; margin-top: 1px; margin-bottom: 0px">
		<a class="close" data-dismiss="alert" href="#"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/close.png"></a>
		<div id="automsgAlert" class='autoclose'>
			<img
				onmouseover="this.style.cursor='pointer';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_2_16x16.png'"
				onmouseout="this.style.cursor='default';this.src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'"
				border='0' onclick="javascript:cancelAutoClose('automsgWarning');"
				src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/watch_msg_16x16.png'> [<span
				id='cronomsgAlert'>15</span>]
		</div>
		<h4 class="warning-heading"><fmt:message key="dlg.alert.title" /></h4>
		${requestScope.msg_alert}
	</div>
</c:if>
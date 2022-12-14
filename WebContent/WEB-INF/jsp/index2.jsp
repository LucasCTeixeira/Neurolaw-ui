<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<jsp:include page="util/paginaBasica.jsp" />
<c:choose>
	<c:when test="${ usuarioLogado ne null }">
		<jsp:forward page="domain/logado.jsp" />
	</c:when>
</c:choose>

</head>
<body onload="document.form1.txtLogin.focus();">

	<div class="container" align="center">
	  <div class="row">
	    <div class="span7 offset5">
	    
			<form method="post" name="form1" class="form-horizontal" action="${pageContext.servletConfig.servletContext.contextPath}/ValidarLoginServlet?url=${param.url}">
			  <div class="control-group">
			    <label class="control-label" for="txtLogin">
			    	<fmt:message key="page.login.field.user.label" />
			    </label>
			    <div class="controls">
			      <input type="text" id="txtLogin" name="txtLogin" placeholder="<fmt:message key="page.login.field.user.label" />">
			    </div>
			  </div>
			  <div class="control-group">
			    <label class="control-label" for="txtSenha"><fmt:message key="page.login.field.password.label" /></label>
			    <div class="controls">
			      <input type="password" id="txtSenha" name="txtSenha" placeholder="<fmt:message key="page.login.field.password.label" />">
			    </div>
			  </div>
			  <div class="control-group">
			    <div class="controls">
			      <label class="checkbox">
			        <input type="checkbox" name="chkLembrarSenha" value=""> <fmt:message key="page.login.field.remember.label" />
			      </label>
			      <button type="submit" class="btn"><fmt:message key="page.login.button.ok.title" /></button>
			    </div>
			  </div>
			</form>
		</div>
		<div class="row">
			<a href='${pageContext.servletConfig.servletContext.contextPath}/rescuePassword.jsp'>
				<fmt:message key="page.login.link.forgot.password" />
			</a>
		</div>	
	  </div>  
	</div>

</body>
</html>
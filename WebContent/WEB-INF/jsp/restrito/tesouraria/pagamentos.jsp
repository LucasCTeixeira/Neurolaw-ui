<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="shortcut icon" href="${pageContext.servletConfig.servletContext.contextPath}/favicon.ico" type="image/x-icon" />
</head>

<body>
<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

	<center>
	<h1><b>Listando Pagamentos</b></h1>
	<div id="grid" style="width: 90%" align="center">
		<table id="example" class="display" style="width: 100%" align="left">
			<thead align="left">
				<tr>
					<th>ID</th>
					<th>Descrição</th>
					<th>Filial</th>
					<th>Usuário</th>
					<th>Valor Declarado</th>
					<th>Valor Recebindo</th>
					<th>Saldo R$</th>
					<th>Ação</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${registros}" var="registro">
					<tr>
						<td><c:out value="${registro.key}"></c:out></td>
						<td><c:out value="${registro.descricao}"></c:out><div style="display: none;"></div></td>
						<td><c:out value="${registro.filial.nome}"></c:out></td>
						<td><c:out value="${registro.usuario.nome}"></c:out></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorPago}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado-registro.valorPago}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td>
						    <c:choose>
						      <c:when test="${registro.entrada.key ne null}">
						      	&nbsp;&nbsp;&nbsp;
								<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/entradas/detalhar/<c:out value="${registro.entrada.key}"></c:out>?dt_pag=1'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/wired.png">
						      </c:when>				
						      <c:otherwise>
								<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/pagamentos/editar/<c:out value="${registro.key}"></c:out>'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/edit.png">&nbsp;&nbsp;&nbsp;
								<img style="cursor: pointer" onclick="javascript:confirmarExclusao(<c:out value="${registro.key}"></c:out>, '<c:out value="${registro.descricao}"></c:out>', '${pageContext.servletConfig.servletContext.contextPath}/pagamentos/remover/<c:out value="${registro.key}"></c:out>');" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png">
						      </c:otherwise>
						    </c:choose>
							&nbsp;&nbsp;&nbsp;<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/pagamentos/detalhar/<c:out value="${registro.key}"></c:out>'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/zoom_in.png">
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot align="left">
				<tr>
					<th>ID</th>
					<th>Descrição</th>
					<th>Filial</th>
					<th>Usuário</th>
					<th>Valor Declarado</th>
					<th>Valor Recebindo</th>
					<th>Saldo R$</th>
					<th>Ação</th>
				</tr>
			</tfoot>
		</table>
	</div>
	<button type="button" class="btn btn-warning" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/pagamentos/adicionar'">ADICIONAR UM NOVO PAGAMENTO</button>
	</center>

<jsp:include page="../../util/rodape.jsp" />

</body>
</html>
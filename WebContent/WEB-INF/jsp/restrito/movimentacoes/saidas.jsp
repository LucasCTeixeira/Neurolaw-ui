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
    <div class="page-header">
     	<h1><b>Listando Saidas</b></h1>
    </div>
	<div id="grid" style="width: 90%" align="center">
		<table id="example" class="display" style="width: 100%" align="left">
			<thead align="left">
				<tr>
					<th>ID</th>
					<th>Data</th>
					<th>Filial</th>
					<th>Usuário</th>
					<th>R$</th>
					<th>Ações</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${registros}" var="registro">
					<tr>
						<td><c:out value="${registro.key}"></c:out></td>
						<td><fmt:formatDate pattern = "dd/MM/yyyy HH:mm" value = "${registro.createDate}" /></td>
						<td><c:out value="${registro.filial.nome}"></c:out></td>
						<td><c:out value="${registro.usuario.nome}"></c:out></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorTotal}"/></td>
						<td>
							<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/saidas/editar/<c:out value="${registro.key}"></c:out>'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/edit.png">&nbsp;&nbsp;&nbsp;
							<img style="cursor: pointer" onclick="javascript:confirmarExclusao(<c:out value="${registro.key}"></c:out>, '<c:out value="${registro.key}"></c:out>', '${pageContext.servletConfig.servletContext.contextPath}/saidas/remover/<c:out value="${registro.key}"></c:out>');" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png">&nbsp;&nbsp;&nbsp;
							<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/saidas/detalhar/<c:out value="${registro.key}"></c:out>'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/zoom_in.png">
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot align="left">
				<tr>
					<th>ID</th>
					<th>Data</th>
					<th>Filial</th>
					<th>Usuário</th>
					<th>R$</th>
					<th>Ações</th>
				</tr>
			</tfoot>
		</table>
	</div>
	<button type="button" class="btn btn-warning" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/saidas/adicionar'">ADICIONAR UMA NOVA SAIDA</button>
	</center>

<jsp:include page="../../util/rodape.jsp" />

</body>
</html>
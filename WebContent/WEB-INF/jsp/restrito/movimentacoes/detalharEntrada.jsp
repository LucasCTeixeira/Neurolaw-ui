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

<body>

	<center>
    <div class="page-header">
      <h1><b>Detalhar Entrada #<c:out value="${entrada.key}"></c:out></b></h1>
    </div>
	<div id="grid" style="width: 90%" align="center">
		<table id="example" class="display" style="width: 100%" align="left">
			<thead align="left">
				<tr>
					<th colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
						<b>Filial</b>&nbsp;&nbsp;&nbsp;
					</th>
					<td colspan="5" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
						<c:out value="${entrada.filial.nome}"></c:out>
					</td>
				</tr>
				<tr>
					<th colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
						<b>Usuário</b>&nbsp;&nbsp;&nbsp;
					</th>
					<td colspan="5" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
						<c:out value="${entrada.usuario.nome}"></c:out>
					</td>
				</tr>
				<tr>
					<th colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
						<b>Data</b>&nbsp;&nbsp;&nbsp;
					</th>
					<td colspan="5" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
						<fmt:formatDate value="${entrada.createDate}" type="both" pattern="dd/MM/yyyy HH:mm"/>
					</td>
				</tr>
				<tr>
					<th colspan="6" align="left">
					Itens da Entrada
					</th>
				</tr>				
				<tr>
					<th>#</th>
					<th>Produto</th>
					<th>Fornecedor</th>
					<th>Valor Unitário</th>
					<th>Quantidade</th>
					<th>Subtotal</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${entrada.itens}" var="item">
					<tr>
						<td><c:out value="${item.indice}"></c:out></td>
						<td><c:out value="${item.produto.descricao}"></c:out></td>
						<td><c:out value="${item.fornecedor.nome}"></c:out></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${item.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber type="number" value="${item.quantidade}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${item.quantidade*item.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot align="left">
				<tr>
					<th colspan="5" align="right">
						<b>TOTAL</b>&nbsp;&nbsp;&nbsp;
					</th>
					<th colspan="1" align="left">
						<fmt:formatNumber type="currency" currencySymbol="R$" value="${entrada.valorTotal}" minFractionDigits="2" maxFractionDigits="2"/>
					</th>
				</tr>
				<tr>
					<th colspan="6" align="center" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray">
						<br>
					    <c:choose>
					      <c:when test="${param.dt_pag eq 1}">
							<button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/pagamentos/'">VOLTAR</button>						
					      </c:when>				
					      <c:otherwise>
					      	<button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/entradas/'">VOLTAR</button>
					      </c:otherwise>
					    </c:choose>						
						
						
						<button type="button" class="btn btn-success" onClick="print();">IMPRIMIR</button>
					</th>
				</tr>
			</tfoot>
		</table>
	</div>
	</center>

<br>

<jsp:include page="../../util/rodape.jsp" />

</body>
</html>
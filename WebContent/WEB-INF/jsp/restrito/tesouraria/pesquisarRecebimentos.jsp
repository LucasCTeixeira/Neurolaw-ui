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

<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

<body>

<script>
function pesquisar(form){
	location.href='${pageContext.servletConfig.servletContext.contextPath}/recebimentos/pesquisar?inicio='+form.inicio.value+'&termino='+form.termino.value+'&filial='+form.filial.value+'&produto='+form.produto.value;
} 
</script>

<div align="center">
	<h1>Pesquisar Recebimentos</h1>
	<form method="get" align="left" style="width: 70%" data-toggle="validator" role="form" name="formExemplo" id="formExemplo" 
		class="well form-horizontal">
  	<table width="100%">
  		<tr>
  			<td align="left"><b>Data Inicial</b></td>
  			<td align="left">
			  <div class="input-append date" id="dpInicial" data-date="" data-date-format="yyyy-mm-dd">
			    <c:choose>
				  <c:when test="${param.inicio ne Empty}">
					<input class="span2" id="inicio" name="inicio" size="16" type="text" readonly value="${param.inicio}">				  	
				  </c:when>
				  <c:otherwise>
  					<input class="span2" id="inicio" name="inicio" size="16" type="text" readonly value="${dataDiaInicial}">
				  </c:otherwise>
				</c:choose>
				<span class="add-on"><i class="icon-th"></i></span>
			  </div>	  			
  			</td>
  			<td align="left">&nbsp;</td>
  			<td align="left"><b>Data Final</b></td>
  			<td align="left">
			  <div class="input-append date" id="dpFinal" data-date="" data-date-format="yyyy-mm-dd">
			    <c:choose>
				  <c:when test="${param.termino ne Empty}">
					<input class="span2" id="termino" name="termino" size="16" type="text" readonly value="${param.termino}">				  	
				  </c:when>
				  <c:otherwise>
  					<input class="span2" id="termino" name="termino" size="16" type="text" readonly value="${dataDiaFinal}">
				  </c:otherwise>
				</c:choose>
				<span class="add-on"><i class="icon-th"></i></span>
			  </div>	  			
  			</td>
  		</tr>
  		<tr>
  			<td colspan="5" align="left">&nbsp;</td>
  		</tr>
  		<tr>
  			<td align="left"><b>Filial</b></td>
  			<td align="left">
		      	<select id="filial" name="filial">
	          <option selected value="0">Opcional</option>
	          <c:forEach items="${filiais}" var="filial">
		        <c:choose>
				  <c:when test="${param.filial eq filial.key}">
				  	<option selected value="${filial.key}">${filial.nome}</option>
				  </c:when>
				  <c:otherwise>
				  	<option value="${filial.key}">${filial.nome}</option>
				  </c:otherwise>
				</c:choose>	          	
	          </c:forEach>
    		</select>  			
  			</td>
  			<td align="left">&nbsp;</td>
  			<td align="left"><b>Produto</b></td>
  			<td align="left">
		      	<select id="produto" name="produto">
		      		<option selected value="0">Opcional</option>
 					<c:forEach items="${produtos}" var="produto">
 					  <c:choose>
					  <c:when test="${param.produto eq produto.key}">
					  	<option selected value="${produto.key}">${produto.descricao}</option>
					  </c:when>
					  <c:otherwise>
					  	<option value="${produto.key}">${produto.descricao}</option>
					  </c:otherwise>
					</c:choose>
		          </c:forEach>
	    		</select>
  			</td>
  		</tr>
  		<tr>
  			<td colspan="5" align="left">&nbsp;</td>
  		</tr>
  		<tr>
  			<td colspan="5" align="left">&nbsp;</td>
  		</tr>
  		<tr>
  			<td colspan="2" align="left">
			  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/recebimentos/'">VOLTAR</button>
  			</td>
  			<td colspan="3" align="right">
  				<button type="button" class="btn btn-info" onClick="pesquisar(this.form);">PESQUISAR</button>
  			</td>
  		</tr>  
	  </table>
	</form>
	
		<div id="grid" style="width: 90%" align="center">
		<table id="example" class="display" style="width: 100%" align="left">
			<thead align="left">
				<tr>
					<th>ID</th>
					<th>Data</th>
					<th>Descrição</th>
					<th>Filial</th>
					<th>Usuário</th>
					<th>Valor Declarado</th>
					<th>Valor Recebido</th>
					<th>Saida</th>
					<th>Saldo</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${registros}" var="registro">
					<tr>
						<td><c:out value="${registro.key}"></c:out></td>
						<td><fmt:formatDate pattern = "dd/MM/yyyy HH:mm" value = "${registro.createDate}" /></td>
						<td><c:out value="${registro.descricao}"></c:out></td>
						<td><c:out value="${registro.filial.nome}"></c:out></td>
						<td><c:out value="${registro.usuario.nome}"></c:out></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorRecebido}" minFractionDigits="2" maxFractionDigits="2"/></td>
						<td>
							<c:choose>
							  <c:when test="${registro.saida.key ne null}">
								<table class="display" style="width: 100%" align="left">
									<tr style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
										<th align="left">#</th>
										<th align="left">Produto</th>
										<th align="left">Quantidade</th>
										<th align="left">Valor</th>
										<th align="left">Subtotal</th>
									</tr>
									<c:forEach items="${registro.saida.itens}" var="item">
										<tr style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
											<td><c:out value="${item.indice}"/></td>
											<td><c:out value="${item.produto.descricao}"/></td>
											<td><fmt:formatNumber type="number" value="${item.quantidade}" minFractionDigits="2" maxFractionDigits="2"/></td>
											<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${item.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
											<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${item.quantidade*item.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
										</tr>
									</c:forEach>
								</table>
							  </c:when>
							  <c:otherwise>
							  	&nbsp;
							  </c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado-registro.valorRecebido}"/></td>
					</tr>
					<c:set var = "totalDeclarado" value = "${totalDeclarado + registro.valorDeclarado}"/>
					<c:set var = "totalRecebido" value = "${totalRecebido + registro.valorRecebido}"/>
				</c:forEach>
			</tbody>
			<tfoot align="left">
				<tr>
					<th colspan="5">Resumo do período:</th>
					<th>Total Declarado</th>
					<th>Total Recebido</th>
					<th>&nbsp;</th>
					<th>Total Saldo</th>
				</tr>
				<tr>
					<td colspan="5">&nbsp;</td>
					<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalDeclarado}" minFractionDigits="2" maxFractionDigits="2"/></td>
					<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalRecebido}" minFractionDigits="2" maxFractionDigits="2"/></td>
					<th>&nbsp;</th>
					<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalDeclarado-totalRecebido}" minFractionDigits="2" maxFractionDigits="2"/></td>
				</tr>
			</tfoot>
		</table>
	</div>
	<br><br>
	
</div>

	<script>
		$(function(){
			$("#example_filter").html("");

			//$('#example_length')attr('selectedIndex', 1);
			
			window.prettyPrint && prettyPrint();
			$('#dpInicial').datepicker().on('changeDate', function(ev){                 
			    $('#dpInicial').datepicker('hide');
			});			
			$('#dpFinal').datepicker().on('changeDate', function(ev){                 
			    $('#dpFinal').datepicker('hide');
			});			
		});
		
		function setarData(){
			$('#inicio').val(dataAtualFormatada());
			$('#termino').val(dataAtualFormatada());
		}
		
		function dataAtualFormatada(){
		    var data = new Date();
		    var dia = data.getDate();
		    if (dia.toString().length == 1)
		      dia = "0"+dia;
		    var mes = data.getMonth()+1;
		    if (mes.toString().length == 1)
		      mes = "0"+mes;
		    var ano = data.getFullYear();  
		    return ano+"-"+mes+"-"+dia;
		}
		
		function dataInicialFormatada(){
		    var data = new Date();
		    var dia = "01";
		    var mes = data.getMonth()+1;
		    if (mes.toString().length == 1)
		      mes = "0"+mes;
		    var ano = data.getFullYear();  
		    return ano+"-"+mes+"-"+dia;
		}	
		
		function dataFinalFormatada(){
		    var data = new Date();
		    var dia = new Date(data.getFullYear(), data.getMonth() + 1, 0).getDate();
		    if (dia.toString().length == 1)
			      dia = "0"+dia;
		    var mes = data.getMonth()+1;
		    if (mes.toString().length == 1)
		      mes = "0"+mes;
		    var ano = data.getFullYear();  
		    return ano+"-"+mes+"-"+dia;
		}		
	</script>

<jsp:include page="../../util/rodape.jsp" />

</body>

</html>
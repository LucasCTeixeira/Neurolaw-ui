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
	location.href='${pageContext.servletConfig.servletContext.contextPath}/fluxo-caixa/pesquisar?inicio='+form.inicio.value+'&termino='+form.termino.value+'&filial='+form.filial.value+'&fornecedor='+form.fornecedor.value+'&produto='+form.produto.value;
} 
</script>

<div align="center">
	<h1>Fluxo de Caixa</h1>
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
  			<td align="left"><b>Fornecedor</b></td>
  			<td align="left">
		      	<select id="fornecedor" name="fornecedor"">
		      	  <option selected value="0">Opcional</option>
 					<c:forEach items="${fornecedores}" var="fornecedor">
 					  <c:choose>
					  <c:when test="${param.fornecedor eq fornecedor.key}">
					  	<option selected value="${fornecedor.key}">${fornecedor.nome}</option>
					  </c:when>
					  <c:otherwise>
					  	<option value="${fornecedor.key}">${fornecedor.nome}</option>
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
  			<td colspan="3" align="left">&nbsp;</td>
  		</tr>
  		<tr>
  			<td colspan="5" align="left">&nbsp;</td>
  		</tr>
  		<tr>
  			<td colspan="2" align="left">
  			<!-- 
			  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/fluxo-caixa/'">VOLTAR</button>
			   -->
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
				<th>Tipo</th>
				<th>Data</th>
				<th>Filial</th>
				<th>Usuário</th>
				<th>Estoque</th>
				<th>Valor Declarado</th>
				<th>Valor Compensado</th>
				<th>Valor Pendente</th>
			</tr>
		</thead>
        <c:set var = "corLinha" value = "${'#000000'}"/>
		<tbody>
			<c:forEach items="${registros}" var="registro">
				<tr>
					<td><c:out value="${registro.key}"></c:out></td>
					<td><c:out value="${registro.tipo}"></c:out></td>
					<td><fmt:formatDate pattern = "dd/MM/yyyy HH:mm" value = "${registro.createDate}" /></td>
					<td><c:out value="${registro.filial.nome}"></c:out></td>
					<td><c:out value="${registro.usuario.nome}"></c:out></td>
					<td>
						<c:choose>
						  <c:when test="${registro.estoque.itens ne null}">
							  <table class="display" style="width: 100%" align="left">
								<tr style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
									<th align="left">#</th>
									<th align="left">Produto</th>
									<th align="left">Fornecedor</th>
									<th align="left">Qtd</th>
									<th align="left">Valor</th>
									<th align="left">Subtotal</th>
								</tr>
								<c:forEach items="${registro.estoque.itens}" var="item">
									<tr style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
										<td><c:out value="${item.indice}"/></td>
										<td><c:out value="${item.produto.descricao}"/></td>
										<td><c:out value="${item.fornecedor ne null ? item.fornecedor.nome : 'N/D'}"/></td>
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
					
						<c:set var = "corLancamento" value = "${'#000000'}"/>
						<c:choose>
						  <c:when test="${registro.tipo=='Recebimento'}">
						  	<c:set var = "corLancamento" value = "${'#3CB371'}"/>
						  </c:when>
						  <c:otherwise>
						  	<c:set var = "corLancamento" value = "${'#ff0000'}"/>
						  </c:otherwise>
						</c:choose>	
					
					<td><b><font color='${corLancamento}'><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado}"/></font></b></td>
					<td><b><font color='${corLancamento}'><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorCompensado}"/></font></b></td>

						<c:set var = "corLancamento" value = "${'#000000'}"/>
						<c:choose>
						  <c:when test="${registro.tipo=='Recebimento'}">
							<c:choose>
							  <c:when test="${(registro.valorDeclarado-registro.valorCompensado) > 0}">
							  	<c:set var = "corLancamento" value = "${'#3CB371'}"/>
							  </c:when>
							  <c:when test="${(registro.valorDeclarado-registro.valorCompensado) < 0}">
							  	<c:set var = "corLancamento" value = "${'#ff0000'}"/>
							  </c:when>
							  <c:otherwise>
							  </c:otherwise>
							</c:choose>	
						  </c:when>
						  <c:otherwise>
							<c:choose>
							  <c:when test="${(registro.valorDeclarado-registro.valorCompensado) > 0}">
							  	<c:set var = "corLancamento" value = "${'#ff0000'}"/>
							  </c:when>
							  <c:when test="${(registro.valorDeclarado-registro.valorCompensado) < 0}">
							  	<c:set var = "corLancamento" value = "${'#3CB371'}"/>
							  </c:when>
							  <c:otherwise>
							  </c:otherwise>
							</c:choose>
						  </c:otherwise>
						</c:choose>	
					<td><b><font color='${corLancamento}'><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorDeclarado-registro.valorCompensado}"/></font></b></td>
				</tr>
				
				<c:choose>
				  <c:when test="${registro.tipo == 'Recebimento'}">
				  	<c:set var = "qtdRecebimentos" value = "${qtdRecebimentos + 1}"/>
				  	<c:set var = "TotalRecebido" value = "${TotalRecebido + registro.valorCompensado}"/>
				  	<c:set var = "TotalAReceber" value = "${TotalAReceber + (registro.valorDeclarado-registro.valorCompensado)}"/>
				  	
				  	<c:set var = "saldoPrevisto" value = "${saldoPrevisto + registro.valorDeclarado}"/>
					<c:set var = "saldoFaturado" value = "${saldoFaturado + registro.valorCompensado}"/>
					<c:set var = "saldoAReceber" value = "${saldoAReceber + (registro.valorDeclarado-registro.valorCompensado)}"/>
				  </c:when>
				  <c:otherwise>
				  	<c:set var = "qtdPagamentos" value = "${qtdPagamentos + 1}"/>
				  	<c:set var = "TotalPago" value = "${TotalPago + registro.valorCompensado}"/>
				  	<c:set var = "TotalAPagar" value = "${TotalAPagar + (registro.valorDeclarado-registro.valorCompensado)}"/>

				  	<c:set var = "saldoPrevisto" value = "${saldoPrevisto - registro.valorDeclarado}"/>
					<c:set var = "saldoFaturado" value = "${saldoFaturado - registro.valorCompensado}"/>
					<c:set var = "saldoAReceber" value = "${saldoAReceber - (registro.valorDeclarado-registro.valorCompensado)}"/>
				  </c:otherwise>
				</c:choose>								

			</c:forEach>
	
			<!-- 
			<tr>
				<td colspan="5">
					&nbsp;
				</td>
				<td colspan="1">
					<b>Saldo Previsto</b>
				</td>
				<td colspan="1">
					<b>Saldo Faturado</b>
				</td>
				<td colspan="1">
					<b>Saldo à Receber</b>
				</td>
			</tr>

			<tr>
				<td colspan="5">
					&nbsp;
				</td>
				<td colspan="1">
					<fmt:formatNumber type="currency" currencySymbol="R$" value="${saldoPrevisto}"/>
				</td>
				<td colspan="1">
					<fmt:formatNumber type="currency" currencySymbol="R$" value="${saldoFaturado}"/>
				</td>
				<td colspan="1">
					<fmt:formatNumber type="currency" currencySymbol="R$" value="${saldoAReceber}"/>
				</td>
			</tr>
			 -->
		</tbody>
		<tfoot align="center">
		</tfoot>
	</table>
	</div>
	
	<br><br><br>
	
	<div align="center">
		<table class="display" style="width: 90%" align="center">
				<tr align="left" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<th colspan="8" align="center">
						Relatório Sintético
					</th>
				</tr>
				
				<tr colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<td colspan="8">
						<table width="100%">
							<tr>
								<td align="center"><b>&nbsp;</b></td>
								<td align="center"><b>A</b></td>
								<td align="center"><b>B</b></td>
								<td align="center"><b>&nbsp;</b></td>
								<td align="center"><b>C</b></td>
								<td align="center"><b>D</b></td>
								<td align="center"><b>(C - A)</b></td>
							</tr>				
							<tr>
								<td align="center"><b>Qtd de Pagamentos</b></td>
								<td align="center"><b>Total Pago</b></td>
								<td align="center"><b>Total à Pagar</b></td>
								<td align="center"><b>Qtd Recebimentos</b></td>
								<td align="center"><b>Total Recebido</b></td>
								<td align="center"><b>Total à Receber</b></td>
								<td align="center"><b>Lucro</b></td>
							</tr>
							
							<tr align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
								<td align="center"><fmt:formatNumber type="number" value="${qtdPagamentos}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${TotalPago}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${TotalAPagar}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="number" value="${qtdRecebimentos}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${TotalRecebido}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${TotalAReceber}" minFractionDigits="2" maxFractionDigits="2"/></td>
								
								<c:set var = "corLucro" value = "${'#000000'}"/>
								<c:choose>
								  <c:when test="${(TotalRecebido-TotalPago) gt 0}">
								  	<c:set var = "corLucro" value = "${'#3CB371'}"/>
								  </c:when>
								  <c:otherwise>
								  	<c:set var = "corLucro" value = "${'#ff0000'}"/>
								  </c:otherwise>
								</c:choose>	
							
								<td align="center"><b><font color='${corLucro}'><fmt:formatNumber type="currency" currencySymbol="R$" value="${TotalRecebido-TotalPago}" minFractionDigits="2" maxFractionDigits="2"/></font></b></td>
							</tr>
						</table>
					</td>
				</tr>
				
				
				<tr align="left" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<th colspan="8" align="center">
						Relatório Analítico de Filiais
					</th>
				</tr>
				
				<tr colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<td colspan="5">
						<table width="100%">
							<tr>
								<td align="center"><b>&nbsp;</b></td>
								<td align="center"><b>A</b></td>
								<td align="center"><b>B</b></td>
								<td align="center"><b>(A - B)</b></td>
								<td align="center"><b>C</b></td>
								<td align="center"><b>D</b></td>
								<td align="center"><b>(C - D)</b></td>
								<td align="center"><b>(D - B)</b></td>
							</tr>
							<tr>
								<td align="center"><b>Filial</b></td>
								<td align="center"><b>Previsto à Pagar</b></td>
								<td align="center"><b>Pago</b></td>
								<td align="center"><b>Pendente à Pagar</b></td>
								<td align="center"><b>Previsto à Receber</b></td>
								<td align="center"><b>Recebido</b></td>
								<td align="center"><b>Pendente à Receber</b></td>
								<td align="center"><b>Saldo</b></td>
							</tr>
							
							<c:forEach items="${analitico}" var="reg">								
								<tr align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
									<td align="center">${reg.filial}</td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalPagamentoDeclarado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalPagamentoCompensado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalPagamentoDeclarado-reg.totalPagamentoCompensado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalRecebimentoDeclarado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalRecebimentoCompensado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalRecebimentoDeclarado-reg.totalRecebimentoCompensado}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.totalRecebimentoCompensado-reg.totalPagamentoCompensado}" minFractionDigits="2" maxFractionDigits="2"/></td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>	
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
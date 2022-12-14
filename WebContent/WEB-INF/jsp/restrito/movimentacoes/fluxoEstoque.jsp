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
	location.href='${pageContext.servletConfig.servletContext.contextPath}/fluxo-estoque/pesquisar?inicio='+form.inicio.value+'&termino='+form.termino.value+'&filial='+form.filial.value+'&fornecedor='+form.fornecedor.value+'&produto='+form.produto.value;
} 
</script>

<div align="center">
	<h1>Fluxo de Estoque</h1>
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
			  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/fluxo-estoque/'">VOLTAR</button>
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
					<th>Itens</th>
					<th>Valor Total</th>
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
							<table class="display" style="width: 100%" align="left">
								<tr style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray">
									<th align="left">#</th>
									<th align="left">Produto</th>
									<th align="left">Fornecedor</th>
									<th align="left">Qtd</th>
									<th align="left">Valor</th>
									<th align="left">Subtotal</th>
								</tr>
								<c:forEach items="${registro.itens}" var="item">
								
									<c:choose>
									  <c:when test="${registro.tipo == 'Entrada'}">
									  	<c:set var = "totalQtdEntradas" value = "${totalQtdEntradas + (item.quantidade)}"/>
										<c:set var = "totalRsEntradas" value = "${totalRsEntradas + (item.quantidade*item.valor)}"/>
									  </c:when>
									  <c:otherwise>
									  	<c:set var = "totalQtdSaidas" value = "${totalQtdSaidas + (item.quantidade)}"/>
										<c:set var = "totalRsSaidas" value = "${totalRsSaidas + (item.quantidade*item.valor)}"/>
									  </c:otherwise>
									</c:choose>								
								
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
						</td>
						<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${registro.valorTotal}"/></td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot align="center">
			</tfoot>
		</table>
	</div>
	<br><br><br>
	<div align="center">
		<table class="display" style="width: 90%" align="center">
				<tr align="left" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<td colspan="5" align="center">
					<b>Relatório Sintético</b>
					</td>
				</tr>
				
				<tr align="left" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<td colspan="5">
						<table width="100%">
							<tr>
								<td align="center"><b>Produtos Entradados</b></td>
								<td align="center"><b>Produtos Vendidos</b></td>
								<td align="center"><b>&nbsp;</b></td>
								<td align="center"><b>Total em Saidas R$</b></td>
								<td align="center"><b>Total em Entradas R$</b></td>
								<td align="center"><b>Lucro R$ (Saida - Entrada)</b></td>
							</tr>
							
							<c:set var = "corEstoqueAtual" value = "${'#000000'}"/>
							<c:choose>
							  <c:when test="${(totalQtdEntradas-totalQtdSaidas) gt 0}">
							  	<c:set var = "corEstoqueAtual" value = "${'#3CB371	'}"/>
							  </c:when>
							  <c:when test="${(totalQtdEntradas-totalQtdSaidas) lt 0}">
							  	<c:set var = "corEstoqueAtual" value = "${'#ff0000'}"/>
							  </c:when>
							  <c:otherwise>
							  </c:otherwise>
							</c:choose>								

							<c:set var = "corLucro" value = "${'#000000'}"/>
							<c:choose>
							  <c:when test="${(totalRsSaidas-totalRsEntradas) gt 0}">
							  	<c:set var = "corLucro" value = "${'#3CB371	'}"/>
							  </c:when>
							  <c:when test="${(totalRsSaidas-totalRsEntradas) lt 0}">
							  	<c:set var = "corLucro" value = "${'#ff0000'}"/>
							  </c:when>
							  <c:otherwise>
							  </c:otherwise>
							</c:choose>								
							
							<tr align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
								<td align="center"><fmt:formatNumber type="number" value="${totalQtdEntradas}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="number" value="${totalQtdSaidas}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center">&nbsp;</td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalRsSaidas}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalRsEntradas}" minFractionDigits="2" maxFractionDigits="2"/></td>
								<td align="center"><b><font color='${corLucro}'><fmt:formatNumber type="currency" currencySymbol="R$" value="${totalRsSaidas-totalRsEntradas}" minFractionDigits="2" maxFractionDigits="2"/></font></b></td>					
							</tr>
						</table>
					</td>
				</tr>
		
				<tr>
					<td colspan="5">
						&nbsp;
					</td>
				</tr>
		
				<tr align="left" style="border-top-width: 1px; border-top-style: solid; border-top-color: gray; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<th colspan="5" align="center">
						Relatório Analítico de Produtos
					</th>
				</tr>
				
				<tr colspan="1" align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
					<td colspan="5">
						<table width="100%">
							<tr>
								<td align="center"><b>&nbsp;</b></td>
								<td align="center"><b>A</b></td>
								<td align="center"><b>B</b></td>
								<td align="center"><b>(B - A)</b></td>
								<td align="center"><b>C</b></td>
								<td align="center"><b>D</b></td>
								<td align="center"><b>(C - D)</b></td>
								<td align="center"><b>E</b></td>
								<td align="center"><b>F</b></td>
								<td align="center"><b>(F - E)</b></td>
							</tr>
							<tr>
								<td align="center"><b>Produto</b></td>
								<td align="center"><b>Média R$ Entrada</b></td>
								<td align="center"><b>Média R$ Saida</b></td>
								<td align="center"><b>Lucro Unitário</b></td>
								<td align="center"><b>Qtd em Entrada</b></td>
								<td align="center"><b>Qtd em Saida</b></td>
								<td align="center"><b>Estoque</b></td>
								<td align="center"><b>R$ em Entrada</b></td>
								<td align="center"><b>R$ em Saida</b></td>
								<td align="center"><b>Lucro Líquido</b></td>
							</tr>
							
							<c:forEach items="${analitico}" var="reg">								
								<tr align="left" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: gray" width="10%">
									<td align="center">${reg.produto}</td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${(reg.valorEntrada+reg.quantidadeEntrada) eq 0 ? 0 : reg.valorEntrada/reg.quantidadeEntrada}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${(reg.valorSaida+reg.quantidadeSaida) eq 0 ? 0 : reg.valorSaida/reg.quantidadeSaida}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<c:set var = "valorLucro" value = "${(reg.valorEntrada+reg.quantidadeEntrada) ne 0 and (reg.valorSaida+reg.quantidadeSaida) ne 0 ? (reg.valorSaida/reg.quantidadeSaida)-(reg.valorEntrada/reg.quantidadeEntrada) : 0}"/>
									<c:set var = "mediaLucro" value = "${(reg.valorEntrada+reg.quantidadeEntrada) ne 0 and (reg.valorSaida+reg.quantidadeSaida) ne 0 ? (((reg.valorSaida/reg.quantidadeSaida)*100)/(reg.valorEntrada/reg.quantidadeEntrada)/100)-1 : 0}"/>									
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${valorLucro}" minFractionDigits="2" maxFractionDigits="2"/> (<fmt:formatNumber type="number" value="${mediaLucro lt 0 ? mediaLucro*100 : mediaLucro*100}" minFractionDigits="2" maxFractionDigits="2"/>%)</td>
									<td align="center"><fmt:formatNumber type="number" value="${reg.quantidadeEntrada}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="number" value="${reg.quantidadeSaida}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="number" value="${reg.quantidadeEntrada-reg.quantidadeSaida}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.valorEntrada}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.valorSaida}" minFractionDigits="2" maxFractionDigits="2"/></td>
									<td align="center"><b><font color="${(reg.valorSaida-reg.valorEntrada) gt 0 ? '#3CB371' : (reg.valorSaida-reg.valorEntrada) lt 0 ? '#ff0000' : '#000000'}"><fmt:formatNumber type="currency" currencySymbol="R$" value="${reg.valorSaida-reg.valorEntrada}" minFractionDigits="2" maxFractionDigits="2"/></font></b></td>					
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>	
	</div>
	<br><br><br>
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
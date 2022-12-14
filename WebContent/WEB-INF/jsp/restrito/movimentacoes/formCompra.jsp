<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

<c:set var = "comboFornecedor" scope = "session" value = ""/>
<c:forEach items="${fornecedores}" var="fornecedor">
	<c:set var = "linha" scope = "session" value = "<option value='${fornecedor.key}'>${fornecedor.nome}</option>"/>
	<c:set var = "comboFornecedor" scope = "session" value = "${comboFornecedor}${linha}"/>	
</c:forEach>

<body>

<style>
input[type=text] {
    padding:5px; 
    border:2px solid #ccc; 
    -webkit-border-radius: 5px;
    border-radius: 5px;
    width: 100px;
}
</style>

<script>
	function adicionarProduto() {
		$("#modalAdicionarProduto").modal({
			keyboard : false
		});
		$("#example_length").html("");
	}
	
	function validarCamposDosItens(index){
		var ok = true;
		var for_cd = $('#fornecedor'+index).val();
		if (for_cd==0){
			ok = false;
			$("#campoFocus").val('fornecedor'+index);
			$("#modalMsgDetalhe").html("Campo fornecedor deve ser informado!");
			$("#modalAlerta").modal({
				keyboard : false
			});
		}
		var valor = $('#valor'+index).val();
		if (valor.length==0 || parseFloat(valor)==0){
			ok = false;
			$("#campoFocus").val('valor'+index);
			$("#modalMsgDetalhe").html("Campo valor deve ser informado!");
			$("#modalAlerta").modal({
				keyboard : false
			});			
		}
		var qtd = $('#quantidade'+index).val();
		if (qtd.length==0 || parseInt(qtd)==0){
			ok = false;
			$("#campoFocus").val('quantidade'+index);
			$("#modalMsgDetalhe").html("Campo quantidade deve ser informado!");
			$("#modalAlerta").modal({
				keyboard : false
			});			
		}
		return ok;
	}
	
	function atualizarProduto(index, idProduto, idFornecedor){
		var ok = validarCamposDosItens(index);
		if (ok){
			var valor = $('#valor'+index).val();
			var qtd = $('#quantidade'+index).val();
			location.href="${pageContext.servletConfig.servletContext.contextPath}/compras/atualizar-item/" + index + "/"+idProduto+"/"+idFornecedor+"/"+parseInt(valor.replace('.','').replace(',','.'))+"/"+qtd.replace('.','');
		}
	}
	
	function adicionarNovoItem(idProduto){
		$("#fecharModal").click();
		location.href='${pageContext.servletConfig.servletContext.contextPath}/compras/adicionar-item/'+idProduto;		
	}
	
	function validarForm(form){
		if (form.filial.value==0){
			$("#campoFocus").val('filial');
			$("#modalMsgDetalhe").html("Campo filial deve ser informado!");
			$("#modalAlerta").modal({
				keyboard : false
			});
			return false;
		}
		var ok = true;
		
		for(i=0;i<parseInt($("#qtdLinhas").val());i++){
			ok = validarCamposDosItens((i+1));
			if (ok==false){
				return false;
			}
		}	
		
		form.action='${pageContext.servletConfig.servletContext.contextPath}/compras/${opAcao}';
		return true;		
	}
	
	function atualizarFilial(combo){
		if (combo.value==0){
			$("#campoFocus").val('filial');
			$("#modalMsgDetalhe").html("Campo filial deve ser informado!");
			$("#modalAlerta").modal({
				keyboard : false
			});			
		}else{
			location.href='${pageContext.servletConfig.servletContext.contextPath}/compras/atualizar-filial/'+combo.value;
		}
	}
	
</script>

<div align="center">
	<h1>Entrada em Estoque (Compra)</h1>

	<form method="post" onsubmit="return validarForm(this);" align="left" style="width: 70%" data-toggle="validator" role="form" name="formExemplo" id="formExemplo" 
		class="well form-horizontal">
	  <div class="form-row">
	    <div class="form-group">
	      	<label for="filial"><b>Filial</b></label>
	      	<select id="filial" name="filial" required onchange="atualizarFilial(this);">
	          <option selected value="0">Selecione uma Filial</option>
	          <c:forEach items="${filiais}" var="filial">
		        <c:choose>
				  <c:when test="${filial.key eq compra.filial.key}">
				  	<option selected value="${filial.key}">${filial.nome}</option>
				  </c:when>
				  <c:otherwise>
				  	<option value="${filial.key}">${filial.nome}</option>
				  </c:otherwise>
				</c:choose>	          	
	          </c:forEach>
	    	</select>
	    	<div class="help-block with-errors"></div>
	    </div>
	  </div>
	  <div class="form-row">
	    <div class="form-group">
	      <b>Itens</b>
	    </div>
	  </div>
	  
	  <div class="form-row">
	    <div class="form-group">
	    
			<table class="table">
			  <thead class="thead-dark">
			    <tr>
			      <th scope="col">#</th>
			      <th scope="col">Produto</th>
			      <th scope="col">Fornecedor</th>
			      <th scope="col">Valor</th>
			      <th scope="col">Quantidade</th>
			      <th scope="col">Subtotal</th>
			      <th scope="col">&nbsp;</th>
			    </tr>
			  </thead>
			  
			  <c:set var = "total" scope = "session" value = "0"/>
			  <c:set var = "qtdLinhas" scope = "session" value = "0"/>
			  <tbody id="tBodyItens">
			  	<c:forEach items="${compra.itens}" var="item">
				    <tr>
				      <td>${item.indice}</td>
				      <td>${item.produto.descricao}</td>
				      <td>
				      	<select id="fornecedor${item.indice}" name="fornecedor${item.indice}" onchange="$('#itemRefresh${item.indice}').click();">
				      		<option selected value="0">Selecione</option>
   					      <c:forEach items="${fornecedores}" var="fornecedor">
   					        <c:choose>
							  <c:when test="${item.fornecedor.key eq fornecedor.key}">
							  	<option selected value="${fornecedor.key}">${fornecedor.nome}</option>
							  </c:when>
							  <c:otherwise>
							  	<option value="${fornecedor.key}">${fornecedor.nome}</option>
							  </c:otherwise>
							</c:choose>
   					      	
					      </c:forEach>				      	
				      	</select>
				      </td>
				      <td><input type="text" onchange="$('#itemRefresh${item.indice}').click();" id="valor${item.indice}" name="valor${item.indice}" value="<fmt:formatNumber value="${item.valor}" minFractionDigits="2" maxFractionDigits="2"/>"></td>
				      <td><input type="text" onchange="$('#itemRefresh${item.indice}').click();" id="quantidade${item.indice}" name="quantidade${item.indice}" value="<fmt:formatNumber value="${item.quantidade}" minFractionDigits="0" maxFractionDigits="0"/>"></td>
				      <td><input type="text" readonly id="subtotal${item.indice}" name="subtotal${item.indice}" value="<fmt:formatNumber type="currency" currencySymbol="R$" value="${item.quantidade*item.valor}"/>" minFractionDigits="2" maxFractionDigits="2"></td>
				      <td>
				      	<img id="itemRefresh${item.indice}" style="cursor: pointer" onclick="atualizarProduto(${item.indice}, ${item.produto.key}, $('#fornecedor${item.indice}').val());" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/refresh.png">
				      	&nbsp;&nbsp;&nbsp;<img style="cursor: pointer" onclick="javascript:confirmarExclusao(<c:out value="${item.indice}"></c:out>, '<c:out value="${item.indice}"></c:out>', '${pageContext.servletConfig.servletContext.contextPath}/compras/remover-item/${item.indice}');" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png">
				      </td>
				    </tr>
				    <c:set var = "total" scope = "session" value = "${total + (item.quantidade*item.valor)}"/>
				    <c:set var = "qtdLinhas" scope = "session" value = "${item.indice}"/>
				    <script>
				  		//$('#valor${item.indice}').trim();
				    	$('#valor${item.indice}').mask("#.##0,00" , { reverse:true});
				    	$('#quantidade${item.indice}').mask("00000");
				    </script>
				</c:forEach>
			  </tbody>
			  <input type="hidden" id="qtdLinhas" name="qtdLinhas" value="${qtdLinhas}">
			</table>
			<div align="center">
				<button type="button" class="btn btn-warning" onClick="adicionarProduto();">Adicionar Item</button>
			</div>
	    </div>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6" align="right">
	      <label for="total"><b>Total</b></label>
	      <input type="text" readonly class="form-control" name="total" id="total" tabindex="4" value="<fmt:formatNumber type="currency" currencySymbol="R$" value="${total}" minFractionDigits="2" maxFractionDigits="2"/>">
	      <div class="help-block with-errors"></div>
	    </div>
	  </div>
	  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/compras/'">VOLTAR</button>
	  	  <c:choose>
	      <c:when test="${opAcao == 'confirmar-edicao'}">
	      	<button type="submit" class="btn btn-primary">ALTERAR</button>
	      </c:when>				
	      <c:otherwise>
	      	<button type="submit" class="btn btn-primary">CADASTRAR</button>
	      </c:otherwise>
	  </c:choose>
</form>
</div>

<div class="modal hide" id="modalAdicionarProduto">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">x</a>
		<h3>Adicionar Produto</h3>
	</div>
	<div class="modal-body">
		

		<center>
		<div id="grid" style="width: 90%" align="center">
			<table id="example" class="display" style="width: 100%" align="left">
				<thead align="left">
					<tr>
						<th>ID</th>
						<th>Descrição</th>
						<th>R$</th>
						<th>Ação</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${produtos}" var="produto">
						<tr id="linha${produto.key}">
							<td><c:out value="${produto.key}"></c:out></td>
							<td><c:out value="${produto.descricao}"></c:out><div style="display: none;"><c:out value="${produto.codigoBarras}"></c:out></div></td>
							<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${produto.precoSugerido}"/></td>
							<td>
								<img style="cursor: pointer" onclick="adicionarNovoItem(${produto.key});" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/add.png">
							</td>							
						</tr>
					</c:forEach>
				</tbody>
				<tfoot align="left">
					<tr>
						<th>ID</th>
						<th>Filial</th>
						<th>R$</th>
						<th>Ação</th>
					</tr>
				</tfoot>
			</table>
		</div>
		</center>
		
		
		
		
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" id="fecharModal" data-dismiss="modal">Fechar</a>
	</div>
</div>

<script>
function focarCampo(){
	var campo = $("#campoFocus").val();
	$("#"+campo).focus();
}
</script>

<div class="modal hide" id="modalAlerta">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">x</a>
		<h3>Atenção</h3>
	</div>
	<div class="modal-body">
		<div id="modalMsgDetalhe"></div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal" onclick="focarCampo();">Fechar</a>
	</div>
	<input type="hidden" id="campoFocus" value="">
</div>


</body>

</html>
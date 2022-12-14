<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

<c:set var = "comboFornecedor" scope = "session" value = ""/>
<c:forEach items="${fornecedores}" var="fornecedor">
	<c:set var = "linha" scope = "session" value = "<option value='${fornecedor.key}'>${fornecedor.nome}</option>"/>
	<c:set var = "comboFornecedor" scope = "session" value = "${comboFornecedor}${linha}"/>	
</c:forEach>

<script>
function calcularSubTotal(idLinha){
	var qtdItem = $("#qtdItem"+idLinha);
	var subItem = $("#subItem"+idLinha);
	var valItem = $("#valItem"+idLinha).val().replace('R$ ','').replace('.','').replace(',','.');
	subItem.html("R$ " + (parseFloat(valItem)*parseInt(qtdItem.val())).toFixed(2).replace('.',','));
	calcularTotal();
}

function calcularTotal(){
	var totalH = $("#totalItens");
	var total = 0;
	for(i=0;i<totalH.val();i++){
		alert($("#subItem"+(i)).html());
		var sub = $("#subItem"+(i)).html().replace('R$ ','').replace('.','').replace(',','.');
		total = total + parseFloat(sub);
	}
	$("#total").val("R$ " + total.toFixed(2).replace('.',','));	
}

function adicionarProduto() {
	$("#modalAdicionarProduto").modal({
		keyboard : false
	});
	$("#example_length").html("");
}

function adicionarProdutoNaLista(id, descricao, valor){
	var tBody = $("#tBodyItens");
	var totalH = $("#totalItens");
	var linhaNova = "<tr id='lgrid"+totalH.val()+"'><td>" + (parseInt(totalH.val())+1)  + "</td><td>" + descricao + "</td><td>" + getFornecedorSelect(totalH.val()) + "</td><td><input type='text' id='valItem"+totalH.val()+"' name='valItem"+totalH.val()+"' onfocusout='calcularSubTotal(" + totalH.val() + ");' value='" + "R$ " + parseInt(valor).toFixed(2).replace('.',',') + "'></td><td>" + getQuantidadeSelect(totalH.val()) + "</td><td id='subItem"+totalH.val()+"'>R$ 0,00</td><td><img style='cursor: pointer' onclick='javascript:removerItem("+totalH.val()+");' src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png'></td></tr>";
    $(linhaNova).appendTo(tBody);
	$("#valItem"+totalH.val()).mask("#.##0,00", {reverse: true});
	totalH.val((parseInt(totalH.val()) + 1));
	//$("#linha"+id).remove();
}

function removerItem(id){
	$("#lgrid"+id).remove();
	var totalH = $("#totalItens");
	totalH.val((parseInt(totalH.val()) - 1));
	alert(totalH.val());
	calcularTotal();
}

function getQuantidadeSelect(idLinha){
	var html = "<select required id='qtdItem"+idLinha+"' name='qtdItem"+idLinha+"' class='form-control input-sm' onchange='if (this.selectedIndex) calcularSubTotal(" + idLinha + ");'>";
	var html = html + "<option selected value='0'>Selecione</option>";
	for(i=0;i<99;i++){
		var html = html + "<option value='" + (i+1) + "'>" + (i+1) + "</option>";
	}
	var html = html + "</select>";
	return html;
}

function getFornecedorSelect(idLinha){
	var html = "<select required name='fornecedor"+idLinha+"' class='form-control input-sm'>";
	var html = html + "<option selected value='0'>Selecione</option>";
	var html = html + "${comboFornecedor}";
	var html = html + "</select>";
	return html;
}

</script>

<body>

<div align="center">
	<form method="post" align="left" style="width: 70%" data-toggle="validator" role="form" name="formExemplo" id="formExemplo" 
		class="well form-horizontal" action="${pageContext.servletConfig.servletContext.contextPath}/compras/<c:out value="${opAcao}"></c:out>">
	  <c:choose>
	      <c:when test="${opAcao == 'confirmar-edicao'}">
	      	<input type="hidden" name="compra.key" value="<c:out value="${compraTemp.key}"></c:out>">
	      </c:when>				
	      <c:otherwise>
	      </c:otherwise>
	  </c:choose>
	  <div class="form-row">
	    <div class="form-group">
	      	<label for="filial"><b>Filial</b></label>
	      	<select id="combobox" required>
	          <option selected value="0">Selecione uma Filial</option>
	          <c:forEach items="${filiais}" var="filial">
	          	<option value="${filial.key}">${filial.nome}</option>
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
			  
			  <tbody id="tBodyItens">
			  <!-- 
			    <tr>
			      <td scope="row">1</td>
			      <td  scope="row">Produto #1</td>
			      <td>Fornecedor #1</td>
			      <td>
			      	R$ 10,00
			      	<input type="hidden" id="valh1" value="10.00">			      	
			      </td>
			      <td>
			      	<select id="combobox" id="qtd1" required class="form-control input-sm" onchange="if (this.selectedIndex) calcularSubTotal(1, this.selectedIndex);">
			          <option selected value="0">Selecione</option>
			          <option value="1">01</option>
			          <option value="2">02</option>
			          <option value="3">03</option>
			    	</select>
			      </td>
			      <td><div id="sub1">R$ 10,00</div></td>
			      <td><img style="cursor: pointer" onclick="javascript:removerItem();" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png"></td>
			    </tr>
			     -->
			  </tbody>
			  
			</table>
			<div align="center">
				<button type="button" class="btn btn-warning" onClick="adicionarProduto();">Adicionar Item</button>
			</div>
			<input type="hidden" id="totalItens" value="0">
	    </div>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6" align="right">
	      <label for="total"><b>Total</b></label>
	      <input type="text" readonly class="form-control" name="total" id="total" tabindex="4" value="R$ 00,00">
	      <div class="help-block with-errors"></div>
	    </div>
	  </div>
	  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/compras/'">VOLTAR</button>
   	  <button type="submit" class="btn btn-primary">CADASTRAR</button>
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
							<td><c:out value="${produto.descricao}"></c:out></td>
							<td><fmt:formatNumber type="currency" currencySymbol="R$" value="${produto.precoSugerido}"/></td>
							<td>
								<img style="cursor: pointer" onclick="adicionarProdutoNaLista(${produto.key}, '${produto.descricao}', '${produto.precoSugerido}');" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/edit.png">
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
		<a href="#" class="btn" data-dismiss="modal">Fechar</a>
	</div>
</div>

</body>

</html>
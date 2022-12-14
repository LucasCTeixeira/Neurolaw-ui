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
function focarCampo(){
	var campo = $("#campoFocus").val();
	$("#"+campo).focus();
}

function validar(form){
	var ok = true;
	if ($("#descricao").val()==''){
		$("#campoFocus").val('descricao');
		$("#modalMsgDetalhe").html("Campo descrição deve ser informado!");
		$("#modalAlerta").modal({
			keyboard : false
		});
		ok = false;
	}
	if ($("#filial").val()=='0'){
		$("#campoFocus").val('filial');
		$("#modalMsgDetalhe").html("Campo Filial deve ser informado!");
		$("#modalAlerta").modal({
			keyboard : false
		});
		ok = false;
	}	
	if ($("#valorDeclarado").val()==''){
		$("#campoFocus").val('valorDeclarado');
		$("#modalMsgDetalhe").html("Campo Valor Declarado deve ser informado!");
		$("#modalAlerta").modal({
			keyboard : false
		});
		ok = false;
	}
	if ($("#valorRecebido").val()==''){
		$("#campoFocus").val('valorRecebido');
		$("#modalMsgDetalhe").html("Campo Valor Recebido deve ser informado!");
		$("#modalAlerta").modal({
			keyboard : false
		});
		ok = false;
	}
	var preco = $("#valorDeclarado").val().replace('.','').replace(',','.');
	$("#valorDeclarado").val(preco)
	preco = $("#valorRecebido").val().replace('.','').replace(',','.');
	$("#valorRecebido").val(preco)
	return ok;
}

</script>

<div align="center">
	
    <div class="page-header">
	  <c:choose>
	      <c:when test="${opAcao == 'confirmar-edicao'}">
	      	<h1><b>Editar Recebimento</b></h1>
	      </c:when>				
	      <c:otherwise>
	      	<h1><b>Novo Recebimento</b></h1>
	      </c:otherwise>
	  </c:choose>
    </div>
	<form method="post" onsubmit="return validar(this);" align="left" style="width: 70%" data-toggle="validator" role="form" name="formExemplo" id="formExemplo" 
		class="well form-horizontal" action="${pageContext.servletConfig.servletContext.contextPath}/recebimentos/<c:out value="${opAcao}"></c:out>">
	  <c:choose>
	      <c:when test="${opAcao == 'confirmar-edicao'}">
	      	<input type="hidden" name="recebimento.key" value="<c:out value="${recebimentoTemp.key}"></c:out>">
	      </c:when>				
	      <c:otherwise>
	      </c:otherwise>
	  </c:choose>
	  <div class="form-row">
	    <div class="form-group col-md-6">
	      <label for="descricao"><b>Descrição</b></label>
	      <input type="text" class="form-control" name="recebimento.descricao" id="descricao" placeholder="Descricao" required  maxlength="60" value="<c:out value="${recebimentoTemp.descricao}"></c:out>" tabindex="2">
	      <div class="help-block with-errors"></div>
	    </div>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6">
	    	<label for="dpVencimento"><b>Data de Vencimento</b></label>
			  <div class="input-append date" id="dpVencimento" data-date="" data-date-format="yyyy-mm-dd">
				<input class="span2" id="dataVencimento" name="recebimento.dataVencimento" size="16" type="text" readonly value="${dataVencimento}">				  	
				<span class="add-on"><i class="icon-th"></i></span>
			  </div>	  			
	    </div>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6">
	    	<label for="dpRecebimento"><b>Data e Hora de Recebimento</b></label>
			<div class="input-append date form_datetime">
			    <input size="16" type="text" id="dpRecebimento" value="${dataRecebimento}" readonly name="recebimento.dataRecebimento">
			    <span class="add-on"><i class="icon-th"></i></span>
			</div>
			<button type="button" class="btn btn-secondary" onClick="$('#dpRecebimento').val('');$('#valorRecebido').val('0,00');">Deixar vazio</button>
	    </div>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6">
	      	<label for="filial"><b>Filial</b></label>
	      	<select id="filial" name="recebimento.filial.key" required>
	          <option selected value="0">Selecione uma Filial</option>
	          <c:forEach items="${filiais}" var="filial">
		        <c:choose>
				  <c:when test="${filial.key eq recebimentoTemp.filial.key}">
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
	    <div class="form-group col-md-6">
	      	<label for="valorDeclarado"><b>Valor Declarado</b></label>	  
	  			<input type="text" id="valorDeclarado" name="recebimento.valorDeclarado" value="<fmt:formatNumber value="${recebimentoTemp.valorDeclarado}" minFractionDigits="2" maxFractionDigits="2"/>">
	  	</input>
	  </div>

	  <div class="form-row">
	    <div class="form-group col-md-6">
	      	<label for="valorRecebido"><b>Valor Recebido</b></label>	  
	  			<input type="text" id="valorRecebido" name="recebimento.valorRecebido" value="<fmt:formatNumber value="${recebimentoTemp.valorRecebido}" minFractionDigits="2" maxFractionDigits="2"/>">
	  			<button type="button" class="btn btn-secondary" onClick="$('#valorRecebido').val($('#valorDeclarado').val());$('#dpRecebimento').val('${dataAtual}');">Receber o total declarado</button>
	  	</input>
	  </div>
	  
	  <button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/recebimentos/'">VOLTAR</button>
	  <c:choose>
	      <c:when test="${opAcao == 'confirmar-adicao'}">
	      	<button type="submit" class="btn btn-primary">CADASTRAR</button>
	      </c:when>				
	      <c:otherwise>
	      	<button type="submit" class="btn btn-primary">ALTERAR</button>
	      </c:otherwise>
	  </c:choose>
</form>
</div>

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

	<script>
		$('#valorDeclarado').mask("#.##0,00" , { reverse:true});
		$('#valorRecebido').mask("#.##0,00" , { reverse:true});
		
	    $(".form_datetime").datetimepicker({
	        format: "yyyy-mm-dd hh:ii"
	    });
		$(function(){
			window.prettyPrint && prettyPrint();
			$('#dpVencimento').datepicker().on('changeDate', function(ev){                 
			    $('#dpVencimento').datepicker('hide');
			});			
		});
	</script>

<jsp:include page="../../util/rodape.jsp" />

</body>

</html>
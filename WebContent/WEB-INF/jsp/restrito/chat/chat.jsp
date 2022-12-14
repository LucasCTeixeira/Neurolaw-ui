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

<style>
/*
*
* ==========================================
* FOR DEMO PURPOSES
* ==========================================
*
*/
::-webkit-scrollbar {
  width: 5px;
}

::-webkit-scrollbar-track {
  width: 5px;
  background: #f5f5f5;
}

::-webkit-scrollbar-thumb {
  width: 1em;
  background-color: #ddd;
  outline: 1px solid slategrey;
  border-radius: 1rem;
}

.text-small {
  font-size: 0.9rem;
}

.messages-box,
.chat-box {
  height: 510px;
  overflow-y: scroll;
}

.rounded-lg {
  border-radius: 0.5rem;
}

input::placeholder {
  font-size: 0.9rem;
  color: #999;
}
</style>

</head>

<script>
function enviarMensagem(form){
	if (form.mensagem.value!=""){
		$.ajax({
			  type: "POST",
			  url: "${pageContext.servletConfig.servletContext.contextPath}/chat/",
			  data: {'mensagem.texto': form.mensagem.value,'mensagem.perfilChat.key': '${perfilKey}'},
			  success: function(msg){
				  form.mensagem.value="";
				  exibirToast('success', 2000, 'Mensagem enviada com sucesso.');
				  getMensagens();
			  },
			  error: function(XMLHttpRequest, textStatus, errorThrown) {
				  exibirToast('error', 3000, 'Falha ao enviar a mensagem. [' + errorThrown + ']');
			  }
			});
	}else{
		exibirToast('warning', 2000, 'Informe uma mensagem');
	}
}


function configEnvios(){
	$("#formEnviarMensagem").submit(function(e) {
	    document.getElementById("btEnviarMensagem").click();
	    e.preventDefault();
	});	
}

</script>

<c:choose>
	<c:when test="${perfilKey ne null}">
		<script>
		function checkAtividade(){
			setTimeout(function () {
				getPerfis();
				getMensagens();
				checkAtividade();
		    }, 5000);
			location.href = "#btEncerrarConversa";
			document.getElementById("txtMensagem").focus();
		}
		
		function getMensagens(){
			  $.get("${pageContext.servletConfig.servletContext.contextPath}/chat/mensagens/${perfilKey}", function(data, status){
				  $("#mensagens").html('');
				  var remetente = data[0].perfilChat.remetente; 
				  $.each(data,function(index, msg){
					if (msg.recebida){
				    	$("#mensagens").html($("#mensagens").html() + "<div class='media w-50 ml-auto mb-3'><div class='media-body'><div class='bg-primary rounded py-2 px-3 mb-2'><p class='text-small mb-0 text-white'><b>Secretaria da Mulher:</b>&nbsp;" + msg.texto + "</p></div><p class='small text-muted'>" + msg.dataEnvio.replace("T"," ") + "</p></div><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/support.png' alt='user' width='50' class='rounded-circle'></div>");
					}else{
						$("#mensagens").html($("#mensagens").html() + "<div class='media w-50 mb-3'><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/" + msg.perfilChat.avatar + ".png' alt='user' width='50' class='rounded-circle'><div class='media-body ml-3'><div class='bg-light rounded py-2 px-3 mb-2'><p class='text-small mb-0 text-muted'><b>" + msg.perfilChat.remetente + " :</b>&nbsp;" + msg.texto + "</p></div><p class='small text-muted'>" + msg.dataEnvio.replace("T"," ") + "</p></div></div>");
					}
				  });
				  var v = "<center><button id='btEncerrarConversa' onclick=\"confirmarExclusao('${perfilKey}','Toda a conversa com " + remetente + "','${pageContext.servletConfig.servletContext.contextPath}/chat/remover/${perfilKey}');\" class='btn btn-danger'><i class='fas fa-times-circle'></i> Encerrar a conversa</button></center>";
				  $("#mensagens").html($("#mensagens").html() + v);
			  });
			  
			  
		}
		
		function getPerfis(){
			  $.get("${pageContext.servletConfig.servletContext.contextPath}/chat/perfis/", function(data, status){
				  $("#perfis").html('');
				  $.each(data,function(index, perfil){
					if (perfil.key==${perfilKey}){						
						$("#perfis").html($("#perfis").html() + "<a href='${pageContext.servletConfig.servletContext.contextPath}/chat/" + perfil.key + "' class='list-group-item list-group-item-action active  list-group-item-light rounded-0'><div class='media'><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/" + perfil.avatar + ".png' alt='user' width='50' class='rounded-circle'><div class='media-body ml-4'><div class='d-flex align-items-center justify-content-between mb-1'><h6 class='mb-0'>" + perfil.remetente + "&nbsp;</h6><small class='small font-weight-bold'>" + perfil.dataUltimaMensagemStr + "</small></div><p class='font-italic text-muted mb-0 text-small'>Total de mensagens: " + perfil.qtdMensagens + " </p></div></div></a>");
					}else{
						$("#perfis").html($("#perfis").html() + "<a href='${pageContext.servletConfig.servletContext.contextPath}/chat/" + perfil.key + "' class='list-group-item list-group-item-action list-group-item-light rounded-0'><div class='media'><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/" + perfil.avatar + ".png' alt='user' width='50' class='rounded-circle'><div class='media-body ml-4'><div class='d-flex align-items-center justify-content-between mb-1'><h6 class='mb-0'>" + perfil.remetente + "&nbsp;</h6><small class='small font-weight-bold'>" + perfil.dataUltimaMensagemStr + "</small></div><p class='font-italic text-muted mb-0 text-small'>Total de mensagens: " + perfil.qtdMensagens + " </p></div></div></a>");
					}
				  });
			  });
		}
		</script>
		<body class="hold-transition sidebar-mini layout-fixed" onload="getPerfis();getMensagens();checkAtividade();configEnvios();">	
	</c:when>	
	<c:otherwise>
		<script>
		function checkAtividade(){
			setTimeout(function () {
				getPerfis();
				checkAtividade();
		    }, 5000);
		}
		
		function getPerfis(){
			  $.get("${pageContext.servletConfig.servletContext.contextPath}/chat/perfis/", function(data, status){
				  $("#perfis").html('');
				  $.each(data,function(index, perfil){
					if (perfil.key=='${perfilKey}'){
						$("#perfis").html($("#perfis").html() + "<a href='${pageContext.servletConfig.servletContext.contextPath}/chat/" + perfil.key + "' class='list-group-item list-group-item-action active  list-group-item-light rounded-0'><div class='media'><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/" + perfil.avatar + ".png' alt='user' width='50' class='rounded-circle'><div class='media-body ml-4'><div class='d-flex align-items-center justify-content-between mb-1'><h6 class='mb-0'>" + perfil.remetente + "&nbsp;</h6><small class='small font-weight-bold'>" + perfil.dataUltimaMensagemStr + "</small></div><p class='font-italic text-muted mb-0 text-small'>Total de mensagens: " + perfil.qtdMensagens + " </p></div></div></a>");
					}else{
						$("#perfis").html($("#perfis").html() + "<a href='${pageContext.servletConfig.servletContext.contextPath}/chat/" + perfil.key + "' class='list-group-item list-group-item-action list-group-item-light rounded-0'><div class='media'><img src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/" + perfil.avatar + ".png' alt='user' width='50' class='rounded-circle'><div class='media-body ml-4'><div class='d-flex align-items-center justify-content-between mb-1'><h6 class='mb-0'>" + perfil.remetente + "&nbsp;</h6><small class='small font-weight-bold'>" + perfil.dataUltimaMensagemStr + "</small></div><p class='font-italic text-muted mb-0 text-small'>Total de mensagens: " + perfil.qtdMensagens + " </p></div></div></a>");
					}
				  });
			  });
		}
		</script>
		<body class="hold-transition sidebar-mini layout-fixed" onload="getPerfis();checkAtividade();">
	</c:otherwise>
</c:choose>


<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

<div class="wrapper">
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

<div class="container py-5 px-4">
  <!-- For demo purpose-->

  <div class="row rounded-lg overflow-hidden shadow">
    <!-- Users box-->
    <div class="col-5 px-0">
      <div class="bg-white">

        <div class="bg-gray px-4 py-2 bg-light">
          <p class="h5 mb-0 py-1">Mensagens</p>
        </div>

        <div class="messages-box">
          <div class="list-group rounded-0" id="perfis">
          </div>
        </div>
      </div>
    </div>
    <!-- Chat Box-->
    <div class="col-7 px-0">
      <div class="px-4 py-5 chat-box bg-white">
       	<div id="mensagens"></div>
      </div>

      <!-- Typing area -->
      <form class="bg-light" id="formEnviarMensagem">
        <div class="input-group">
          <input name="mensagem" id="txtMensagem" type="text" placeholder="Digite sua mensagem" aria-describedby="btEnviarMensagem" class="form-control rounded-0 border-0 py-4 bg-light">
          <div class="input-group-append">
            <button id="btEnviarMensagem" type="button" onclick="enviarMensagem(this.form);" class="btn btn-link"> <i class="fa fa-paper-plane"></i></button>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

	</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- ./wrapper -->

	<jsp:include page="../../util/rodape.jsp" />
	<jsp:include page="../util/paginaComGrid.jsp" />

</body>
</html>
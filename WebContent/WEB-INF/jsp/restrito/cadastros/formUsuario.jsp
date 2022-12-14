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

<body class="hold-transition sidebar-mini layout-fixed">
<jsp:include page="../util/paginaRestrita.jsp" />
<jsp:include page="../util/paginaComGrid.jsp" />

<script>
	function ignorarSenha(checkbox){
		if (checkbox.checked){
			$('#senha').val('');
			document.getElementById("senha").disabled = true;
			$('#confirmarSenha').val('');
			document.getElementById("confirmarSenha").disabled = true;
		}else{
			document.getElementById("senha").disabled = false;
			document.getElementById("confirmarSenha").disabled = false;
			document.getElementById("senha").focus();
		}
	}
</script>

<div class="wrapper">
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-12">
							<h1 class="m-0">
							  <c:choose>
							      <c:when test="${opAcao == 'confirmar-edicao'}">
							      	<h1><b>Editar Dados de <c:out value="${usuarioTemp.nome}"/></b></h1>
							      </c:when>				
							      <c:otherwise>
							      	<h1><b>Novo Autor</b></h1>
							      </c:otherwise>
							  </c:choose>
							</h1>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->


		<form method="post" align="left" style="width: 70%"
			data-toggle="validator" role="form" name="formExemplo"
			id="formExemplo" class="well form-horizontal"
			action="${pageContext.servletConfig.servletContext.contextPath}/usuario/<c:out value="${opAcao}"></c:out>">

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<div class="form-group col-md-12">
								<c:choose>
									<c:when test="${opAcao == 'confirmar-edicao'}">
										<input type="hidden" name="usuario.key"
											value="<c:out value="${usuarioTemp.key}"></c:out>">
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label>Nome:</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-user"></i></span>
											</div>
											<input type="text" class="form-control" name="usuario.nome"
												id="nome" placeholder="Nome" required maxlength="60"
												value="<c:out value="${usuarioTemp.nome}"></c:out>"
												tabindex="1">
										</div>
										<!-- /.input group -->
										<div class="help-block with-errors"></div>
									</div>								
									<div class="form-group col-md-6">
										<label>CPF:</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-passport"></i></span>
											</div>
											<input type="text" class="form-control" name="usuario.cpf"
												id="cpf" required maxlength="60"
												value="<c:out value="${usuarioTemp.cpf}"></c:out>"
												tabindex="3" placeholder="999.999.999-99"
												data-inputmask="'mask': ['999.999.999-99']" data-mask>
										</div>
										<!-- /.input group -->
										<div class="help-block with-errors"></div>
									</div>
								</div>
						</div>
						
					</div>
					
					<div class="row">
						<div class="form-group col-md-12">
								<c:choose>
									<c:when test="${opAcao == 'confirmar-edicao'}">
										<input type="hidden" name="usuario.key"
											value="<c:out value="${usuarioTemp.key}"></c:out>">
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<div class="form-row">
									<div class="form-group col-md-5">
										<label>Senha:</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-key"></i></span>
											</div>
											<input
													type="password" class="form-control" name="usuario.senha"
													id="senha" placeholder="Senha" required maxlength="60"
													value="<c:out value="${usuarioTemp.senha}"></c:out>"
													disabled tabindex="4">
										</div>
										<!-- /.input group -->
										<div class="help-block with-errors"></div>
									</div>								
									<div class="form-group col-md-5">
										<label>Confirmar Senha:</label>
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i
													class="fas fa-key"></i></span>
											</div>
											<input
													type="password" disabled class="form-control" name="confirmarSenha"
													id="confirmarSenha" placeholder="Confirmar Senha" required
													data-match="#senha"
													data-match-error="Campo senha e confirmação devem ser iguais."
													maxlength="60"
													value="<c:out value="${usuarioTemp.senha}"></c:out>"
													tabindex="5">
										</div>
										<!-- /.input group -->
										<div class="help-block with-errors"></div>
									</div>
									<div class="form-group col-md-2">
										<label>Ignorar?</label>
										<div class="input-group">
											<input type="checkbox" onchange="ignorarSenha(this);"												
												data-bootstrap-switch data-off-color="danger" checked
												data-on-color="success">
										</div>									
									</div> 
								</div>
						</div>
						
					</div>	
					
					<div class="row">
						<div class="form-group col-md-12">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label>Email:</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="fas fa-at"></i></span>
										</div>
										<input type="email" class="form-control" name="usuario.email"
											id="email" placeholder="Email" required
											data-error="Por favor, informe um e-mail correto."
											maxlength="60"
											value="<c:out value="${usuarioTemp.email}"></c:out>"
											tabindex="6">
									</div>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>								
								</div>								
								<div class="form-group col-md-6">
									<label>Telefone:</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="fas fa-phone"></i></span>
										</div>
										<input type="text" class="form-control"
											name="usuario.telefone" id="telefone" required maxlength="60"
											value="<c:out value="${usuarioTemp.telefone}"></c:out>"
											tabindex="7" placeholder="(99) 99999-9999"
											data-inputmask="'mask': ['(99) 9999-9999']" data-mask>
									</div>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>
								</div>
							</div>
						
						</div>
					
					<div class="row">
						<div class="form-group col-md-12">
							<button type="button" class="btn btn-secondary"
								onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/usuario/'">VOLTAR</button>
							<c:choose>
								<c:when test="${opAcao == 'confirmar-adicao'}">
									<button type="submit" class="btn btn-primary">CADASTRAR</button>
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary">ALTERAR</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</section>
		</form>						
		</div>
	</div>
<jsp:include page="../../util/rodape.jsp" />

</body>

</html>
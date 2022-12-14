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
						      	<h1><b>Editar Arquivo <c:out value="${arquivoTemp.nome}"/></b></h1>
						      </c:when>				
						      <c:otherwise>
						      	<h1><b>Novo Arquivo</b></h1>
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
			action="${pageContext.servletConfig.servletContext.contextPath}/arquivo/<c:out value="${opAcao}"></c:out>">

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<div class="form-group col-md-6">
							<c:choose>
								<c:when test="${opAcao == 'confirmar-edicao'}">
									<input type="hidden" name="arquivo.key"
										value="<c:out value="${arquivoTemp.key}"></c:out>">
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<h3>Dados Obrigatórios</h3>
							<div class="form-row">
								<div class="form-group col-md-12">
									<label>Nome:</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="fas fa-edit"></i></span>
										</div>
										<input type="text" class="form-control" name="arquivo.descricao"
											id="descricao" placeholder="Nome" required maxlength="60"
											value="<c:out value="${arquivoTemp.nome}"></c:out>"
											tabindex="1">
									</div>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>
								</div>
							</div>
						</div>						
					</div>
					<div class="row">
						<div class="form-group col-md-12">
							<button type="button" class="btn btn-secondary"
								onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/arquivo/'"><i class="fa fa-undo"></i> VOLTAR</button>
							<c:choose>
								<c:when test="${opAcao == 'confirmar-adicao'}">
									<button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> CADASTRAR</button>
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> ALTERAR</button>
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
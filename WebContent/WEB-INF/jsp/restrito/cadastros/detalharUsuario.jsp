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


<div class="wrapper" style="width: 100%">
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<div class="content-header" align="center">
				<div class="container-fluid">
					<div class="row mb-12">
						<h1 class="m-0">
					      	<h1><b><c:out value="${usuario.login}"/></b></h1>
						</h1>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->
			
			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<div class="form-group col-md-12">
							<form>
							  <div class="form-group row">
							    <label for="staticNome" class="col-sm-2 col-form-label">Nome</label>
							    <div class="col-sm-6">
							      <input type="text" readonly class="form-control-plaintext" id="staticNome" value="${usuario.login}">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
							    <div class="col-sm-6">
							      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="">
							    </div>
							  </div>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-12">
							<form>
							  <div class="form-group row">
							    <label for="staticCpf" class="col-sm-2 col-form-label">CPF</label>
							    <div class="col-sm-6">
							      <input type="text" readonly class="form-control-plaintext" id="staticCpf" value="">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="staticTelefone" class="col-sm-2 col-form-label">Telefone</label>
							    <div class="col-sm-6">
							      <input type="text" readonly class="form-control-plaintext" id="staticTelefone" value="<c:out value=""/>">
							    </div>
							  </div>
							  <div class="form-group row">
							    <div class="col-sm-12">
							      Dados Complementares
							    </div>
							  </div>	
							  <div class="form-group row">
							    <div class="col-sm-12">
			  						<button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/usuario/'"><i class="fa fa-undo"></i> VOLTAR</button>
									<button type="button" class="btn btn-info" onClick="print();"><i class="fa fa-print"></i> IMPRIMIR</button>							    
							    </div>
							  </div>	
							</form>
						</div>
					</div>
					
				</div>
			</section>

		</div>
	</div>



<jsp:include page="../../util/rodape.jsp" />

</body>

</html>


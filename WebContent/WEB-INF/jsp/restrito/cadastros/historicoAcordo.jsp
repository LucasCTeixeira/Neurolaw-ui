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
$(document).ready(function() {
    $('#example').DataTable();
} );
</script>

<div class="wrapper">
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-12">
							<h1 class="m-0" align="center"><b>Histórico do Acordo <c:out value="${id}"/></b></h1>
						</div>
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
							<table id="example" class="table table-striped table-bordered"
								style="width: 100%">
								<thead>
									<tr>
										<th>Nome</th>
										<th>Status</th>
										<th>Data de Criação</th>
										<th>Participantes</th>
										<th>Arquivos</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${registros}" var="registro">
										<tr>
											<td><c:out value="${registro.agreementName}"></c:out></td>
											<td><c:out value="${registro.agreementStatus}"></c:out></td>
											<td><c:out value="${registro.creationDate}"></c:out></td>
											<td>
												<c:forEach items="${registro.participants}" var="participante">
													<c:out value="${participante}"/><br>												
												</c:forEach>
											</td>
											<td>
												<c:forEach items="${registro.attachments}" var="arquivo">
													<a href="${pageContext.servletConfig.servletContext.contextPath}/acordo/arquivo/<c:out value="${arquivo.id}"/>"><c:out value="${arquivo.filename}"/></a>
													<br>											
												</c:forEach>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot align="left">
									<tr>
										<th>Nome</th>
										<th>Status</th>
										<th>Data de Criação</th>
										<th>Participantes</th>
										<th>Arquivos</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
					<!-- /.row (main row) -->
				</div>
				
				  <div class="form-group row">
				    <div class="col-sm-12">
  						<button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/acordo/'"><i class="fa fa-undo"></i> VOLTAR</button>
						<button type="button" class="btn btn-info" onClick="print();"><i class="fa fa-print"></i> IMPRIMIR</button>							    
				    </div>
				  </div>	
				
				
				<!-- /.container-fluid -->
			</section>    


		</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- ./wrapper -->

	<jsp:include page="../../util/rodape.jsp" />

</body>
</html>
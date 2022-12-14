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
							<h1 class="m-0" align="center"><b>Listando Ocorrências</b></h1>
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
										<th>ID</th>
										<th>Descrição</th>
										<th>Ação</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${registros}" var="registro">
										<tr>
											<td><c:out value="${registro.key}"></c:out></td>
											<td><c:out value="${registro.mulher.nome}"></c:out></td>
											<td>
												<button onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/editar/<c:out value="${registro.key}"></c:out>'" class="btn btn-warning btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="" data-original-title="Edit"><i class="fa fa-edit"></i></button>
												<button onclick="javascript:confirmarExclusao(<c:out value="${registro.key}"></c:out>, '<c:out value="${registro.mulher.nome}"></c:out>', '${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/remover/<c:out value="${registro.key}"></c:out>');" class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="" data-original-title="Delete"><i class="fa fa-trash"></i></button>
												<button onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/detalhar/<c:out value="${registro.key}"></c:out>'" class="btn btn-info btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="" data-original-title="View"><i class="fa fa-eye"></i></button>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot align="left">
									<tr>
										<th>ID</th>
										<th>Descrição</th>
										<th>Ação</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-12">
							<h1 class="m-0" align="center">
								<button type="button" class="btn btn-success" onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/adicionar'"><i class="fa fa-plus"></i> ADICIONAR UMA NOVA OCORRÊNCIA</button>
							</h1>
						</div>
					</div>
					<!-- /.row (main row) -->
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
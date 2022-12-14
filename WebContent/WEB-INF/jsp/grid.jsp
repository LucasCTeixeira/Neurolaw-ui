<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.servletConfig.servletContext.contextPath}/assets/css/site-examples.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletConfig.servletContext.contextPath}/assets/css/jquery.dataTables.min.css">

<script type="text/javascript" language="javascript"
	src="${pageContext.servletConfig.servletContext.contextPath}/assets/js/jquery-3.3.1.js"></script>
<script type="text/javascript" language="javascript"
	src="${pageContext.servletConfig.servletContext.contextPath}/assets/js/jquery.dataTables.min.js"></script>

</head>
<body>

	<script>
		$(document).ready(function() {
			$('#example').DataTable();
		});
	</script>
	
	<center>

	<div id="grid" style="width: 90%" align="center">
		<table id="example" class="display" style="width: 100%" align="center">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>Login</th>
					<th>Email</th>
					<th>Ação</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>Marcelo Revoredo</td>
					<td>revoredo</td>
					<td>revoredo@gmail.com</td>
					<td>
						<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/usuario/editar/1'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/edit.png">&nbsp;&nbsp;&nbsp;
						<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/usuario/excluir/1'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/trash.png">&nbsp;&nbsp;&nbsp;
						<img style="cursor: pointer" onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/usuario/detalhar/1'" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/zoom_in.png">
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Carlo Silva</td>
					<td>carlo</td>
					<td>carlo@gmail.com</td>
					<td>xxx</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Silva Revoredo</td>
					<td>silva</td>
					<td>silva@gmail.com</td>
					<td>xxx</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Carlo Marcelo</td>
					<td>marcelo</td>
					<td>marcelo@gmail.com</td>
					<td>xxx</td>
				</tr>
				<tr>
					<td>5</td>
					<td>Marcelo Silva</td>
					<td>msilva</td>
					<td>msilva@gmail.com</td>
					<td>xxx</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>Login</th>
					<th>Email</th>
					<th>Ação</th>
				</tr>
			</tfoot>
		</table>
	</div>
	</center>
</body>
</html>
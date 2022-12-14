<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->


<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<c:if test="${empty sessionScope.autenticado}">
	<c:redirect url="/deslogar"/>
</c:if>



<body>

<center>
<h1>HISTÓRICO</h1>
<h3>NOME DO ARQUIVO - Data de envio: DD/MM/YYYY HH:mm</h3>


<table class="table table-hover" style="width: 90%">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Última modificação</th>
      <th scope="col">Autor</th>
      <th scope="col">Baixar versão</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>12/10/2022 10:48</td>
      <td>Empresa B</td>
      <td>Download</td>
    </tr>
  </tbody>
</table>

<a href="deslogar">Deslogar</a>
</center>

</body>


</html>

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
<h1>Bem vindo, <c:out value="${sessionScope.autenticado.login}"/>!<br></h1>


<table class="table table-hover" style="width: 90%">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Nome do Arquivo</th>
      <th scope="col">Data do envio (autor)</th>
      <th scope="col">Última modificação (autor)</th>
      <th scope="col">Ação</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td >planinha_averbacoes.xmls</td>
      <td>12/10/2022 10:48 (Empresa A)</td>
      <td>19/10/2022 11:15 (Empresa B)</td>
      <td>Baixar | Excluir | <a href="historico">Ver histórico</a></td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>carta_anuencia.pdf</td>
      <td>15/10/2022 07:25 (Empresa A)</td>
      <td>17/10/2022 12:15 (Participante A)</td>
      <td>Baixar | Excluir | <a href="historico">Ver histórico</a></td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td>planinha_averbacoes.xmls</td>
      <td>13/10/2022 13:05 (Empresa B)</td>
      <td>14/10/2022 09:15 (Empresa A)</td>
      <td>Baixar | Excluir | <a href="historico">Ver histórico</a></td>
    </tr>
  </tbody>
</table>

<a href="deslogar">Deslogar</a>
</center>

</body>


</html>

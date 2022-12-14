<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />

<script>
	$('#formExemplo').validator();
</script>

</head>
<body>

<form id="formExemplo" data-toggle="validator" role="form" class="well form-horizontal">
  <div class="form-group">
    <label for="textNome" class="control-label">Nome</label>
    <input id="textNome" class="form-control" placeholder="Digite seu Nome..." type="text" required>
  </div>
  
  <div class="form-group">
    <label for="inputEmail" class="control-label">Email</label>
    <input id="inputEmail" class="form-control" placeholder="Digite seu E-mail" type="email" 
      data-error="Por favor, informe um e-mail correto." required>
    <div class="help-block with-errors"></div>
  </div>
  
  <div class="form-group">
    <label for="inputPassword" class="control-label">Senha</label>
    <input type="password" class="form-control" id="inputPassword" placeholder="Digite sua Senha..."  
      data-minlength="6" required>
    <span class="help-block">Mínimo de seis (6) digitos</span>
  </div>
  
  <div class="form-group">
    <label for="inputConfirm" class="control-label">Confirme a Senha</label>
    <input type="password" class="form-control" id="inputConfirm" placeholder="Confirme sua Senha..." 
      data-match="#inputPassword" data-match-error="Atenção! As senhas não estão iguais." required>
    <div class="help-block with-errors"></div>
  </div>
  
  <div class="form-group">
    <div class="checkbox">
      <label>
        <input type="checkbox" data-error="Você deve marcar este campo!" required> Marque este item.
      </label>
      <div class="help-block with-errors"></div>
    </div>
  </div>
  
  <div class="form-group">
    <button type="submit" class="btn btn-primary">Enviar</button>
  </div>
</form>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>

</body>
</html>
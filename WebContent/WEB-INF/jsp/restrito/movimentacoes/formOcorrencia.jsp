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
						      	<h1><b>Editar Ocorrência <c:out value="${ocorrenciaTemp.key}"/></b></h1>
						      </c:when>				
						      <c:otherwise>
						      	<h1><b>Nova Ocorrência </b></h1>
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
			action="${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/<c:out value="${opAcao}"></c:out>">

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<!-- Small boxes (Stat box) -->
					<div class="row">
						<div class="form-group col-md-12">
							<c:choose>
								<c:when test="${opAcao == 'confirmar-edicao'}">
									<input type="hidden" name="ocorrencia.key"
										value="<c:out value="${ocorrenciaTemp.key}"></c:out>">
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<h3>Dados Obrigatórios</h3>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="mulher"><b>Mulher</b></label> <select
										id="mulher" name="ocorrencia.mulher.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Informe</option>
										<c:forEach items="${mulheres}" var="mulher">
											<c:choose>
												<c:when
													test="${mulher.key eq ocorrenciaTemp.mulher.key}">
													<option selected value="${mulher.key}">${mulher.nome} (${mulher.cpf})</option>
												</c:when>
												<c:otherwise>
													<option value="${mulher.key}">${mulher.nome} (${mulher.cpf})</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>		
								
								<div class="form-group col-md-1">
									<label for="ufEndereco"><b>UF</b></label>
									<select id="ufEndereco" onchange="popularMunicipios(this.value, '${ocorrenciaTemp.municipio.nome}');" class="form-control select2bs4"
										style="width: 100%;" required>
										<option selected value="">Informe</option>
										<c:forEach items="${ufs}" var="uf">
											<option value="${uf.sigla}">${uf.sigla}</option>
										</c:forEach>
									</select>
								</div>
								
								<div class="form-group col-md-3">
									<label for="municipio"><b>Municipio da Ocorrência</b></label> 
									<select 
										id="municipio" name="ocorrencia.municipio.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option value="">Aguardando uma UF</option>
									</select>
								</div>
								
								<div class="form-group col-md-2">
									<label>Data de Abertura:</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="far fa-calendar-alt"></i></span>
										</div>
										<c:choose>
											<c:when test="${ocorrenciaTemp.dataAbertura eq null}">
												<fmt:formatDate value='${dataAtual}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataAbertura' />
											</c:when>
											<c:otherwise>
												<fmt:formatDate value='${ocorrenciaTemp.dataAbertura}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataAbertura' />
											</c:otherwise>
										</c:choose>										
										
										<input name="ocorrencia.dataAbertura" id="dataAbertura"
											value="${dataAbertura}" tabindex="8" required
											placeholder="Formato dd/mm/aaaa hh:mm" onblur="validarDataComHora(this);"
											type="text" class="form-control"
											data-inputmask-alias="datetime"
											data-inputmask-inputformat="dd/mm/yyyy HH:MM" data-mask>
									</div>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>
								</div>								
								
							</div>													
							
							<div class="form-row">
								<div class="form-group col-md-2">
									<label>B.O:</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="fas fa-edit"></i></span>
										</div>
										<input type="text" class="form-control" name="ocorrencia.boletimOcorrencia"
											id="boletimOcorrencia" placeholder="Protolo do Boletim de Ocorrencia" maxlength="60"
											value="<c:out value="${ocorrenciaTemp.boletimOcorrencia}"></c:out>"
											tabindex="1">
									</div>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>
								</div>
								<div class="form-group col-md-3">
									<label for="origem"><b>Orgão de Origem</b></label> <select
										id="origem" name="ocorrencia.orgaoOrigem.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
										<c:forEach items="${orgaos}" var="orgao">
											<c:choose>
												<c:when
													test="${orgao.key eq ocorrenciaTemp.orgaoOrigem.key}">
													<option selected value="${orgao.key}">${orgao.nome}</option>
												</c:when>
												<c:otherwise>
													<option value="${orgao.key}">${orgao.nome}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-3">
									<label for="dependenciaQuimica"><b>Orgãos de Destino</b></label>
									<select class="select2bs4" multiple="multiple" id="orgaosDestino" name="ocorrencia.orgaosDestino[].key"
									data-placeholder="Selecione Orgãos" style="width: 100%;">
										<c:forEach items="${orgaos}" var="orgao">

											<c:set var="contains" value="false" />
											<c:forEach var="org" items="${ocorrenciaTemp.orgaosDestino}">
												<c:if test="${org.key eq orgao.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${orgao.key}">${orgao.nome}</option>
												</c:when>
												<c:otherwise>
													<option value="${orgao.key}">${orgao.nome}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-2">
									<label>Dentro da competência?</label>
									<div class="input-group">
										<input type="checkbox" id="dentroDaCompetencia"
											name="ocorrencia.dentroCompetencia"
											<c:choose><c:when test="${ocorrenciaTemp.dentroCompetencia eq null or ocorrenciaTemp.dentroCompetencia eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>								
								<div class="form-group col-md-2">
									<label>Houve Feminicídio?</label>
									<div class="input-group">
										<input type="checkbox" id="feminicidio"
											name="ocorrencia.feminicidio"
											<c:choose><c:when test="${ocorrenciaTemp.feminicidio eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>	
							</div>
						</div>						
					</div>
					
					<c:choose>
						<c:when test="${opAcao == 'confirmar-edicao'}">
							<h3>Dados da Violência</h3>					
							<div class="row">					
								<div class="form-group col-md-6">
									<label for="autor"><b>Autor principal:</b></label> <select
										id="autor" name="ocorrencia.autorPrincipal.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
										<c:forEach items="${autores}" var="autor">
											<c:choose>
												<c:when
													test="${autor.key eq ocorrenciaTemp.autorPrincipal.key}">
													<option selected value="${autor.key}">${autor.nome}&nbsp;<c:choose><c:when test="${autor.cpf ne null}">(${autor.cpf})</c:when><c:otherwise>(${autor.apelido})</c:otherwise> </c:choose></option>
												</c:when>
												<c:otherwise>
													<option value="${autor.key}">${autor.nome}&nbsp;<c:choose><c:when test="${autor.cpf ne null}">(${autor.cpf})</c:when><c:otherwise>(${autor.apelido})</c:otherwise> </c:choose></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-6">
									<label for="coautores"><b>Coautores</b></label>
									<select class="select2bs4" multiple="multiple" id="coautores" name="ocorrencia.coautores[].key"
									data-placeholder="Selecione uma ou mais coautores" style="width: 100%;">
										<c:forEach items="${autores}" var="autor">
		
											<c:set var="contains" value="false" />
											<c:forEach var="aut" items="${ocorrenciaTemp.coautores}">
												<c:if test="${aut.key eq autor.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${autor.key}">${autor.nome}&nbsp;<c:choose><c:when test="${autor.cpf ne null}">(${autor.cpf})</c:when><c:otherwise>(${autor.apelido})</c:otherwise> </c:choose></option>
												</c:when>
												<c:otherwise>
													<option value="${autor.key}">${autor.nome}&nbsp;<c:choose><c:when test="${autor.cpf ne null}">(${autor.cpf})</c:when><c:otherwise>(${autor.apelido})</c:otherwise> </c:choose></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-md-6">
									<label for="localAgressao"><b>Relação da Mulher com o Autor principal</b></label> <select
										id="localAgressao" name="ocorrencia.relacao.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
										<c:forEach items="${relacoes}" var="local">
											<c:choose>
												<c:when
													test="${local.key eq ocorrenciaTemp.relacao.key}">
													<option selected value="${local.key}">${local.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${local.key}">${local.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-6">
									<label for="localAgressao"><b>Local da Agressão</b></label> <select
										id="localAgressao" name="ocorrencia.localAgressao.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
										<c:forEach items="${locais}" var="local">
											<c:choose>
												<c:when
													test="${local.key eq ocorrenciaTemp.localAgressao.key}">
													<option selected value="${local.key}">${local.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${local.key}">${local.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
									
							</div>
							
							<div class="row">
								<div class="form-group col-md-4">
									<label for="objetosAgressao"><b>Objetos da Agressão</b></label>
									<select class="select2bs4" multiple="multiple" id="objetosAgressao" name="ocorrencia.objetosAgressao[].key"
									data-placeholder="Selecione" style="width: 100%;">
										<c:forEach items="${objetos}" var="objeto">
		
											<c:set var="contains" value="false" />
											<c:forEach var="obj" items="${ocorrenciaTemp.objetosAgressao}">
												<c:if test="${obj.key eq objeto.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${objeto.key}">${objeto.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${objeto.key}">${objeto.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>	
								<div class="form-group col-md-4">
									<label for="atribuicaoes"><b>Atribuições</b></label>
									<select class="select2bs4" multiple="multiple" id="atribuicaoes" name="ocorrencia.atribuicoes[].key"
									data-placeholder="Selecione uma ou mais atribuições" style="width: 100%;">
										<c:forEach items="${atribuicoes}" var="atribuicao">
		
											<c:set var="contains" value="false" />
											<c:forEach var="atrib" items="${ocorrenciaTemp.atribuicoes}">
												<c:if test="${atrib.key eq atribuicao.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${atribuicao.key}">${atribuicao.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${atribuicao.key}">${atribuicao.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								
								<div class="form-group col-md-4">
									<label for="violenciasEmocionais"><b>Violências Emocionais</b></label>
									<select class="select2bs4" multiple="multiple" id="violenciasEmocionais" name="ocorrencia.violenciasEmocionais[].key"
									data-placeholder="Selecione uma ou mais violências emocionais" style="width: 100%;">
										<c:forEach items="${violenciaEmocionais}" var="violencia">
		
											<c:set var="contains" value="false" />
											<c:forEach var="viol" items="${ocorrenciaTemp.violenciasEmocionais}">
												<c:if test="${viol.key eq violencia.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${violencia.key}">${violencia.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${violencia.key}">${violencia.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								
									
							</div>
						
							<div class="form-row">
								<div class="form-group col-md-4">
									<label for="violenciasFisicas"><b>Violências Fisicas</b></label>
									<select class="select2bs4" multiple="multiple" id="violenciasFisicas" name="ocorrencia.violenciasFisicas[].key"
									data-placeholder="Selecione uma ou mais violências emocionais" style="width: 100%;">
										<c:forEach items="${violenciaFisicas}" var="violencia">
		
											<c:set var="contains" value="false" />
											<c:forEach var="viol" items="${ocorrenciaTemp.violenciasFisicas}">
												<c:if test="${viol.key eq violencia.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${violencia.key}">${violencia.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${violencia.key}">${violencia.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>							
								<div class="form-group col-md-4">
									<label for="violenciasPatrimoniais"><b>Violências Patrimoniais</b></label>
									<select class="select2bs4" multiple="multiple" id="violenciasPatrimoniais" name="ocorrencia.violenciasPatrimoniais[].key"
									data-placeholder="Selecione uma ou mais violências emocionais" style="width: 100%;">
										<c:forEach items="${violenciaPatrimoniais}" var="violencia">
		
											<c:set var="contains" value="false" />
											<c:forEach var="viol" items="${ocorrenciaTemp.violenciasPatrimoniais}">
												<c:if test="${viol.key eq violencia.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${violencia.key}">${violencia.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${violencia.key}">${violencia.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>								
								
								<div class="form-group col-md-4">
									<label for="violenciasSexuais"><b>Violências Sexuais</b></label>
									<select class="select2bs4" multiple="multiple" id="violenciasSexuais" name="ocorrencia.violenciasSexuais[].key"
									data-placeholder="Selecione uma ou mais violências emocionais" style="width: 100%;">
										<c:forEach items="${violenciaSexuais}" var="violencia">
		
											<c:set var="contains" value="false" />
											<c:forEach var="viol" items="${ocorrenciaTemp.violenciasSexuais}">
												<c:if test="${viol.key eq violencia.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${violencia.key}">${violencia.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${violencia.key}">${violencia.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								
							</div>
							
							<h3>Medidas Cautelares</h3>					
							<div class="row">
								<div class="form-group col-md-3">
									<label>Familiares tem conhecimento?</label>
									<div class="input-group">
										<input type="checkbox" id="familiaresConhecimento"
											name="ocorrencia.familiaresConhecimento"
											<c:choose><c:when test="${ocorrenciaTemp.familiaresConhecimento eq null or ocorrenciaTemp.familiaresConhecimento eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>								
								<div class="form-group col-md-3">
									<label>Informado abrigamento?</label>
									<div class="input-group">
										<input type="checkbox" id="informadoAbrigamento"
											name="ocorrencia.informadoAbrigamento"
											<c:choose><c:when test="${ocorrenciaTemp.informadoAbrigamento eq null or ocorrenciaTemp.informadoAbrigamento eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>								
								<div class="form-group col-md-3">
									<label>Aceitou abrigamento?</label>
									<div class="input-group">
										<input type="checkbox" id="aceitouAbrigamento"
											name="ocorrencia.aceitouAbrigamento"
											<c:choose><c:when test="${ocorrenciaTemp.aceitouAbrigamento eq null or ocorrenciaTemp.aceitouAbrigamento eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>								
								<div class="form-group col-md-3">
									<label>Encaminhada por terceiros?</label>
									<div class="input-group">
										<input type="checkbox" id=encaminhadaPorTerceiros
											name="ocorrencia.encaminhadaPorTerceiros"
											<c:choose><c:when test="${ocorrenciaTemp.encaminhadaPorTerceiros eq null or ocorrenciaTemp.encaminhadaPorTerceiros eq true}"><c:out value="checked"/></c:when><c:otherwise></c:otherwise></c:choose>
											data-bootstrap-switch data-off-color="danger"
											data-on-color="success">
									</div>
								</div>								
							</div>
							
							<h3>Perícia</h3>					
							<div class="row">
								<div class="form-group col-md-10">
									<label for="evolucoesPsicologicas"><b>Evolução Psicológica</b></label>
									<select class="select2bs4" multiple="multiple" id="evolucoesPsicologicas" name="mulher.evolucoesPsicologicas[].key"
									data-placeholder="Nenhum" style="width: 100%;">													
										<c:forEach items="${ocorrenciaTemp.evolucoesPsicologicas}" var="evolucao">
											<fmt:formatDate value='${evolucao.dataRegistro}'
												type='date' pattern='dd/MM/yyyy' var='dataReg' />										
											<option selected value="${evolucao.key}">(${dataReg}) ${evolucao.laudo}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-2">												
									<br><button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModalEvolucoes"><i class="fa fa-window-restore"></i> Adicionar</button>						
								</div>
							</div>
							<div class="row">							
								<div class="form-group col-md-10">
									<label for="prontuariosJuridicos"><b>Prontuários Jurídicos</b></label>
									<select class="select2bs4" multiple="multiple" id="prontuariosJuridicos" name="mulher.prontuariosJuridicos[].key"
									data-placeholder="Nenhum" style="width: 100%;">													
										<c:forEach items="${ocorrenciaTemp.prontuariosJuridicos}" var="prontuario">
											<fmt:formatDate value='${prontuario.dataRegistro}'
												type='date' pattern='dd/MM/yyyy' var='dataReg' />
											<option selected value="${prontuario.key}">(${dataReg}) ${prontuario.laudo}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-2">												
									<br><button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModalProntuarios"><i class="fa fa-window-restore"></i> Adicionar</button>						
								</div>
							</div>
			
							<div class="row">
								<div class="form-group col-md-4">
									<label for="origem"><b>Orgão Exame Traumatológico</b></label> <select
										id="origem" name="ocorrencia.orgaoExameTraumatologico.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
										
											<c:set var="exameTraumaDefault"/>
											<c:choose>
												<c:when
													test="${ocorrenciaTemp.orgaoExameTraumatologico.key ne null}">
													<c:set var="exameTraumaDefault" value="${ocorrenciaTemp.orgaoExameTraumatologico.key}"/>
												</c:when>
												<c:otherwise>
													<c:forEach items="${orgaos}" var="orgao">
														<c:if test="${orgao.nome=='IML'}">
															<c:set var="exameTraumaDefault" value="${orgao.key}"/>
														</c:if>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										
										<c:forEach items="${orgaos}" var="orgao">
											<c:choose>
												<c:when
													test="${orgao.key eq exameTraumaDefault}">
													<option selected value="${orgao.key}">${orgao.nome}</option>
												</c:when>
												<c:otherwise>
													<option value="${orgao.key}">${orgao.nome}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-4">
									<label for="origem"><b>Orgão Exame Sexológico</b></label> <select
										id="origem" name="ocorrencia.orgaoExameSexologico.key" required
										class="form-control select2bs4" style="width: 100%;">
										<option selected value="">Não informado</option>
		
										<c:set var="exameSexoDefault"/>
											<c:choose>
												<c:when
													test="${ocorrenciaTemp.orgaoExameSexologico.key ne null}">
													<c:set var="exameSexoDefault" value="${ocorrenciaTemp.orgaoExameSexologico.key}"/>
												</c:when>
												<c:otherwise>
													<c:forEach items="${orgaos}" var="orgao">
														<c:if test="${orgao.nome=='IML'}">
															<c:set var="exameSexoDefault" value="${orgao.key}"/>
														</c:if>
													</c:forEach>
												</c:otherwise>
											</c:choose>

										<c:forEach items="${orgaos}" var="orgao">
											<c:choose>
												<c:when
													test="${orgao.key eq exameSexoDefault}">
													<option selected value="${orgao.key}">${orgao.nome}</option>
												</c:when>
												<c:otherwise>
													<option value="${orgao.key}">${orgao.nome}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="form-group col-md-4">
									<label for="dependenciaQuimica"><b>Cursos de interesse</b></label>
									<select class="select2bs4" multiple="multiple" id="cursosInteresse" name="ocorrencia.cursos[].key"
									data-placeholder="Selecione Cursos" style="width: 100%;">
										<c:forEach items="${cursos}" var="curso">

											<c:set var="contains" value="false" />
											<c:forEach var="curs" items="${ocorrenciaTemp.cursos}">
												<c:if test="${curs.key eq curso.key}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach>
											
											<c:choose>
												<c:when test="${contains eq true}">
													<option selected value="${curso.key}">${curso.descricao}</option>
												</c:when>
												<c:otherwise>
													<option value="${curso.key}">${curso.descricao}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<!-- /.input group -->
									<div class="help-block with-errors"></div>
								</div>							
							</div>
															
							<div class="form-row">
								<div class="form-group col-md-12">
									<label>Relatório do atendimento:</label>
									<textarea name="ocorrencia.relatorioAtendimento" id="relatorioAtendimento">${ocorrenciaTemp.relatorioAtendimento}</textarea>
								</div>							
							</div>							
							
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					
					<div class="row">
						<div class="form-group col-md-12">
							<button type="button" class="btn btn-secondary"
								onClick="location.href='${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/'"><i class="fa fa-undo"></i> VOLTAR</button>
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

<script src="${pageContext.servletConfig.servletContext.contextPath}/plugins/summernote/summernote-bs4.min.js"></script>

<c:choose>
<c:when test="${opAcao == 'confirmar-edicao'}">
	
	<div class="modal fade" id="exampleModalEvolucoes" tabindex="-1" role="dialog" aria-labelledby="exampleModalEvolucoesLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalEvolucoesLabel">Evolução Psicológica de ${ocorrenciaTemp.mulher.nome}</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>										      
			      <div class="modal-body">
						<form align="left" method="post"
							action="${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/adicionar-evolucao-psicologica/${ocorrenciaTemp.key}"
							data-toggle="validator" role="form" name="formExemploEvolucao"
							id="formExemploEvolucao" class="well form-horizontal">

							<input type="hidden" name="evolucaoPsicologica.ocorrencia.key"
								value="<c:out value="${ocorrenciaTemp.key}"></c:out>">
								
							<div class="form-group">
								<fmt:formatDate value='${dataAtual}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataRegAtual' />
								<label for="recipient-name" class="col-form-label">Data de Registro:</label> <input name="evolucaoPsicologica.dataRegistro"
									id="dataRegistro" tabindex="8"
									placeholder="Formato dd/mm/aaaa" onblur="validarData(this);"
									type="text" class="form-control" value="${dataRegAtual}"
									data-inputmask-alias="datetime" required
									data-inputmask-inputformat="dd/mm/yyyy" data-mask>
							</div>								
								
							<div class="form-group">
								<label for="recipient-name" class="col-form-label">Laudo:</label>
								<textarea required name="evolucaoPsicologica.laudo" id="laudo" class="form-control" id="laudo" rows="3"></textarea>								
								<div class="help-block with-errors"></div>
							</div>
							<div class="modal-footer">
								<button type="button" id="btnDepClose"
									class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-undo"></i> Cancelar</button>
								<button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Salvar</button>
							</div>
						</form>
					</div>
			  </div>
			</div>
		</div>

	<div class="modal fade" id="exampleModalProntuarios" tabindex="-1" role="dialog" aria-labelledby="exampleModalProntuariosLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalProntuariosLabel">Prontuário Jurídico de ${ocorrenciaTemp.mulher.nome}</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>										      
			      <div class="modal-body">
						<form align="left" method="post"
							action="${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/adicionar-prontuario-juridico/${ocorrenciaTemp.key}"
							data-toggle="validator" role="form" name="formExemploProntuario"
							id="formExemploProntuario" class="well form-horizontal">

							<input type="hidden" name="prontuarioJuridico.ocorrencia.key"
								value="<c:out value="${ocorrenciaTemp.key}"></c:out>">
								
							<div class="form-group">
								<fmt:formatDate value='${dataAtual}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataRegAtual' />
								<label for="recipient-name" class="col-form-label">Data de Registro:</label> <input name="prontuarioJuridico.dataRegistro"
									id="dataRegistro" tabindex="8"
									placeholder="Formato dd/mm/aaaa" onblur="validarData(this);"
									type="text" class="form-control" value="${dataRegAtual}"
									data-inputmask-alias="datetime" required
									data-inputmask-inputformat="dd/mm/yyyy" data-mask>
							</div>								
								
							<div class="form-group">
								<label for="recipient-name" class="col-form-label">Laudo:</label>
								<textarea required name="prontuarioJuridico.laudo" id="laudo" class="form-control" id="laudo" rows="3"></textarea>								
								<div class="help-block with-errors"></div>
							</div>
							<div class="modal-footer">
								<button type="button" id="btnDepClose"
									class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-undo"></i> Cancelar</button>
								<button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Salvar</button>
							</div>
						</form>
					</div>
			  </div>
			</div>
		</div>

	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>


<script>
  $(function () {
    // Summernote
    $('#relatorioAtendimento').summernote();
  })
 
 	function validarData(campo) {
		var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])      [\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;
		
		if (campo.value.length>0){
			if (!((campo.value.match(RegExPattern)) && (campo.value != ''))) {
				campo.value="";
				campo.focus();
			}
		}
	}
	$(document).on({
	    ajaxStart: function() { $('#loadingAjax').show();},
	     ajaxStop: function() { $('#loadingAjax').hide() }    
	});
 
	function validarDataComHora(campo) {
		var RegExPattern = /^(0[1-9]|1\d|2[0-8]|29(?=\/\d\d\/(?!1[01345789]00|2[1235679]00)\d\d(?:[02468][048]|[13579][26]))|30(?!\/02)|31(?=\/0[13578]|\/1[02]))\/(0[1-9]|1[0-2])\/([12]\d{3}) ([01]\d|2[0-3]):([0-5]\d)$/;
		
		if (campo.value.length>0){
			if (!((campo.value.match(RegExPattern)) && (campo.value != ''))) {
				campo.value="";
				campo.focus();
			}
		}
	}
  
  function popularMunicipios(uf, cidade){
	  $('#municipio').html("");
		var newOption = new Option("Aguardando uma UF", "", false, false);
		$('#municipio').append(newOption).trigger('change');
		var url = '${pageContext.servletConfig.servletContext.contextPath}/geo/buscar-por-uf/'+uf;
		$.ajax({
		    type: "get",
		    url: url,
		    contentType : "json",
		    success: function(data,status,xhr){
		    	$('#municipio').html("");    
	  			if (!data.hasOwnProperty('message')) {
	  				for(var m in data) {			  					
	  					var newOption = new Option(data[m].nome, data[m].key, false, false);
	  					$('#municipio').append(newOption).trigger('change');
	  				}
	  				if (cidade!=''){
	  					setDefaultMunicipio(cidade);
	  				}else{
		  				if (uf=="PE"){
		  					setDefaultMunicipio('Garanhuns');
		  				}
	  				}
	  			}else{
	  				exibirToast('warning', 5000, data.message);
	  			}
		    },
		    error: function(xhr, status, error){
		    	exibirToast('error', 5000, 'Erro ao tentar carregar os municípios');
		    },
		    complete: function(){
		    },
		    dataType: "json"
		});
	}  
  
	 function setDefaultUf(uf) {
		var sel = document.getElementById('ufEndereco');
	    for(var i = 0, j = sel.options.length; i < j; ++i) {
	    	if(sel.options[i].value==uf) {
	           sel.selectedIndex = i;
	           $('#ufEndereco').val(uf);
	           $('#ufEndereco').select2().trigger('change');
	           break;
	        }
	    }
	}  	

  function setDefaultMunicipio(cidade) {
	    var sel = document.getElementById('municipio');
	    for(var i = 0, j = sel.options.length; i < j; ++i) {
	    	if(sel.options[i].text==cidade) {
	           sel.selectedIndex = i;
	           $('#municipio').val(sel.options[i].value);
	           $('#municipio').select2().trigger('change');
	           break;
	        }
	    }
	}  
  
	$('#exampleModalEvolucoes').on(
			'show.bs.modal',
			function(event) {
				var modal = $(this)
				modal.find('.modal-title').text(
						'Evolução psicológica de ${ocorrenciaTemp.mulher.nome}')
			});
	
	$('#evolucoesPsicologicas').on("select2:unselecting", function(e) {
		confirmarExclusao('', e.params.args.data.text, '${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/remover-evolucao-psicologica/${ocorrenciaTemp.key}/'+e.params.args.data.id);
		return false;
	});
  
	$('#exampleModalProntuarios').on(
			'show.bs.modal',
			function(event) {
				var modal = $(this)
				modal.find('.modal-title').text(
						'Prontuário Jurídico de ${ocorrenciaTemp.mulher.nome}')
			});
	
	$('#prontuariosJuridicos').on("select2:unselecting", function(e) {
		confirmarExclusao('', e.params.args.data.text, '${pageContext.servletConfig.servletContext.contextPath}/ocorrencia/remover-prontuario-juridico/${ocorrenciaTemp.key}/'+e.params.args.data.id);
		return false;
	});	
</script>


<c:choose>
	<c:when test="${ocorrenciaTemp.municipio.key ne null}">
		<script>
		  $(document).ready(function() {
			  setDefaultUf('${ocorrenciaTemp.municipio.estado.sigla}');
		  });
		</script>
	</c:when>
	<c:otherwise>
		<script>
		  $(document).ready(function() {
			  setDefaultUf('PE');
		  });		
		</script>	
	</c:otherwise>
</c:choose>										


<jsp:include page="../../util/rodape.jsp" />

</body>

</html>
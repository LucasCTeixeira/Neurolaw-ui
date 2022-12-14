<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.servletConfig.servletContext.contextPath}/favicon.ico" type="image/x-icon" />
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<jsp:include page="../util/paginaRestrita.jsp" />


 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
    </section>

	<fmt:formatDate value='${dataAtual}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataEmissao'/>
   
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="callout callout-info">
            <img class="float-left" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/neurolaw-icon-64.png">
            <img class="float-right" src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/prefeitura.png">
              <h5>Secretaria da Mulher do Município de Garanhuns</h5>
              Rua Simoa Gomes, 16, Heliópolis, Garanhuns-PE, CEP 55296-250.
            </div>

            <!-- Main content -->
            <div class="invoice p-3 mb-3">
              <!-- title row -->
              <div class="row">
              	<div class="col-12" align="center">
              		<h1>Ocorrência <c:out value="${ocorrencia.key}"></c:out> </h1>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <h4>
                    <i class="fas fa-edit"></i> Dados Gerais
                  </h4>
                </div>
              </div>
              <!-- info row -->
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Dentro da Competência</th>
									<th>Município da Ocorrência</th>
									<th>Data de Abertura</th>
									<th>Orgão Origem</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.dentroCompetencia eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
									<td><c:out value="${ocorrencia.municipio.nome}"/>-<c:out value="${ocorrencia.municipio.estado.sigla}"/></td>
									<fmt:formatDate value='${ocorrencia.dataAbertura}' type='date' pattern='dd/MM/yyyy HH:mm' var='dataAbertura'/>
									<td><c:out value="${dataAbertura}"/></td>
									<td><c:out value="${ocorrencia.relacao.descricao}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>              
              
              <div class="row">
                <div class="col-12">
                  <h4>
                    <i class="fas fa-female"></i> Dados da Mulher
                  </h4>
                </div>
              </div>
              
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Nome</th>
									<th>Idade</th>
									<th>Estado Civíl</th>
									<th>CPF</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.mulher.nome}"/></td>
									<td><c:out value="${mulherIdade}"/></td>
									<td><c:out value="${ocorrencia.mulher.estadoCivil.descricao}"/></td>
									<td><c:out value="${ocorrencia.mulher.cpf}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>              

              <div class="row">
                <div class="col-12">
                  <h4>
                    <i class="fas fa-male"></i> Dados do Autor Principal
                  </h4>
                </div>
              </div>
              
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Nome</th>
									<th>Idade</th>
									<th>Estado Civíl</th>
									<th>CPF</th>
									<th>Email</th>
									<th>Telefone</th>
									<th>Relação com a Mulher</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.autorPrincipal.nome}"/></td>
									<td><c:out value="${autorPrincipalIdade}"/> anos</td>
									<td><c:out value="${ocorrencia.autorPrincipal.estadoCivil.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.cpf}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.email}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.telefone}"/></td>
									<td><c:out value="${ocorrencia.relacao.descricao}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Possui arma?</th>
									<th>Possui antecedentes criminais?</th>
									<th>Possui histórico de violência com outras pessoas?</th>
									<th>Possui histórico de violência com familiares?</th>
									<th>Possui histórico de violência com filhos?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.autorPrincipal.possuiArma eq true}">SIM</c:when><c:otherwise>NÃO</c:otherwise></c:choose></td>
									<td><c:choose><c:when test="${ocorrencia.autorPrincipal.antecedentesCriminais eq true}">SIM</c:when><c:otherwise>NÃO</c:otherwise></c:choose></td>
									<td><c:choose><c:when test="${ocorrencia.autorPrincipal.violenciaComOutrasPessoas eq true}">SIM</c:when><c:otherwise>NÃO</c:otherwise></c:choose></td>
									<td><c:choose><c:when test="${ocorrencia.autorPrincipal.violenciaComFamiliares eq true}">SIM</c:when><c:otherwise>NÃO</c:otherwise></c:choose></td>
									<td><c:choose><c:when test="${ocorrencia.autorPrincipal.violenciaComFilhos eq true}">SIM</c:when><c:otherwise>NÃO</c:otherwise></c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>				  
				 
				<div class="row">
					<div class="col-12 table-responsive">
					Endereço
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Logradouro</th>
									<th>Complemento</th>
									<th>Bairro</th>
									<th>Município-UF</th>
									<th>CEP</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.autorPrincipal.endereco.logradouro}, ${ocorrencia.autorPrincipal.endereco.numero}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.endereco.complemento}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.endereco.bairro}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.endereco.municipio.nome}-${ocorrencia.autorPrincipal.endereco.municipio.estado.sigla}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.endereco.cep}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>  
				
				<div class="row">
	                <div class="col-12 table-responsive">
	                Condições de Trabalho:
	                  <table class="table table-striped">
	                    <thead>
	                    <tr>
	                      <th>Profissão</th>
	                      <th>Local</th>
	                      <th>Renda</th>
	                      <th>Carteira assinada?</th>
	                      <th>Atuante?</th>
	                      <th>Meses na situação</th>
	                      <th>Telefone/Referência</th>
	                    </tr>
	                    </thead>
	                    <tbody>
	                    
	                    <tr>
	                      <td><c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.profissao}"/></td>
	                      <td><c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.local}"/></td>
	                      <td><c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.renda.descricao}"/></td>
	                      <td>
	                      	<c:choose>
	                      		<c:when test="${autor.condicoesTrabalho.carteiraAssinada}">
	                      			Sim
	                      		</c:when>
	                      		<c:otherwise>
	                      			Não
	                      		</c:otherwise> 
	                      	</c:choose>
	                      </td>
	                      <td>
	         			      	<c:choose>
	                	      	<c:when test="${autor.condicoesTrabalho.atuante}">
	                    	  		Sim
	                      		</c:when>
	                      		<c:otherwise>
	                      			Não
	                      		</c:otherwise> 
	                      	</c:choose>
	      	                      
						</td>
	                      <td><c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.mesesNaSituacao}"/></td>
	                      <td><c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.telefone}"/> / <c:out value="${ocorrencia.autorPrincipal.condicoesTrabalho.referencia}"/></td>
	                    </tr>
		                </tbody>
	                  </table>
	                </div>  
	            </div>		
	            
	            <div class="row">
                
	                <div class="col-4 table-responsive">
	                Dependências Quimicas:
	                  <table class="table table-striped">
	                    <thead>
	                    <tr>
	                      <th>Descricao</th>
	                      <th>Tipo</th>
	                    </tr>
	                    </thead>
	                    <tbody>
						<c:forEach items="${ocorrencia.autorPrincipal.dependenciasQuimicas}" var="dependente">
		                    <tr>
		                      <td><c:out value="${dependente.descricao}"/></td>
		                      <td>
		                      	<c:choose>
		                      		<c:when test="${dependente.ilegal eq true}">Ilegal</c:when>
		                      		<c:otherwise>Legal</c:otherwise>
		                      	</c:choose>
		                      </td>
		                  </tr>
						</c:forEach>
		                </tbody>
	                  </table>
	                </div>
	                <div class="col-4 table-responsive">
	                Deficiências:
	                  <table class="table table-striped">
	                    <thead>
	                    <tr>
	                      <th>Descricao</th>
	                      <th>Tipo</th>
	                    </tr>
	                    </thead>
	                    <tbody>
						<c:forEach items="${ocorrencia.autorPrincipal.deficiencias}" var="dependente">
		                    <tr>
		                      <td><c:out value="${dependente.descricao}"/></td>
		                      <td>
		                      	<c:choose>
		                      		<c:when test="${dependente.intelectual eq true}">Intelectual</c:when>
		                      		<c:otherwise>Física</c:otherwise>
		                      	</c:choose>
		                      </td>
		                  </tr>
						</c:forEach>
		                </tbody>
	                  </table>
	                </div>
				<div class="col-4 table-responsive">
                Patologias:
                  <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Descricao</th>
                    </tr>
                    </thead>
                    <tbody>
					<c:forEach items="${ocorrencia.autorPrincipal.patologias}" var="patologia">
	                    <tr>
	                      <td><c:out value="${patologia.descricao}"/></td>
	                  </tr>
					</c:forEach>
	                </tbody>
                  </table>
                </div>    	                
              </div>
              
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Orientação Sexual</th>
									<th>Religião</th>
									<th>Cor da Pele</th>
									<th>Frequência de Agressão</th>
									<th>Escolaridade</th>
									<th>Renda</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.autorPrincipal.orientacaoSexual.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.religiao.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.cor.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.frequenciaAgressao.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.escolaridade.descricao}"/></td>
									<td><c:out value="${ocorrencia.autorPrincipal.renda.descricao}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>               

              <div class="row">
              	<div class="col-12">
                  <h4>
                    <i class="fas fa-edit"></i> Dados da Violência
                  </h4>
                </div>
              </div>
             <!-- Table row -->
         
				<div class="row">
					<div class="col-6 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Houve feminicídio?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.feminicidio eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose>.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-6 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Local da Agressão</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.localAgressao.descricao}"/>.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>  

           <div class="row">
                <div class="col-6 table-responsive">
                Coautores:
                  <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Nome</th>
                      <th>CPF</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ocorrencia.coautores}" var="autor">
                        <tr>
	                      <td><c:out value="${autor.nome}"/></td>
	                      <td><c:out value="${autor.cpf}"/></td>
	                    </tr>
	                </c:forEach>
	                </tbody>
                  </table>
                </div>
                <!-- /.col -->
                <div class="col-6 table-responsive">
                Objetos utilizados na agressão:
                  <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Descrição</th>
                      <th>Tipo</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ocorrencia.objetosAgressao}" var="objeto">
                        <tr>
	                      <td><c:out value="${objeto.descricao}"/></td>
	                      <td><c:out value="${objeto.tipoObjetoAgressao.descricao}"/></td>
	                    </tr>
	                </c:forEach>
	                </tbody>
                  </table>
                </div>
              </div>
              <!-- /.row -->
                  <c:set var="temp1" value="0"/>
                  <c:set var="temp2" value="0"/>
                  <c:set var="temp3" value="0"/>
                  
				<div class="row">
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Atribuições</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.atribuicoes}" var="item"><c:if test="${temp1==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp1" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Violências Emocionais</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.violenciasEmocionais}" var="item"><c:if test="${temp2==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp2" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Violências Físicas</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.violenciasFisicas}" var="item"><c:if test="${temp3==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp3" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>  				
				  
                  <c:set var="temp1" value="0"/>
                  <c:set var="temp2" value="0"/>
                  <c:set var="temp3" value="0"/>

				<div class="row">
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Violências Patrimonias</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.violenciasPatrimoniais}" var="item"><c:if test="${temp1==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp1" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Violências Sexuais</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.violenciasSexuais}" var="item"><c:if test="${temp2==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp2" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Boletim de Ocorrência</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.boletimOcorrencia}"/>.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row invoice-info">	
                 	<div class="col-sm-12">
						<h4><i class="fas fa-edit"></i> Medidas Cautelares</h4>
                	</div>
               	</div>

				<div class="row">
					<div class="col-3 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Familiares tem conhecimento?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.familiaresConhecimento eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-3 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Informado abrigamento?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.informadoAbrigamento eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-3 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Aceitou abrigamento?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.aceitouAbrigamento eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-3 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Encaminhada por terceiros?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:choose><c:when test="${ocorrencia.encaminhadaPorTerceiros eq true}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row invoice-info">
                 	<div class="col-sm-12">
						<h4><i class="fas fa-edit"></i> Perícia</h4>
                	</div>
               	</div>

				<div class="row">
					<div class="col-6 table-responsive">
						Evolução Psicológica:
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Data de Registro</th>
									<th>Laudo</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ocorrencia.evolucoesPsicologicas}" var="item">
									<tr>
										<fmt:formatDate value='${item.dataRegistro}' type='date' pattern='dd/MM/yyyy' var='dataRegistro'/>
										<td><c:out value="${dataRegistro}" /></td>
										<td><c:out value="${item.laudo}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- /.col -->
					<div class="col-6 table-responsive">
						Prontuários Jurídicos
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Data de Registro</th>
									<th>Laudo</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ocorrencia.prontuariosJuridicos}" var="item">
									<tr>
										<fmt:formatDate value='${item.dataRegistro}' type='date' pattern='dd/MM/yyyy' var='dataRegistro'/>
										<td><c:out value="${dataRegistro}" /></td>
										<td><c:out value="${item.laudo}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
	
				<c:set var="temp1" value="0"/>
	
				<div class="row">
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Orgão Exame Traumatológico</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.orgaoExameTraumatologico.nome}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Orgão Exame Sexológico</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="${ocorrencia.orgaoExameSexologico.nome}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-4 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Cursos de Interesse</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:forEach items="${ocorrencia.cursos}" var="item"><c:if test="${temp1==1}">,&nbsp;</c:if><c:out value="${item.descricao}"/><c:set var="temp1" value="1"/></c:forEach>.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
	
				<div class="row">
					<div class="col-12 table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Relatório do Atendimento</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out escapeXml="false" value="${ocorrencia.relatorioAtendimento}"></c:out></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
					
       
			 <div class="row">
                	<div class="col-6">
                  		<h4>
                    		<i class="fas fa-edit"></i> Confirmo o fornecimento dos dados acima
                  		</h4>
                	</div>
                	<div class="col-6">
                  		<h4>
                    		<i class="fas fa-edit"></i> Confirmo o registro em sistema dos dados acima
                  		</h4>
                	</div>
              </div>       
			  <div class="row">
                	<div class="col-6">
                		Garanhuns, <fmt:formatDate value="${dataAtual}" pattern="dd" /> de <fmt:formatDate value="${dataAtual}" pattern="MMMM" /> de <fmt:formatDate value="${dataAtual}" pattern="yyyy" /><br>
                  		<br><br><h4>___________________________________</h4>                  		
                  		<c:out value="${ocorrencia.mulher.nome}"/> - CPF: <c:out value="${ocorrencia.mulher.cpf}"/>
                	</div>
                	<div class="col-6">
                		Garanhuns, <fmt:formatDate value="${dataAtual}" pattern="dd" /> de <fmt:formatDate value="${dataAtual}" pattern="MMMM" /> de <fmt:formatDate value="${dataAtual}" pattern="yyyy" /><br>
                  		<br><br><h4>___________________________________</h4>                  		
                  		<c:out value="${userLogged.nome}"/> - CPF: <c:out value="${userLogged.cpf}"/>
                	</div>
              </div>

			  <div class="row">
                	<div class="col-12">
                	&nbsp;
                	</div>
              </div>
       
       
              <!-- this row will not appear when printing -->
              <!-- this row will not appear when printing -->
              <div class="row no-print">
                <div class="col-12" align="center">
                  <button onclick="print();" class="btn btn-success"><i class="fas fa-print"></i> Imprimir</button>
                </div>
              </div>
            </div>
            <!-- /.invoice -->
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>



<jsp:include page="../../util/rodape.jsp" />

</body>

</html>
	<!-- Dropdown
    ================================================== -->
<div class="navbar navbar-fixed-top" id="divMenu">
  <div class="navbar-inner">
      <div class="container-fluid">
        <a data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a href="${pageContext.servletConfig.servletContext.contextPath}/restrito" class="brand"><img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/index_icon.png">&nbsp;Neurolaw</a>
        <div class="nav-collapse">
			<ul class="nav">
				<li class="active"><a href="${pageContext.servletConfig.servletContext.contextPath}/restrito">Home</a></li>
				
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Cadastros <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/autor">Autor</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/mulher">Mulher</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/orgao">Orgão</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/usuario">Usuário</a></li>
						<li class="divider"></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/cor">Cor</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/religiao">Religião</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/orientacao-sexual">Orientação Sexual</a></li>
						<li class="divider"></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/beneficio-social">Beneficio Social</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/escolaridade">Escolaridade</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/estado-civil">Estado Civil</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/parentesco">Parentesco</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/relacao">Relação</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/renda">Renda</a></li>						
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/situacao-educacional-dependente">Situação Educacional Dependente</a></li>
						<li class="divider"></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/dependencia-quimica">Dependencia Quimica</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/patologia">Patologia</a></li>
						<li class="divider"></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/atribuicao">Atribuição</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/objeto-agressao">Objeto de Agressão</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/violencia-emocional">Violência Emocional</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/violencia-fisica">Violência Física</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/violencia-patrimonial">Violência Patrimonial</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/violencia-sexual">Violência Sexual</a></li>
						<li class="divider"></li>
						<li><a href="#">Recados</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Ocorrências <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/ocorrencia">Dentro da Competência</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/vendas">Fora da Competência</a></li>
						<li class="divider"></li>
						<li class="dropdown-submenu" data-submenu="dropdown-submenu">
							<a href="#">Chamados</a>
							<ul class="dropdown-menu">
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/compras/pesquisar?dataInicial=&dataFinal=&filialKey=0&fornecedorKey=0&produtoKey=0">Pesquisar</a></li>
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/vendas/pesquisar">Em trâmite</a></li>
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/estoque/fluxo-estoque">Concluídos</a></li>
							</ul>
						</li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Relatórios <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/recebimentos">Análiticos</a></li>
						<li><a href="${pageContext.servletConfig.servletContext.contextPath}/pagamentos">Sintéticos</a></li>
						<li class="divider"></li>
						<li class="dropdown-submenu" data-submenu="dropdown-submenu">
							<a href="#">Outros</a>
							<ul class="dropdown-menu">
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/pagamentos/pesquisar">Chamados Por mulheres</a></li>
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/recebimentos/pesquisar">Chamados por período</a></li>
								<li><a href="${pageContext.servletConfig.servletContext.contextPath}/tesouraria/fluxo-caixa">Chamados por tipos</a></li>
							</ul>
						</li>
					</ul></li>
				
				<!-- 
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Gerenciamento <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">Abrir...</a></li>
						<li class="dropdown-submenu" data-submenu="dropdown-submenu">
							<a href="novo.jsp">Novo</a>
							<ul class="dropdown-menu">
								<li><a href="pdf.jsp">PDF</a></li>

								<li class="dropdown-submenu" data-submenu="dropdown"><a
									href="#">Office</a>
									<ul class="dropdown-menu">
										<li><a href="doc.jsp">Doc</a></li>
										<li><a href="xls.jsp">XLS</a></li>
									</ul></li>

							</ul>
						</li>
						<li><a href="some.jsp">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="#">Separated link</a></li>
					</ul></li> -->
			</ul>
			<ul class="nav pull-right">
				<li id="fat-menu" class="dropdown"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown">
					<img id="btnLogoff" align="left" src='${pageContext.servletConfig.servletContext.contextPath}/assets/img/logoff.png'></a>					
				</li>
			</ul>
			<!-- 
			<ul class="nav pull-right">
				<li id="fat-menu" class="dropdown"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown">
					<img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/perfil.png"></a>
					<ul class="dropdown-menu">
						<li><a href="#">Abrir...</a></li>
						<li class="dropdown-submenu-right" data-submenu="dropdown-submenu-right">
							<a href="novo.jsp">Novo</a>
							<ul class="dropdown-menu">
								<li><a href="pdf.jsp">PDF</a></li>

								<li class="dropdown-submenu-right" data-submenu="dropdown-submenu-right"><a
									href="#">Office</a>
									<ul class="dropdown-menu">
										<li><a href="doc.jsp">Doc</a></li>
										<li><a href="xls.jsp">XLS</a></li>
									</ul></li>

							</ul>
						</li>
						<li><a href="some.jsp">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="#">Separated link</a></li>
					</ul></li>
			</ul>
			 -->
			<!-- 
			<form action="" class="navbar-search pull-left">
				<input type="text" placeholder="Search" class="search-query span2" data-provide="typeahead" data-items="4" data-source='["Abrir","Novo","PDF","DOC","XLS","Action","Separated Link"]'>
			</form> -->
		</div>
		</div>
	</div>
</div>

<div class="modal hide" id="modalLogoff">
	<div class="modal-header">
		<a class="close" data-dismiss="modal">x</a>
		<h3>Confirmação</h3>
	</div>
	<div class="modal-body">
		<p>Deseja realmente efetuar o logoff?</p>
	</div>
	<div class="modal-footer">
		<a href="${pageContext.servletConfig.servletContext.contextPath}/acesso/deslogar" class="btn btn-primary">Confirmar</a> <a href="#"
			class="btn" data-dismiss="modal">Cancelar</a>
	</div>
</div>

<br/><br/><br/>
			<script>
				$(document).ready(function() {
					$('#btnLogoff').click(function() {
						$("#modalLogoff").modal({
							keyboard : false
						});
		
					});
				});
			</script>

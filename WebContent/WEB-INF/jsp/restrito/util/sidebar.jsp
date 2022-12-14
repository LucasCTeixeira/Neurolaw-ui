<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${pageContext.servletConfig.servletContext.contextPath}/" class="brand-link">
      <img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/neurolaw-icon-256.png" alt="Neurolaw Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light"><b>Neurolaw ADM</b></span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="${pageContext.servletConfig.servletContext.contextPath}/assets/img/1.png" class="img-circle elevation-2" alt="${userLogged.login}" title="${userLogged.login}">
        </div>
        <div class="info">
          <font color="#c2c7d0">${userLogged.login}</font>  
          <a href="${pageContext.servletConfig.servletContext.contextPath}/usuario/editar/${userLogged.login}" class="d-block"><i class="fa fa-edit"></i> Editar</a>
          <a href="#" class="d-block" data-toggle="modal" data-target="#modalLogoff"><i class="fa fa-sign-out-alt"></i> Sair</a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        
          <li class="nav-item">
            <a href="${pageContext.servletConfig.servletContext.contextPath}/acordo" class="nav-link">
              <i class="nav-icon fas fa-file"></i>
              <p>
                Acordos
              </p>
            </a>
          </li>
        
        
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-users"></i>
              <p>
                Pessoas
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.servletConfig.servletContext.contextPath}/autor" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Usuários</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.servletConfig.servletContext.contextPath}/mulher" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Empresas</p>
                </a>
              </li>
            </ul>
          </li>


      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>


<!-- Modal -->
<div class="modal fade" id="modalLogoff" tabindex="-1" role="dialog" aria-labelledby="modalLogoffLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLogoffLabel">Sair do sistema</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Deseja realmente efetuar o logoff?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-undo"></i> Cancelar</button>
        <button onclick="location.href='${pageContext.servletConfig.servletContext.contextPath}/acesso/deslogar'" type="button" class="btn btn-primary"><i class="fa fa-check-circle"></i> Confirmar</button>
      </div>
    </div>
  </div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	function removerRegistro(url){
		location.href=url;
	}

	function confirmarExclusao(id, rotulo, url) {
		$("#detalhesConfirmarExclusao").html(rotulo);
		$("#btnConfirmarExclusao").attr("onclick", "javascript:removerRegistro('"+url+"');");
		$("#modalConfirmarExclusao").modal({
			keyboard : false
		});
	}
</script>

<!-- Modal -->
<div class="modal fade" id="modalConfirmarExclusao" tabindex="-1" role="dialog" aria-labelledby="modalLogoffLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLogoffLabel">Confirmação</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Deseja realmente excluir o registro selecionado?
        <div id="detalhesConfirmarExclusao"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-ban"></i> Cancelar</button>
        <button id="btnConfirmarExclusao" type="button" class="btn btn-danger"><i class="fa fa-trash"></i> Confirmar</button>
      </div>
    </div>
  </div>
</div>
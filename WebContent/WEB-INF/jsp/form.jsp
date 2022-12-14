<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" media="screen" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
.custom-combobox {
    position: relative;
    display: inline-block;
  }
  .custom-combobox-toggle {
    position: absolute;
    top: 0;
    bottom: 0;
    margin-left: -1px;
    padding: 0;
  }
  .custom-combobox-input {
    margin: 0;
    padding-top: 2px;
    padding-bottom: 5px;
    padding-right: 5px;
  }
</style>

<script>

	$(function() {
	  $('#datetimepicker1').datetimepicker();
	});
	
	
	$( function() {
	    $.widget( "custom.combobox", {
	      _create: function() {
	        this.wrapper = $( "<span>" )
	          .addClass( "custom-combobox" )
	          .insertAfter( this.element );
	 
	        this.element.hide();
	        this._createAutocomplete();
	        this._createShowAllButton();
	      },
	 
	      _createAutocomplete: function() {
	        var selected = this.element.children( ":selected" ),
	          value = selected.val() ? selected.text() : "";
	 
	        this.input = $( "<input>" )
	          .appendTo( this.wrapper )
	          .val( value )
	          .attr( "title", "" )
	          .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
	          .autocomplete({
	            delay: 0,
	            minLength: 0,
	            source: $.proxy( this, "_source" )
	          })
	          .tooltip({
	            classes: {
	              "ui-tooltip": "ui-state-highlight"
	            }
	          });
	 
	        this._on( this.input, {
	          autocompleteselect: function( event, ui ) {
	            ui.item.option.selected = true;
	            this._trigger( "select", event, {
	              item: ui.item.option
	            });
	          },
	 
	          autocompletechange: "_removeIfInvalid"
	        });
	      },
	 
	      _createShowAllButton: function() {
	        var input = this.input,
	          wasOpen = false
	 
	        $( "<a>" )
	          .attr( "tabIndex", -1 )
	          .attr( "title", "Exibir todos" )
	          .attr( "height", "" )
	          .tooltip()
	          .appendTo( this.wrapper )
	          .button({
	            icons: {
	              primary: "ui-icon-triangle-1-s"
	            },
	            text: "false"
	          })
	          .removeClass( "ui-corner-all" )
	          .addClass( "custom-combobox-toggle ui-corner-right" )
	          .on( "mousedown", function() {
	            wasOpen = input.autocomplete( "widget" ).is( ":visible" );
	          })
	          .on( "click", function() {
	            input.trigger( "focus" );
	 
	            // Close if already visible
	            if ( wasOpen ) {
	              return;
	            }
	 
	            // Pass empty string as value to search for, displaying all results
	            input.autocomplete( "search", "" );
	          });
	      },
	 
	      _source: function( request, response ) {
	        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
	        response( this.element.children( "option" ).map(function() {
	          var text = $( this ).text();
	          if ( this.value && ( !request.term || matcher.test(text) ) )
	            return {
	              label: text,
	              value: text,
	              option: this
	            };
	        }) );
	      },
	 
	      _removeIfInvalid: function( event, ui ) {
	 
	        // Selected an item, nothing to do
	        if ( ui.item ) {
	          return;
	        }
	 
	        // Search for a match (case-insensitive)
	        var value = this.input.val(),
	          valueLowerCase = value.toLowerCase(),
	          valid = false;
	        this.element.children( "option" ).each(function() {
	          if ( $( this ).text().toLowerCase() === valueLowerCase ) {
	            this.selected = valid = true;
	            return false;
	          }
	        });
	 
	        // Found a match, nothing to do
	        if ( valid ) {
	          return;
	        }
	 
	        // Remove invalid value
	        this.input
	          .val( "" )
	          .attr( "title", " Nenhum resultado para (" + value + ")" )
	          .tooltip( "open" );
	        this.element.val( "" );
	        this._delay(function() {
	          this.input.tooltip( "close" ).attr( "title", "" );
	        }, 2500 );
	        this.input.autocomplete( "instance" ).term = "";
	      },
	 
	      _destroy: function() {
	        this.wrapper.remove();
	        this.element.show();
	      }
	    });
	 
	    $( "#combobox" ).combobox();
	    $( "#toggle" ).on( "click", function() {
	      $( "#combobox" ).toggle();
	    });
	  } );
</script>

<center>
<form style="width: 70%" align="left" data-toggle="validator" role="form" name="formExemplo" id="formExemplo" 
	eclass="well form-horizontal">
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="login"><b>Login</b></label>
      <input type="text" class="form-control" name="login" id="login" placeholder="Login" required data-minlength="5" data-error="O campo deve possuir no mínimo 5 caracteres">
      <div class="help-block with-errors">Mínimo de cinco (5) caracteres</div>
    </div>
    <div class="form-group col-md-6">
      <label for="nome"><b>Nome</b></label>
      <input type="text" class="form-control" name="nome" id="nome" placeholder="Nome" required>
      <div class="help-block with-errors"></div>
    </div>
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="senha"><b>Senha</b></label>
      <input type="password" class="form-control" name="senha" id="senha" placeholder="Senha" required>
      <div class="help-block with-errors"></div>
    </div>
    <div class="form-group col-md-6">
      <label for="confirmarSenha"><b>Confirmar Senha</b></label>
      <input type="password" class="form-control" name="confirmarSenha" id="confirmarSenha" placeholder="Confirmar Senha" required data-match="#senha" data-match-error="Campo senha e confirmação devem ser iguais.">
      <div class="help-block with-errors">Campo senha inválido!</div>
    </div>
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="email"><b>Email</b></label>
      <input type="email" class="form-control" name="email" id="email" placeholder="Email" required data-error="Por favor, informe um e-mail correto.">
      <div class="help-block with-errors"></div>
    </div>
    <div class="form-group col-md-6">
      <label for="telefone"><b>Telefone</b></label>
      <input type="text" class="form-control" name="telefone" id="telefone" placeholder="(99) 99999-9999" required>
      <div class="help-block with-errors"></div>
    </div>
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
	   <div class='input-group date' id='datetimepicker1'>
         <label>Data de Nascimento:</label>
         <input type='text' data-date-format="DD-MM-YYYY HH:mm" class="form-control" />
         <span class="input-group-addon">
          <span class="glyphicon glyphicon-calendar"></span>
         </span>
        </div>        
        <div class="help-block with-errors"></div>
    </div>
    <div class="form-group col-md-6">
      	<label for="filial"><b>Filial</b></label>
      	<select id="combobox" required>
          <option></option>
          <option value="Ultrasound Knee Right">Ultrasound Knee Right</option>
          <option value="Ultrasound Knee Left">Ultrasound Knee Left</option>
          <option value="Ultrasound Forearm/Elbow Right">Ultrasound Forearm/  Elbow Right</option>
          <option value="Ultrasound Forearm/Elbow Left">Ultrasound Forearm/Elbow Left</option>
          <option value="MRI Knee Right">MRI Knee Right</option>
          <option value="MRI Knee Left">MRI Knee Left</option>
          <option value="MRI Forearm/Elbow Right">MRI Forearm/Elbow Right</option>
          <option value="MRI Forearm/Elbow Left">MRI Forearm/Elbow Left</option>
          <option value="CT Knee Right">CT Knee Right</option>
          <option value="CT Knee Left">CT Knee Left</option>
          <option value="CT Forearm/Elbow Right">CT Forearm/Elbow Right</option>
          <option value="CT Forearm/Elbow Left">CT Forearm/Elbow Left</option>
    	</select>
    	<div class="help-block with-errors"></div>    	
    </div>    
  </div>
  <center><button type="submit" class="btn btn-primary">CADASTRAR</button></center>
</form>
</center>

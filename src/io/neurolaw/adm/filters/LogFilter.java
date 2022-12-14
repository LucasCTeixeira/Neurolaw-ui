package io.neurolaw.adm.filters;

import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import io.neurolaw.adm.beans.cadastros.UsuarioBean;
import io.neurolaw.adm.controlador.ConceptualAuthControlador;

public class LogFilter implements Filter  {
	private FilterConfig config;
	
	public void  init(FilterConfig config) 
			throws ServletException{
	    this.config = config;		
	}
	
	public void  doFilter(ServletRequest request, 
			ServletResponse response,
			FilterChain chain) 
					throws java.io.IOException, ServletException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;

		String url = httpRequest.getRequestURL().toString();
		
		if (!url.contains(httpRequest.getContextPath() + "/js/") && !url.contains(httpRequest.getContextPath() + "/css/") && !url.contains(httpRequest.getContextPath() + "/img/")){
			HttpSession session = ((HttpServletRequest) request).getSession();		
			
			String ipAddress = request.getRemoteAddr();

			String sessionId = session.getId();
					
			StringBuilder sb = new StringBuilder("Requisi��o realizada. IP: "+ ipAddress + " Data/Hora: "
					+ new Date().toString() + " URL: " + url + " ID da sessão: " + sessionId);
			
			if (session.getAttribute(ConceptualAuthControlador.LOGGED_USER_ATTRIBUTE_SESSION)!=null){
				UsuarioBean usuario = (UsuarioBean)session.getAttribute(ConceptualAuthControlador.LOGGED_USER_ATTRIBUTE_SESSION);
				sb.append(" [Usuário logado: " + usuario.getLogin() + "]");
			}else{
				sb.append(" [Usuário anônimo.]");
			}

		    ServletContext context = config.getServletContext();
		    context.log(sb.toString());			
		}
		chain.doFilter(request,response);
	}

	public void destroy( ){
	}
}
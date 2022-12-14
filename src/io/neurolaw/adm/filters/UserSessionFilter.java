package io.neurolaw.adm.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import io.neurolaw.adm.controlador.ConceptualAuthControlador;

public class UserSessionFilter extends ConceptualFilter implements Filter {

	/** Creates new SessionFilter */
	public UserSessionFilter() {
	}
	// http://projects.spring.io/spring-security/
	// http://wehavescience.com/2013/01/19/utilizando-o-spring-security-3/
	// http://www.guj.com.br/8024-autorizacao-de-acoes-com-spring-security

	public void init(FilterConfig config) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws java.io.IOException, ServletException {

		HttpSession session = ((HttpServletRequest) request).getSession();
		HttpServletRequest httpRequest = (HttpServletRequest)request;

		if (session.getAttribute(ConceptualAuthControlador.LOGGED_USER_ATTRIBUTE_SESSION)==null){
			System.out.println("FILTER DENY");
			returnError(httpRequest, response, "neurolaw.api.msg.error.usuario.unauthenticated");
		}else{
			System.out.println("FILTER ALLOW");
			chain.doFilter(request, response);
		}
	}

	private void returnError(ServletRequest request, ServletResponse response, String msgError)
			throws ServletException, IOException {
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		httpRequest.setAttribute("msg_error", this.getResourceMessage(httpRequest, msgError, null));
		httpRequest.getRequestDispatcher("/").forward(request, response);
	}       

	public void destroy() {
	}
}

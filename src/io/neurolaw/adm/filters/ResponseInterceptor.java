package io.neurolaw.adm.filters;
/*
package io.neurolaw.adm.filters;

import javax.servlet.http.HttpServletResponse;

import br.com.caelum.vraptor.InterceptionException;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.core.InterceptorStack;
import br.com.caelum.vraptor.interceptor.Interceptor;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.resource.ResourceMethod;

@Intercepts
@RequestScoped
public class ResponseInterceptor
    implements Interceptor {

    private final HttpServletResponse response;
	protected static String HEADER_CACHE_CONTROL_DESCRIPTION = "Cache-Control";
	protected static String HEADER_CACHE_CONTROL_VALUE = "no-transform, max-age=1m";


    public ResponseInterceptor(HttpServletResponse response) {
        this.response = response;
    }

    @Override
    public boolean accepts(ResourceMethod method) {
    	//return method.containsAnnotation(Cacheable.class);
    	return true; // allow all requests
    }

    @Override
    public void intercept(InterceptorStack stack, ResourceMethod method,
                Object resourceInstance)
        throws InterceptionException {
    	/*
        // set the expires to past
        response.setHeader("Expires", "Wed, 31 Dec 1969 21:00:00 GMT");

        // no-cache headers for HTTP/1.1
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");

        // no-cache headers for HTTP/1.1 (IE)
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");

        // no-cache headers for HTTP/1.0
        response.setHeader("Pragma", "no-cache");
        */

		/*
    	response.addHeader(HEADER_CACHE_CONTROL_DESCRIPTION, HEADER_CACHE_CONTROL_VALUE);

    	stack.next(method, resourceInstance);
    }
}
*/
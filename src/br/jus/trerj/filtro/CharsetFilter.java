package br.jus.trerj.filtro;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * Servlet Filter implementation class CharsetFilter
 */
@WebFilter("/*")
public class CharsetFilter implements Filter {

	private FilterConfig filterConfig;
	
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }
    
    public void destroy() {
        this.filterConfig = null;
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws UnsupportedEncodingException, IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        chain.doFilter(request, response);
    }

}

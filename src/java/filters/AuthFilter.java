/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filters;

import config.AppConfig;
import entities.User;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author quocb
 */
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String requestPath = req.getServletPath();
        HttpSession session = req.getSession();
        Boolean isLoggedIn = session != null && session.getAttribute(AppConfig.AUTH_USER) != null;
        if (AppConfig.EXCLUDE_ROUTES.indexOf(requestPath) == -1) {
            if (!isLoggedIn) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        } else {
            if (isLoggedIn) {
                res.sendRedirect(req.getContextPath() + "/");
                return;
            }
        }
        
        User user = (User) req.getSession().getAttribute(AppConfig.AUTH_USER);
        Boolean forceUserUpdatePassword = (Boolean)  req.getSession().getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
        if (user!= null && user.getPassword() == null && (forceUserUpdatePassword)) {
              req.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

}

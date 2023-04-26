/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filters;

import config.AppConfig;
import entities.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Pattern;
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

        if (!isLoggedIn && AppConfig.EXCLUDE_ROUTES.indexOf(requestPath) == -1) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        if (isLoggedIn && AppConfig.EXCLUDE_ROUTES.indexOf(requestPath) != -1 && !requestPath.equals("/logout")) {
            res.sendRedirect(req.getContextPath() + "/");
            return;
        }

        User user = (User) req.getSession().getAttribute(AppConfig.AUTH_USER);
        ArrayList<String> permittedPaths = (ArrayList<String>) req.getSession().getAttribute(AppConfig.AUTH_PERMITTED_PATHS);
        Boolean forceUserUpdatePassword = (Boolean) req.getSession().getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
        String pathInfo = req.getRequestURI().replace(req.getContextPath(), "").trim();
        System.out.println("path info " + pathInfo);
        System.out.println("length " + pathInfo.length());
        String formatedPathInfo = (pathInfo.endsWith("/") && pathInfo.length() > 1) ? pathInfo.substring(0, pathInfo.length() - 1) : pathInfo;
        System.out.println("formated " + formatedPathInfo);
        if (user != null && user.getPassword() == null && (forceUserUpdatePassword)) {
            req.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
        }

        if (permittedPaths != null) {
            Boolean inRangePermitted = false;
            for (String path : permittedPaths) {
                String subString = path.length() > 1 && pathInfo.length() > path.length() ? pathInfo.substring(0, path.length()) : pathInfo;
                System.out.println("Substring " + subString);
                System.out.println("path " + path);
                if (path.equals(subString)) {
                    System.out.println("yes.");
                    inRangePermitted = true;
                }
            }
            
            if (AppConfig.EXCLUDE_ROUTES.indexOf(pathInfo) != -1) {
                inRangePermitted = true;
            }

            System.out.println("boolean " + inRangePermitted);
            if (!formatedPathInfo.equals("/404") && !inRangePermitted) {
                res.sendRedirect(req.getContextPath() + "/404");
                return;
            }
        }

        System.out.println("here");
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

}

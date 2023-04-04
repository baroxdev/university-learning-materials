/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.auth;

import actions.IAction;
import config.AppConfig;
import dao.UserDao;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginAction implements IAction {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            request.getRequestDispatcher("/pages/login_step_1.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String username = request.getParameter("studentID");
            System.out.println("username  " + username);
            String password = request.getParameter("password");
            User user = UserDao.getUserById(username);
            System.out.println("user " + user);
            if (user != null) {
                if (user.getPassword() == null) {
                    request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                    request.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
                    response.sendRedirect("./");
                } else {
                    if (password.equals(user.getPassword())) {
                        HttpSession session = request.getSession();
                        session.setAttribute(AppConfig.AUTH_USER, user);
                        if (user.getRoleid().equals("ADM")) {
                            //forward to adminpage
                            request.getRequestDispatcher("/admin_page/index.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/home/index.jsp").forward(request, response);
                        }

                    } else {
                        request.setAttribute("errmessage", "Incorrect email or password.");
                        request.getRequestDispatcher("/views/login_step_2.jsp").forward(request, response);
                    }
                }
            } else {
                request.getRequestDispatcher("/views/login_step_2.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error");
            e.printStackTrace();
        }

    }

}

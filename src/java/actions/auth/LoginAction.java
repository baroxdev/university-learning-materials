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
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

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
            JSONObject json = JsonUtils.getRequestJson(request);
            String username = json.getString("studentID");
            System.out.println("username  " + username);
            Integer step = json.getInt("step");
            User user = UserDao.getUserById(username);
            JSONObject jsonResponse = new JSONObject();
            if (user != null) {
                switch (step) {
                    case 1: {
                        if (user.getPassword() == null) {
                            request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                            request.setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
                            jsonResponse.put("redirectUrl", request.getContextPath() + "/");
                        } else {
                            jsonResponse.put("step", 2);
                        }
                        ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, jsonResponse);

                        break;
                    }
                    case 2: {
                        String password = json.getString("password");
                        if (password != null && password.equals(user.getPassword())) {
                            request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                            if (user.getRoleid().equals("ADM")) {
                                jsonResponse.put("redirectUrl", request.getContextPath() + "/dashboard");
                            } else {
                                jsonResponse.put("redirectUrl", request.getContextPath() + "/");
                            }

                            ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, jsonResponse);
                        } else {
                            jsonResponse.put("message", "Invalid ID or password");
                            ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, jsonResponse);
                        }
                        break;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error");
            e.printStackTrace();
        }
    }
}

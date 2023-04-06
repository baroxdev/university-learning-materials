/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.auth;

import config.AppConfig;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import actions.Action;

/**
 *
 * @author quocb
 */
public class UpdatePasswordAction implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String username = request.getParameter("userId");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        try ( PrintWriter out = response.getWriter()) {
            if (password.equals(confirmPassword)) {
                UserDao.updatePassword(password, username);
                response.setStatus(HttpServletResponse.SC_OK);
                JSONObject successObject = new JSONObject();
                 request.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, false);
                successObject.put("success", "Password updated successfully.");
                out.print(successObject);
                out.flush();
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject errorObject = new JSONObject();
                errorObject.put("error", "Passwords do not match.");
                out.print(errorObject);
                out.flush();
            }
        } catch (Exception e) {
            
            // phan nay lam them, xoa cung dc
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject errorObject = new JSONObject();
            errorObject.put("error", e.getMessage());
            PrintWriter out = response.getWriter();
            out.print(errorObject);
            out.flush();
            //
            
            System.out.println(e.getMessage());
        }
    }
}

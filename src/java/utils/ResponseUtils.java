/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import config.AppConfig;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author quocb
 */
public class ResponseUtils {
    public static void sendJson(HttpServletResponse response, Integer status, JSONObject json) throws IOException {
        if (status >= 400) {
            response.sendError(status, json.toString());
        } else {
            response.setStatus(status);
            
        }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(json);
            response.getWriter().flush();
    }
}

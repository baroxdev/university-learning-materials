/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import config.AppConfig;
import java.io.IOException;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;

/**
 *
 * @author quocb
 */
public class JsonUtils {

    public static JSONObject getRequestJson(HttpServletRequest request) throws IOException {
        String jsonString = request.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(jsonString);
        return json;
    }

    public static JSONObject generateErrorJson(String message) {
        JSONObject resultJson = new JSONObject();
        resultJson.put("message", message);

        return resultJson;
    }
}

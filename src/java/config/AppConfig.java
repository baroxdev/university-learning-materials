/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author quocb
 */
public class AppConfig {
    public final static String AUTH_USER = "USER";
    public final static String AUTH_FORCE_UPDATE_PASSWORD = "FORCE_UPDATE_PASSWORD";
    public final static ArrayList<String> EXCLUDE_ROUTES = new ArrayList(Arrays.asList("/login","/register"));
}

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

//    AUTHENTICATION
    public final static String AUTH_USER = "USER";
    public final static String AUTH_FORCE_UPDATE_PASSWORD = "FORCE_UPDATE_PASSWORD";
    public final static ArrayList<String> EXCLUDE_ROUTES = new ArrayList(Arrays.asList("/login", "/register"));

//    CURRICULUMNS
    public final static String CURRICULUM_ITEM = "CURRICULUMN";
    public final static String CURRICULUM_ROOT_SLUG = "curriculums";

//    PO
    public final static String PO_ITEM = "PO";
    public final static String PO_LIST = "PO_LIST";

//    PLO
    public final static String PLO_ITEM = "PLO";
    public final static String PLO_LIST = "PLO_LIST";

//    SUBJECT
    public final static String SUBJECT_ITEM = "SUBJECT";
    public final static String SUBJECT_LIST = "SUBJECT_LIST";

//    ERRORS
    public final static String ERROR_MESSAGE = "ERROR_MESSAGE";

}

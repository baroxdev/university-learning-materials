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
    public final static ArrayList<String> EXCLUDE_ROUTES = new ArrayList(Arrays.asList("/login", "/register", "/test"));

//    REQUISITE
    public final static String REQUISITE_ITEM = "REQUISITE";

//    SYLLABUS
    public final static String SYLLABUS_ITEM = "SYLLABUS";
    public final static String SYLLABUS_ROOT_SLUG = "syllabus";

//    CURRICULUMNS
    public final static String CURRICULUM_ITEM = "CURRICULUMN";
    public final static String CURRICULUM_ROOT_SLUG = "curriculums";

//    PO
    public final static String PO_ITEM = "PO";
    public final static String PO_LIST = "PO_LIST";

//    PLO
    public final static String PLO_ITEM = "PLO";
    public final static String PLO_LIST = "PLO_LIST";

//    CLO
    public final static String CLO_ITEM = "CLO";
    public final static String CLO_LIST = "CLO_LIST";

//    MATERIALS
    public final static String MATERIALS_ITEM = "MATERIALS";
    public final static String MATERIALS_LIST = "MATERIALS_LIST";

//    SESSION
    public final static String SESSION_ITEM = "SESSION";
    public final static String SESSION_LIST = "SESSION_LIST";

//    SUBJECT
    public final static String SUBJECT_ITEM = "SUBJECT";
    public final static String SUBJECT_LIST = "SUBJECT_LIST";

//    EXPLORE
    public final static String EXPLORE_LIST = "EXPLORE_LIST";

//    Dashboard
    public final static String DASHBOARD_CURRICULUM_LIST = "lsCurriculums";
    public final static String DASHBOARD_SYLLABUS_LIST = "lsSyllabus";

//    ERRORS
    public final static String ERROR_MESSAGE = "ERROR_MESSAGE";
    public final static String PO_ERROR_MESSAGE = "PO_ERROR_MESSAGE";
    public final static String PLO_ERROR_MESSAGE = "PLO_ERROR_MESSAGE";

//    PATHS
    public final static String NOT_FOUND_PAGE = "/pages/not-found.jsp";
}

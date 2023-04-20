/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import dao.SubjectDao;
import entities.Curriculum;
import entities.Subject;
import entities.Syllabus;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

/**
 *
 * @author admin
 */
public class GetListSubjectInSyllabus implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            JSONObject resJson = new JSONObject();
            try {
                String curId = request.getParameter("curId");
                ArrayList<Subject> lsSubjects = (ArrayList<Subject>) SubjectDao.readSubjectList(curId);

                JSONArray results = new JSONArray(lsSubjects);
                resJson.put("data", results);
                ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, resJson);
            } catch (Exception e) {
                e.printStackTrace();
                resJson.put("message", "Cannot get subject list.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            }
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
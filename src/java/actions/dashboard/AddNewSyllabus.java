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
import org.json.JSONObject;
import utils.JsonUtils;

/**
 *
 * @author admin
 */
public class AddNewSyllabus implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            try {
                ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) CurriculumDao.readCurriculumFullList();
                request.setAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST, lsCur);
                request.getRequestDispatcher("/pages/dashboard/addSyllabus.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
            }
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            try {
                JSONObject json = JsonUtils.getRequestJson(request);
                String subjectID = json.getString("subject");
                Integer credit = Integer.valueOf(json.getString("credit"));
                String description = json.getString("description");
                String tasks = json.getString("tasks");
                Integer scoringScale = Integer.valueOf(json.getString("maxScore"));
                Integer minScore = Integer.valueOf(json.getString("minScore"));

                Syllabus syllabus = new Syllabus();
            } catch (Exception e) {
            }
        }
    }
}

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
import dao.SyllabusDao;
import entities.Curriculum;
import entities.Subject;
import entities.Syllabus;
import exceptions.AddNewSyllabusException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

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
            JSONObject resJson = new JSONObject();
            try {
                JSONObject json = JsonUtils.getRequestJson(request);
                String subjectID = json.getString("subject");
                Integer credit = Integer.valueOf(json.getString("credit"));
                String description = json.getString("description");
                String tasks = json.getString("tasks");
                Integer scoringScale = Integer.valueOf(json.getString("maxScore"));
                Integer minScore = Integer.valueOf(json.getString("minScore"));

                Syllabus syllabus = new Syllabus(subjectID, credit, description, tasks, scoringScale, minScore);
                SyllabusDao.create(syllabus);
                resJson.put("message", "Create syllabus successfully.");
                resJson.put("redirectUrl", request.getContextPath() + "/dashboard/syllabus");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, resJson);
            } catch (NumberFormatException numberError) {
                numberError.printStackTrace();
                resJson.put("message", "Invalid format.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (AddNewSyllabusException | SQLException addErr) {
                String errorMessage = addErr.getMessage();
                if (errorMessage.contains("UNIQUE KEY")) {
                    errorMessage = "Syllabus is exist.";
                }

                resJson.put("message", errorMessage);
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (IOException | JSONException e) {
                e.printStackTrace();
                resJson.put("message", "Cannot create new syllabus.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (Exception ex) {
                String errorMessage = ex.getMessage();
                if (errorMessage.contains("UNIQUE KEY")) {
                    errorMessage = "Syllabus are exist.";
                }

                resJson.put("message", errorMessage);
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            }
        }
    }
}

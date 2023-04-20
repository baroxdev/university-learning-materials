/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import entities.Curriculum;
import entities.Objective;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import exceptions.CurriculumException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.jdt.core.compiler.InvalidInputException;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.JsonUtils;

/**
 *
 * @author quocb
 */
public class AddNewCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin_page/curriculum_add.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {

                //nhận data từ form 
                JSONObject json = JsonUtils.getRequestJson(request);
                String curCode = json.getString("code");
                String curName = json.getString("name");
                String curDescription = json.getString("description");
                String curDecisionNo = json.getString("decisionNo");
                String curViName = json.getString("viName");
                JSONArray poArray = json.getJSONArray("poList");
                JSONArray ploArray = json.getJSONArray("ploList");

                //check curCode exist
                if (CurriculumDao.isExist(curCode)) {
                    throw new CurriculumException("Curriculum Code already exist");
                }
                Curriculum cur = new Curriculum();
                cur.setCode(curCode);
                cur.setName(curName);
                cur.setDescription(curDescription);
                cur.setDecisionNo(curDecisionNo);
                cur.setViName(curViName);

                //convert jsonArray to list
                List<ProgramObjective> poList = jsonArrayToList("po", poArray);
                List<ProgramLearningObjective> ploList = jsonArrayToList("plo", ploArray);

                //tạo liên kết với po, plo...
                //thêm vào db
                CurriculumDao.add(cur, poList, ploList);

            } catch (InvalidInputException | IllegalArgumentException ie) {
                ie.printStackTrace();
                request.setAttribute(AppConfig.ERROR_MESSAGE, ie.getMessage());
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher(AppConfig.NOT_FOUND_PAGE).forward(request, response);
            } finally {
                request.getRequestDispatcher("/admin_page/index.jsp").forward(request, response);
            }
        }
    }

    public <T extends Objective> List<T> jsonArrayToList(String id, JSONArray jsonArray) throws Exception {
        List<T> list = new ArrayList<T>();
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                String name = json.getString("name");
                String description = json.getString("description");
                if (id.equals("po")) {
                    ProgramObjective obj = new ProgramObjective();
                    obj.setName(name);
                    obj.setDescription(description);
                    list.add((T) obj);
                } else {
                    ProgramLearningObjective obj = new ProgramLearningObjective();
                    obj.setMapToPO(json.getString("mapToPO"));
                    obj.setName(name);
                    obj.setDescription(description);
                    list.add((T) obj);
                }
            }
        }
        return list;
    }
}

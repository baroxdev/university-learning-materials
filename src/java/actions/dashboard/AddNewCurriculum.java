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
import org.json.JSONArray;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author quocb
 */
public class AddNewCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/dashboard/addCurriculum.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
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
                System.out.println("Origin decision " + curDecisionNo);
                System.out.println("Decision in AddNewCurr...java " + cur.getDecisionNo());
                //convert jsonArray to list
                List<ProgramObjective> poList = jsonArrayToList("po", poArray);
                List<ProgramLearningObjective> ploList = jsonArrayToList("plo", ploArray);

                //tạo liên kết với po, plo...
                //thêm vào db
                System.out.println("Vietnamese name " + curViName);

//                CurriculumDao.add(cur, poList, ploList);
                System.out.println("Do not add to  2");
            } catch (CurriculumException ce) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("message", ce.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, jsonResponse);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
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

    public void doSomething() {
//        InputStream inp = new FileInputStream("workbook.xlsx");
//        Workbook wb = WorkbookFactory.create(inp);
//        Sheet sheet = wb.getSheetAt(0);
//        for (Row row : sheet) {
//            for (Cell cell : row) {
//                System.out.print(cell.getStringCellValue() + " ");
//            }
//            System.out.println();
//        }
    }
}

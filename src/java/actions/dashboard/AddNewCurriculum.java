/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import dao.SubjectDao;
import entities.Curriculum;
import entities.Objective;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import entities.Subject;
import exceptions.CurriculumException;
import exceptions.PLOException;
import exceptions.POException;
import exceptions.SubjectException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
//import org.apache.poi.ss.usermodel.*;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

/**
 *
 * @author quocb
 */
public class AddNewCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
//                JSONObject json = new JSONObject();
                List<Subject> subjList = SubjectDao.readSubjectFullList();
//                json.put("subjList", subjList);
//                ResponseUtils.sendJson(response, HttpServletResponse.SC_FOUND, json);
                request.setAttribute("subjList", subjList);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher(AppConfig.NOT_FOUND_PAGE).forward(request, response);
                return;
            }
            request.getRequestDispatcher("/admin_page/curriculum_add.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {
                request.setCharacterEncoding("UTF-8");
                JSONObject json = JsonUtils.getRequestJson(request);

                //nhận file excel upload và xử lí
//                if (json.getString("op").equalsIgnoreCase("upload")) {
//                    Part filePart = request.getPart("file");
//                    JSONObject jsono = readExcelFile(filePart);
//                    ResponseUtils.sendJson(response, HttpServletResponse.SC_CREATED, jsono);
//                } else if (json.getString("op").equalsIgnoreCase("submit")) {
                //nhận data từ form 
                String curCode = json.getString("code");
                String curName = json.getString("name");
                String curDescription = json.getString("description");
                String curDecisionNo = json.getString("decisionNo");
                String curViName = json.getString("viName");
                JSONArray poArray = json.getJSONArray("poList");
                JSONArray ploArray = json.getJSONArray("ploList");
                JSONArray subjArray = json.getJSONArray("subjList");

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
                List<Subject> subjList = jsonArrayToList("subject", subjArray);

                //tạo liên kết với po, plo...
                //thêm vào db
                CurriculumDao.add(cur, poList, ploList, subjList);
//                }
            } catch (CurriculumException | POException | PLOException | SubjectException ex) {
                ex.printStackTrace();
                JSONObject json = new JSONObject();
                json.put("message", ex.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, json);
            } catch (Exception e) {
                e.printStackTrace();
                JSONObject json = new JSONObject();
                json.put("message", e.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, json);
            }
        }
    }

    public <T> List<T> jsonArrayToList(String id, JSONArray jsonArray) throws Exception {
        List<T> list = new ArrayList<T>();
        if (jsonArray != null) {
            if (id.equals("subject")) {
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject json = jsonArray.getJSONObject(i);
                    Subject obj = new Subject();
                    obj.setId(json.getString("id"));
                    list.add((T) obj);
                }
                return list;
            }

            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                String name = json.getString("name");
                String description = json.getString("description");
                if (id.equals("po")) {
                    ProgramObjective obj = new ProgramObjective();
                    obj.setName(name);
                    obj.setDescription(description);
                    list.add((T) obj);
                } else if (id.equals("plo")) {
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

//    public JSONObject readExcelFile(Part filePart) throws Exception {
//        InputStream inp = filePart.getInputStream();
//        Workbook wb = WorkbookFactory.create(inp);
//        Sheet POSheet = wb.getSheetAt(wb.getSheetIndex("PO"));
//        Sheet PLOSheet = wb.getSheetAt(wb.getSheetIndex("PLO"));
//        JSONObject json = new JSONObject();
//        List<ProgramObjective> poList = new ArrayList<>();
//        List<ProgramLearningObjective> ploList = new ArrayList<>();
//        List<String> temp = null;
//
//        for (Row row : POSheet) {
//            temp = new ArrayList();
//            for (Cell cell : row) {
//                temp.add(cell.getStringCellValue());
//            }
//            ProgramObjective po = new ProgramObjective();
//            po.setName(temp.get(0));
//            po.setDescription(temp.get(1));
//            poList.add(po);
//        }
//        json.put("poList", poList);
//
//        for (Row row : PLOSheet) {
//            temp = new ArrayList();
//            for (Cell cell : row) {
//                temp.add(cell.getStringCellValue());
//            }
//            ProgramLearningObjective plo = new ProgramLearningObjective();
//            plo.setName(temp.get(0));
//            plo.setDescription(temp.get(1));
//            plo.setMapToPO(temp.get(2));
//            ploList.add(plo);
//        }
//        json.put("ploList", ploList);
//
//        return json;
//    }
}
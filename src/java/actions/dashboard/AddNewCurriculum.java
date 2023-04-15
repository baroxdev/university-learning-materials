/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import dao.PLODao;
import dao.PODao;
import entities.Curriculum;
import entities.Objective;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import exceptions.CurriculumException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author quocb
 */
public class AddNewCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {

                //lấy list từ session
                HttpSession session = request.getSession();
                List<Objective> poList = (ArrayList) session.getAttribute("poList");
                List<Objective> ploList = (ArrayList) session.getAttribute("ploList");
                if (poList == null) {
                    poList = new ArrayList<>();
                }
                if (ploList == null) {
                    ploList = new ArrayList<>();
                }
                //thêm obj vào list
                String op = request.getParameter("op");
                String id = request.getParameter("id");
                List<Objective> list = null;
                if (op != null) {
                    switch (op) {
                        case "add":
                            if (id.equals("po")) {
                                ProgramObjective obj = new ProgramObjective();
                                list = new ArrayList(poList);
                                list = addObjInput(list, obj, id, request, response);
                            } else {
                                ProgramLearningObjective obj = new ProgramLearningObjective();
                                obj.setMapToPO(request.getParameter("mapToPO"));
                                list = new ArrayList(ploList);
                                list = addObjInput(list, obj, id, request, response);
                            }
                            session.setAttribute(id + "List", list);
                            break;

                        case "remove":
                            if (id.equals("po")) {
                                list = new ArrayList(poList);
                                list.removeIf(e -> e.getName().equals(request.getParameter("nameToDelete")));
                            } else {
                                list = new ArrayList(ploList);
                                list.removeIf(e -> e.getName().equals(request.getParameter("nameToDelete")));
                            }
                            session.setAttribute(id + "List", list);
                            break;

                        case "edit":
                            String newName = request.getParameter("newName");
                            String newDescription = request.getParameter("newDescription");
                            if (id.equals("po")) {
                                list = new ArrayList(poList);
                            } else {
                                list = new ArrayList(ploList);
                            }

                            list.replaceAll(e -> {
                                if (e.getName().equals(request.getParameter("nameToEdit"))) {
                                    e.setName(newName);
                                }
                                if (e.getDescription().equals(request.getParameter("descriptionToEdit"))) {
                                    e.setDescription(newDescription);
                                }
                                return e;
                            });

                            session.setAttribute(id + "List", list);
                            break;
                    }
                }

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
                //check curCode exist
                String curCode = request.getParameter("code");//lấy từ input(cần sửa)
                if (CurriculumDao.isExist(curCode)) {
                    throw new CurriculumException("Curriculum Code already exist");
                }
                //tạo mới curriculum
                Curriculum cur = new Curriculum();//cần thêm class attributes để tạo curriculum mới
                cur.setCode(curCode);
                cur.setName(request.getParameter("englishName"));//lấy từ input(cần sửa)
                cur.setDescription(request.getParameter("description"));//lấy từ input(cần sửa)
                cur.setDecisionNo(request.getParameter("decisionNo"));//lấy từ input(cần sửa)
                cur.setViName(request.getParameter("vietnameseName"));//lấy từ input(cần sửa)

                //lấy list từ session
                HttpSession session = request.getSession();
                List<ProgramObjective> poList = (ArrayList) session.getAttribute("poList");
                Map<String, ProgramLearningObjective> ploList = (Map) session.getAttribute("ploList");

                //tạo liên kết với po, plo...(??????)
                if (!poList.isEmpty()) {
                    for (ProgramObjective po : poList) {
                        PODao.add(po);
                        PODao.link(cur.getId(), po.getId());
                    }
                }
                if (!ploList.isEmpty()) {
                    for (String key : ploList.keySet()) {
                        PLODao.add(ploList.get(key));
                        PLODao.link(cur.getId(), ploList.get(key).getId());
                        for (ProgramObjective po : poList) {
                            if (ploList.containsKey(po.getName())) {
                                PLODao.linkToPO(po.getId(), ploList.get(key).getId());
                            }
                        }
                    }
                }

                //thêm vào db
                CurriculumDao.add(cur);

                session.removeAttribute("poList");
                session.removeAttribute("ploList");
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher(AppConfig.NOT_FOUND_PAGE).forward(request, response);
                return;
            }
            request.getRequestDispatcher("/admin_page/curriculum_add.jsp").forward(request, response);
        }
    }

    public <T extends Objective> T readObjInput(T obj, String objName, HttpServletRequest request, HttpServletResponse response) {
        obj.setName(request.getParameter(objName + "Name"));
        obj.setDescription(request.getParameter(objName + "Description"));
        return obj;
    }

    public <T extends Objective> List<T> addObjInput(List list, T obj, String objName, HttpServletRequest request, HttpServletResponse response) {
        obj.setName(request.getParameter(objName + "Name"));
        obj.setDescription(request.getParameter(objName + "Description"));
        list.add(obj);
        return list;
    }
}

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
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quocb
 */
public class EditCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String curId = request.getParameter("id");
                //lấy list từ session
                Curriculum cur = CurriculumDao.getCurriculumById(curId);
//                System.out.println("id " + cur.getId());
                request.setAttribute(AppConfig.DASHBOARD_CURRICULUM_TARGET, cur);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher(AppConfig.NOT_FOUND_PAGE).forward(request, response);
                return;
            }
            request.getRequestDispatcher("/pages/dashboard/editCurriculum_1.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Curriculum cur = new Curriculum();
                cur.setId(Integer.parseInt(request.getParameter("id")));
                cur.setName(request.getParameter("englishName"));
                System.out.println("en " + request.getParameter("englishName"));
                System.out.println("vi " + request.getParameter("vietnameseName"));
                cur.setViName(request.getParameter("vietnameseName"));
                Boolean active = false;
                String strActive = request.getParameter("active");
                if (strActive != null && strActive.equals("on")) {
                    active = true;
                }
                cur.setActive(active);
                cur.setCode(request.getParameter("code"));
                cur.setDecisionNo(request.getParameter("decisionNo"));
                cur.setDescription(request.getParameter("description"));
//                CurriculumDao.update(cur);
                response.sendRedirect(request.getContextPath() + "/dashboard/curriculums");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute(AppConfig.ERROR_MESSAGE, "Cannot update curriculum.");
            }
        }
    }

    public <T extends Objective> T readObjInput(T obj, String objName, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter(objName + "Name");
        String description = request.getParameter(objName + "Description");
        if (!name.matches(objName.toUpperCase() + "[\\d]+")) {
            throw new Exception(objName.toUpperCase() + " Name must follow format "
                    + objName.toUpperCase() + "(number)");
        }
        obj.setName(name);
        obj.setDescription(description);
        return obj;
    }

    public <T extends Objective> List<T> addObjInput(List<T> list, T obj, String objName, HttpServletRequest request, HttpServletResponse response) throws Exception {
        obj = readObjInput(obj, objName, request, response);
        for (Objective o : list) {
            if (o.getName().equals(obj.getName())) {
                throw new Exception(objName.toUpperCase() + " already exist.");
            }
        }

        list.add(obj);
        return list;
    }

    public boolean isMapped(String poName, List<ProgramLearningObjective> ploList) {
        return ploList.stream().anyMatch(e -> e.getMapToPO().equals(poName));
    }

    public void addToList(String id, List poList, List ploList, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Objective> list = null;
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
        request.getSession().setAttribute(id + "List", list);
    }

    public void removeFromList(String id, List poList, List ploList, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Objective> list = null;
        if (id.equals("po")) {
            list = new ArrayList(poList);
            if (isMapped(request.getParameter("nameToDelete"), ploList)) {
                throw new IllegalArgumentException("Can't remove already mapped PO.");
            }
        } else if (id.equals("plo")) {
            list = new ArrayList(ploList);
        }
        list.removeIf(e -> e.getName().equals(request.getParameter("nameToDelete")));
        request.getSession().setAttribute(id + "List", list);
    }

    public void editFromList(String id, List poList, List ploList, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Objective> list = null;
        String newName = request.getParameter("newName");
        String newDescription = request.getParameter("newDescription");
        if (id.equals("po")) {
            list = new ArrayList(poList);
            if (isMapped(request.getParameter("nameToEdit"), ploList)) {
                throw new IllegalArgumentException("Can't modify already mapped PO name.");
            }
        } else if (id.equals("plo")) {
            list = new ArrayList(ploList);
        }

        list.replaceAll(e -> {
            if (e.getName().equals(request.getParameter("nameToEdit"))) {
                e.setName(newName);
                e.setDescription(newDescription);
            }
            return e;
        });
        request.getSession().setAttribute(id + "List", list);
    }

}

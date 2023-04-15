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
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.eclipse.jdt.core.compiler.InvalidInputException;

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
                List<ProgramObjective> poList = (ArrayList) session.getAttribute("poList");
                List<ProgramLearningObjective> ploList = (ArrayList) session.getAttribute("ploList");
                if (poList == null) {
                    poList = new ArrayList<>();
                }
                if (ploList == null) {
                    ploList = new ArrayList<>();
                }
                //thêm obj vào list
                String op = request.getParameter("op");
                if (op != null) {
                    String s[] = op.split("_");
                    op = s[0];
                    String id = s[1];
                    switch (op) {
                        case "add":
                            addToList(id, poList, ploList, request, response);
                            break;

                        case "remove":
                            removeFromList(id, poList, ploList, request, response);
                            break;

                        case "edit":
                            editFromList(id, poList, ploList, request, response);
                            break;
                    }
                }
                if (request.getParameter("comfirm") == "yes") {
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

                    //tạo liên kết với po, plo...(??????)
                    //thêm vào db
                    if (!poList.isEmpty()) {
                        for (ProgramObjective po : poList) {
                            PODao.add(po);
                            PODao.link(cur.getId(), po.getId());
                        }
                    } else {
                        throw new IllegalArgumentException("Atleast one PO must be add.");
                    }
                    if (!ploList.isEmpty()) {
                        for (ProgramLearningObjective plo : ploList) {
                            PLODao.add(plo);
                            PLODao.link(cur.getId(), plo.getId());
                            for (ProgramObjective po : poList) {
                                if (plo.getMapToPO().equals(po.getName())) {
                                    PLODao.linkToPO(po.getId(), plo.getId());
                                }
                            }
                        }
                    } else {
                        throw new IllegalArgumentException("Atleast one PLO must be add.");
                    }
                    CurriculumDao.add(cur);

                    session.removeAttribute("poList");
                    session.removeAttribute("ploList");
                }

            } catch (InvalidInputException ie) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, ie.getMessage());
            } catch (IllegalArgumentException ae) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, ae.getMessage());
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

    }

    public <T extends Objective> T readObjInput(T obj, String objName, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter(objName + "Name");
        String description = request.getParameter(objName + "Description");
        if (!name.matches(objName.toUpperCase() + "[\\d]+")) {
            throw new InvalidInputException(objName.toUpperCase() + " Name must follow format "
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
                throw new InvalidInputException(objName.toUpperCase() + " already exist.");
            }
        }

        list.add(obj);
        return list;
    }

    public boolean isMapped(String poName, HttpSession session) {
        List<ProgramLearningObjective> ploList = (ArrayList) session.getAttribute("ploList");
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
            if (isMapped(request.getParameter("nameToDelete"), request.getSession())) {
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
            if (isMapped(request.getParameter("nameToEdit"), request.getSession())) {
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

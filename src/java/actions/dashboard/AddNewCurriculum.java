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
                List<ProgramObjective> poList = (ArrayList) session.getAttribute("poList");
                Map<String, ProgramLearningObjective> ploList = (Map) session.getAttribute("ploList");
                if (poList.isEmpty()) {
                    poList = new ArrayList<>();
                }
                if (ploList.isEmpty()) {
                    ploList = new HashMap<>();
                }
                //thêm obj vào list
                String op = request.getParameter("op");
                if (op != null) {
                    switch (op) {
                        case "addPO":
                            ProgramObjective po = new ProgramObjective();
                            po.setName(request.getParameter("poName"));
                            po.setDescription(request.getParameter("poDescription"));
                            poList.add(po);
                            session.setAttribute("poList", poList);
                            break;
                        case "addPLO":
                            ProgramLearningObjective plo = new ProgramLearningObjective();
                            plo.setName(request.getParameter("ploName"));
                            plo.setDescription(request.getParameter("ploDescription"));
                            ploList.put(request.getParameter("mapToPO"), plo);
                            session.setAttribute("ploList", ploList);
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

}

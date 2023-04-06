/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.curriculumns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import entities.Curriculum;
import java.io.PrintWriter;

/**
 *
 * @author quocb
 */
public class GetCurriculumnByID implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            try {
                String curId = request.getPathInfo();
                curId = curId.replace("/", "");

                Curriculum cur = CurriculumDao.getCurriculumById(curId);
                request.setAttribute(AppConfig.CURRICULUM_ITEM, cur);
            } catch (Exception e) {
                // Set an attribute with key is AppConfig.ERROR_MESSAGE to show in detail.jsp
            }
            request.getRequestDispatcher("/pages/curriculums/detail.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}

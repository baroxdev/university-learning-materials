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
import exceptions.NotFoundException;
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
                
                if (cur == null) throw new NotFoundException("Curriculum is not found!");
                
                request.setAttribute(AppConfig.CURRICULUM_ITEM, cur);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/pages/curriculums/detail.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}

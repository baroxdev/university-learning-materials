/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.DAO;
import dao.RoleDao;
import dao.UserDao;
import entities.Role;
import entities.User;
import filters.accounts.AccountFilter;
import filters.accounts.NameFilter;
import filters.accounts.RoleFilter;
import filters.accounts.StatusFilter;
import utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author admin
 */
public class ViewListAccount implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                List<AccountFilter> filters = new ArrayList<>();

                String role = request.getParameter("role");
                String status = request.getParameter("status");
                String searchQuery = request.getParameter("q");
                String searchType = request.getParameter("search_type");

                if (StringUtils.isNotEmpty(role)) {
                    filters.add(new RoleFilter(role));
                }

                if (StringUtils.isNotEmpty(status) && (status.equals("active") || status.equals("blocked"))) {
                    filters.add(new StatusFilter(status.equals("active")));
                }

                if (StringUtils.isNotEmpty(searchQuery) && StringUtils.isNotEmpty(searchType)) {
                    filters.add(new NameFilter(searchQuery, searchType));
                }

                ArrayList<User> lsAccounts = (ArrayList<User>) UserDao.getAll().stream().filter(account -> filters.stream().allMatch(filter -> filter.matches(account))).collect(Collectors.toList());
                DAO roleDao = new RoleDao();
                ArrayList<Role> lsRoles = roleDao.getAll();
                request.setAttribute(AppConfig.DASHBOARD_ACCOUNT_LIST, lsAccounts);
                request.setAttribute(AppConfig.DASHBOARD_ROLE_LIST, lsRoles);
                request.getRequestDispatcher("/pages/dashboard/viewListAccount.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
            }
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }


}

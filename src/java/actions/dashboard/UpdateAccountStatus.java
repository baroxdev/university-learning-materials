package actions.dashboard;

import actions.Action;
import dao.UserDao;
import exceptions.AccountException;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UpdateAccountStatus implements Action {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            JSONObject responseJSON = new JSONObject();
            Integer responseStatus = null;

            try {
                JSONObject requestJSON = JsonUtils.getRequestJson(request);
                String id = requestJSON.getString("id");
                if (id == null) {
                    throw new AccountException("Cannot update status. ID is required.");
                }
                System.out.println("id " + id);
                Boolean status = requestJSON.getBoolean("status");
                Integer rows = UserDao.updateStatus(id, status);
                if (rows == null || rows == 0) throw new AccountException("Failed to update status. Try again.");
                responseJSON.put("message", "Update status of " + id + " successfully.");
                responseStatus = HttpServletResponse.SC_OK;
            } catch (AccountException accEx) {
                accEx.printStackTrace();
                responseJSON.put("message", accEx.getMessage());
                responseStatus = HttpServletResponse.SC_BAD_REQUEST;
            } catch (Exception e) {
                e.printStackTrace();
                responseJSON.put("message", "Failed to update status. Try again.");
                responseStatus = HttpServletResponse.SC_BAD_REQUEST;
            }

            ResponseUtils.sendJson(response, responseStatus, responseJSON);
        }
    }
}

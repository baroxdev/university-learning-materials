/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.User;
import exceptions.WrongPasswordException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class UserDao {

    public static User getUserById(String id) throws Exception {
        String query = "select id, username, password, fullname, email, educationlevel, roleid from [User] where id = ?";
        User user = null;
        Connection con = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                PreparedStatement pre = con.prepareStatement(query);
                pre.setString(1, id);
                ResultSet rs = pre.executeQuery();
                while (rs.next()) {
                    user = new User();
                    user.setId(rs.getString("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setFullname(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setEducationlevel(rs.getString("educationlevel"));
                    user.setRoleid(rs.getString("roleid"));
                }
                con.close();
            }
        } catch (Exception e) {
            System.out.println("Cannot get User");
            e.printStackTrace();
        }

        return user;
    }

    public static void updatePassword(String password, String id, String currentPassword) throws SQLException, Exception {
    Connection con = null;
    PreparedStatement stm = null;
    try {
        con = DBUtils.makeConnection();
        String query = "UPDATE [user] SET password = ? WHERE id = ? ";
        if (currentPassword != null && !currentPassword.isEmpty()) {
            query += "AND password = ?";
        }
        stm = con.prepareStatement(query);
        stm.setString(1, password);
        stm.setString(2, id);
        if (currentPassword != null && !currentPassword.isEmpty()) {
            stm.setString(3, currentPassword);
        }
        int count = stm.executeUpdate();
        if (count == 0) {
            throw new WrongPasswordException("Wrong password!!!");
        }
    } catch (WrongPasswordException e) {
        throw new SQLException("Wrong password!!!", e);
    } catch (SQLException e) {
        throw e;
    } finally {
        if (con != null) {
            con.close();
        }
    }
}


}

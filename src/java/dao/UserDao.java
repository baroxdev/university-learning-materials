/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
    
    public static void updatePassword(String password, String id){
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement stm = con.prepareStatement("update [user] set password = ? where id = ?");
            stm.setString(1, password);
            stm.setString(2, id);
            int count = stm.executeUpdate();
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.getMessage());
        }
        
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Curriculum;
import exceptions.CurriculumnException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class CurriculumDao {

    //lấy curriculum theo id(curriculum detail)
    public static Curriculum getCurriculumById(String id) throws Exception {
        Curriculum curriculum = null;

        try {
            String query = "select * from Curriculum where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
            }

            con.close();
        } catch (Exception e) {
            throw new CurriculumnException("Something went wrong in get curriculum progress.");
        }
        return curriculum;
    }

    //lấy list curriculum theo code(search by code)
    public static List<Curriculum> readCurriculumListByCode(String code) throws Exception {
        String query = "select * from Curriculum where code like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumnException("Something went wrong in read curriculum progress.");
        }
        return list;
    }

    //lấy list curriculum theo name(search by name)
    public static List<Curriculum> readCurriculumListByName(String name) throws Exception {
        String query = "select * from Curriculum where name like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumnException("Something went wrong in get curriculum progress.");
        }
        return list;
    }
}

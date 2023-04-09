/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Syllabus;
import exceptions.SyllabusException;
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
public class SyllabusDao {

    //lấy syllabus theo id(syllabus detail)
    public static Syllabus getSyllabusById(String id) throws Exception {
        Syllabus syllabus = null;
        try {
            String query = "select * from Syllabus where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
//                syllabus.setName(rs.getString("name"));//thiếu cột name trong tbl Syllabus
                syllabus.setName("Nhat Nam");//thiếu cột name trong tbl Syllabus
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("status"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
            }

            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return syllabus;
    }

    //lấy list syllabus theo subject code(search by code)
    public static List<Syllabus> readSyllabusListByCode(String code) throws Exception {
        String query = "select * from Syllabus where subjectID like ?";
        List<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("stastus"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in read syllabus progress.");
        }
        return list;
    }

    //lấy list syllabus theo subject name(search by name)
    public static List<Syllabus> readSyllabusListByName(String name) throws Exception {
        String query = "select syl.id, syl.name, syl.credit, syl.description, syl.tasks, syl.scoringScale, syl.status, syl.minScore, syl.createdAt, syl.updatedAt, syl.isApproved, syl.subjectID from Syllabus syl join Subject sub on syl.subjectID = sub.id where sub.name like ?";
        List<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("stastus"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }
}

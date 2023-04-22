/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import config.AppConfig;
import entities.SearchResult;
import entities.Syllabus;
import exceptions.AddNewSyllabusException;
import exceptions.SyllabusException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class SyllabusDao {

    public static void create(Syllabus syllabus) throws AddNewSyllabusException, SQLException, Exception {
        String query = "INSERT INTO Syllabus "
                + "(subjectID, credit, [description], tasks, scoringScale, [status], minScore, isApproved, createdAt) "
                + "values(?, ?, ?, ?, ?, 1, ?, 0, GETDATE())";
        Connection con = DBUtils.makeConnection();
        PreparedStatement ppstm = con.prepareCall(query);
        ppstm.setString(1, syllabus.getSubjectID());
        ppstm.setInt(2, syllabus.getCredit());
        ppstm.setString(3, syllabus.getDescription());
        ppstm.setString(4, syllabus.getTasks());
        ppstm.setInt(5, syllabus.getScoringScale());
        ppstm.setInt(6, syllabus.getMinScore());
        int affectedRows = ppstm.executeUpdate();

    }

    //lấy syllabus theo id(syllabus detail)
    public static Syllabus getSyllabusById(String id) throws Exception {
        Syllabus syllabus = null;
        try {
            String query = "select Syl.id, Syl.subjectID, S.name, S.semester, S.slug, Syl.credit, Syl.[description], Syl.[tasks], Syl.scoringScale, Syl.[status], Syl.minScore, Syl.createdAt, Syl.updatedAt, Syl.isApproved from Syllabus as Syl inner join Subject as S on Syl.subjectID = S.id where Syl.id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));//thiếu cột name trong tbl Syllabus
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

    //lấy list syllabus đầy đủ
    public static ArrayList<Syllabus> readSyllabusFullList() throws Exception {
        String query = "select Syl.id, Syl.subjectID, S.name, S.semester, S.slug, Syl.credit, Syl.[description], Syl.[tasks], Syl.scoringScale, Syl.[status], Syl.minScore, Syl.createdAt, Syl.updatedAt, Syl.isApproved from Syllabus as Syl inner join Subject as S on Syl.subjectID = S.id";
        ArrayList<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));//thiếu cột name trong tbl Syllabus
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
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }

    public static List<SearchResult> searchBySubId(String subjectID) throws Exception {
        System.out.println(subjectID);
        String query = "select * from Syllabus where subjectID like ?";
        List<SearchResult> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + subjectID + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                SearchResult searchResult = new SearchResult();
                searchResult.setId(rs.getInt("id"));
                System.out.println("id sy" + rs.getInt("id"));
                // name trong syllus de trong
                searchResult.setName(rs.getString("subjectID"));
                searchResult.setSlug(String.valueOf(rs.getInt("id")));
                searchResult.setRoot_slug(AppConfig.SYLLABUS_ROOT_SLUG);
                list.add(searchResult);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }
}

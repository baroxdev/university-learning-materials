/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Subject;
import exceptions.SubjectException;
import utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author giahu
 */
public class SubjectDao {
    public static Integer create(Subject subject) throws Exception {
        String query = "insert into Subject (id, name, createdAt, semester, slug, viName) values ( ?, ?, cast(GETDATE() as date), ?, ?, ? )";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) throw new SubjectException("Cannot connect to Database now");
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subject.getId());
        ppstm.setString(2, subject.getName());
        ppstm.setString(3, subject.getSemester());
        ppstm.setString(4, subject.getSlug());
        ppstm.setNString(5, subject.getViName());
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add new Subject. Try again.");
        }

        return rows;
    }

    public static Integer createPreRequisiteSubject(Connection cn, String subjectID, String preRequisiteID) throws SubjectException, SQLException {
        if (cn == null) {
            throw new SubjectException("Need to make connection first.");
        }

        String query = "INSERT INTO PreRequisite (subjectID, requisiteSubjectID) VALUES (?, ?);";
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subjectID);
        ppstm.setString(2, preRequisiteID);
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add Prerequisite Subject.");
        }

        return rows;
    }

    public static ArrayList<Subject> readFullList() {
        ArrayList<Subject> result = new ArrayList<>();
        String query = "select id, name, viName, createdAt, updatedAt, semester, slug from Subject";
        try (Connection cn = DBUtils.makeConnection()) {
            Statement stm = cn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                String viName = rs.getNString("viName");
                System.out.println("viName formatted " + viName);
                subject.setViName(viName);
                subject.setSlug(rs.getString("slug"));
                subject.setSemester(rs.getString("semester"));
                subject.setCreatedAt(rs.getString("createdAt"));
                subject.setUpdatedAt(rs.getString("updatedAt"));
                result.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return result;
    }

    //lấy subject theo id (subject detail)
    public static Subject getSubjectById(String id) throws Exception {
        String query = "select S.id, name, createdAt, updatedAt, semester, slug, requisiteSubjectID as requisiteSubject" +
                " from Subject S inner join PreRequisite PR on S.id = PR.subjectID where id = ?";
        Subject subject = null;
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getString("createdAt"));
                subject.setUpdatedAt(rs.getString("updatedAt"));
                subject.setPreRequisite(rs.getString("requisiteSubject"));
                subject.setSemester(rs.getString("semester"));
            }
            con.close();
        } catch (Exception e) {
            throw new SubjectException("Something went wrong in get subject progress.");
        }
        return subject;
    }

    //lấy list môn theo curriculumId
    //cần junction table giữa Subject và Curiculum để chạy
    public static List<Subject> readSubjectList(String curId) throws Exception {
        String query = "select distinct [id], [name], [createdAt], [updatedAt], [semester], slug from Subject join Curr_to_Subject on id = subjectID where curriculumID = ?";
        List<Subject> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getDate("createdAt").toString());
                subject.setUpdatedAt(rs.getDate("updatedAt") != null ? rs.getDate("updatedAt").toString() : null);
                subject.setSemester(rs.getString("semester"));
                subject.setSlug(rs.getString("slug"));
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    //lấy list môn theo curriculumId và khối ngành? và cả plo? 
    //cần junction table giữa Subject và PLO
    public static List<Subject> readSubjectList(String curId, String KCId) throws Exception {
        String query = "select * from subject join ... on id = sub_id where cur_id = ? and knowlegdeCategoryID = ?";//cái nay chưa có trong db nên để tạm
        List<Subject> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            pre.setString(2, KCId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getDate("createdAt").toString());
                subject.setUpdatedAt(rs.getDate("updatedAt").toString());
                subject.setPreRequisite(rs.getString("preRequisite"));
                subject.setSemester(rs.getString("semester"));
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    public static Boolean isExist(String id) throws Exception {
        Boolean isExist = false;
        String query = "select * from Subject where id = ?";

        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            System.out.println("Result " + rs);
            if (rs.next()) {
                isExist = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return isExist;
    }
}

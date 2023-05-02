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
import java.util.Collections;
import java.util.List;

/**
 * @author giahu
 */
public class SubjectDao {
    public static Integer create(Subject subject) throws Exception {
        String query = "insert into Subject (id, name, createdAt, semester, slug, viName) values ( ?, ?, SYSDATETIME(), ?, ?, ? )";
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
        String query = "select * from Subject ORDER BY CONVERT(DATE, createdAt) desc, CONVERT(DATE, updatedAt) desc";
        try (Connection cn = DBUtils.makeConnection()) {
            Statement stm = cn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            while (rs.next()) {
                Subject subject = getSubject(rs);
                result.add(subject);
            }

            Collections.sort(result, (Subject o1, Subject o2) -> {
                if (o1.getUpdatedAt() != null && o2.getUpdatedAt() != null) {
                    return o2.getUpdatedAt().compareTo(o1.getUpdatedAt());
                } else if (o1.getUpdatedAt() != null && o2.getUpdatedAt() == null) {
                    return o2.getCreatedAt().compareTo(o1.getUpdatedAt());
                } else if (o1.getUpdatedAt() == null && o2.getUpdatedAt() != null) {
                    return o2.getUpdatedAt().compareTo(o1.getCreatedAt());
                } else {
                    return o2.getCreatedAt().compareTo(o1.getCreatedAt());
                }
            });
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
        String query = "select * from Subject where id = ?";
        Subject subject = null;
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                subject = getSubject(rs);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in get subject progress.");
        }
        return subject;
    }

    //lấy list môn theo curriculumId
    //cần junction table giữa Subject và Curiculum để chạy
    public static List<Subject> readSubjectList(String curId) throws Exception {
        String query = "select distinct [id], [name], [createdAt], [updatedAt], [semester], slug from Subject" +
                " join Curr_to_Subject on id = subjectID where curriculumID = ?" +
                " ORDER BY CONVERT(DATE, createdAt) desc, CONVERT(DATE, updatedAt) desc";
        List<Subject> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = getSubject(rs);
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    private static Subject getSubject(ResultSet rs) throws SQLException {
        Subject subject = new Subject();
        subject.setId(rs.getString("id"));
        subject.setName(rs.getString("name"));
        subject.setViName(rs.getNString("viName"));
        subject.setCreatedAt(rs.getDate("createdAt"));
        subject.setUpdatedAt(rs.getDate("updatedAt") != null ? rs.getDate("updatedAt") : null);
        subject.setSemester(rs.getString("semester"));
        subject.setSlug(rs.getString("slug"));
        subject.setActive(rs.getBoolean("active"));
        return subject;
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
                Subject subject = getSubject(rs);
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    public static Integer update(Subject subject) throws Exception {
        String query = "update Subject set name = ?, viName = ?, updatedAt = GETDATE(), semester = ?, slug = ?, active = ? where id = ?";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) throw new SubjectException("Cannot connect to Database now");
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subject.getName());
        ppstm.setNString(2, subject.getViName());
        ppstm.setString(3, subject.getSemester());
        ppstm.setString(4, subject.getSlug());
        ppstm.setBoolean(5, subject.getActive());
        ppstm.setString(6, subject.getId());
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add new Subject. Try again.");
        }

        return rows;
    }

    public static Integer updateStatus(String subjectId, Boolean isActive) throws Exception {
        String query = "update Subject set active = ?, updatedAt = GETDATE() where id = ?";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) throw new SubjectException("Cannot connect to Database now");
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setBoolean(1, isActive);
        ppstm.setString(2, subjectId);
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to update Subject status. Try again.");
        }

        return rows;
    }

    public static Boolean isExist(String id) throws Exception {
        Boolean isExist = false;
        String query = "select * from Subject where id = ?";

        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
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

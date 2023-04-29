/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Subject;
import exceptions.SubjectException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class SubjectDao {

    public static Integer create(Subject subject) throws Exception {
        String query = "insert into Subject (id, name, createdAt, semester, slug, viName) values ( ?, ?, cast(GETDATE() as date), ?, ?, ? )";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) {
            throw new SubjectException("Cannot connect to Database now");
        }
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subject.getId());
        ppstm.setString(2, subject.getName());
        ppstm.setInt(3, subject.getSemester());
        ppstm.setString(4, subject.getSlug());
        ppstm.setNString(5, subject.getViName());
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add new Subject. Try again.");
        }

        return rows;
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
                subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getString("createdAt"));
                subject.setUpdatedAt(rs.getString("updatedAt"));
                subject.setSemester(rs.getInt("semester"));
                subject.setSlug(rs.getString("slug"));
                subject.setViName(rs.getNString("viName"));
                subject.setCredit(rs.getInt("credit"));
            }
            con.close();
        } catch (Exception e) {
            throw new SubjectException("Something went wrong in get subject progress.");
        }
        return subject;
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
                subject.setSemester(rs.getInt("semester"));
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

    public static List<Subject> readSubjectFullList() throws Exception {
        String query = "select * from Subject";
        List<Subject> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getString("createdAt"));
                subject.setUpdatedAt(rs.getString("updatedAt"));
                subject.setSemester(rs.getInt("semester"));
                subject.setSlug(rs.getString("slug"));
                subject.setViName(rs.getNString("viName"));
                subject.setCredit(rs.getInt("credit"));
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            throw new SubjectException("Something went wrong in get subject progress.");
        }
        return list;
    }

    //lấy list môn theo curriculumId
    public static List<Subject> readSubjectList(String curId) throws Exception {
        String query = "select distinct [id], [name], [createdAt], [updatedAt], [semester], [slug], [viName], [credit] from Subject join Curr_to_Subject on id = subjectID where curriculumID = ?";
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
                subject.setCreatedAt(rs.getString("createdAt"));
                subject.setUpdatedAt(rs.getString("updatedAt"));
                subject.setSemester(rs.getInt("semester"));
                subject.setSlug(rs.getString("slug"));
                subject.setViName(rs.getNString("viName"));
                subject.setCredit(rs.getInt("credit"));
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    //link curriculum to subject
    public static void link(Connection con, int curId, String subjId) throws Exception {
        String query = "insert Curr_to_Subject values(?,?)";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setInt(1, curId);
        pre.setString(2, subjId);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Link curriculum to Subject failed, no rows affected.");
        }
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

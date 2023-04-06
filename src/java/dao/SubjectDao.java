/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Subject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class SubjectDao {
    //lấy subject theo id (subject detail)
    public static Subject getSubjectById(String id) throws Exception {
        String query = "select * from Subject where id = '?'";
        Subject subject = null;
        Connection con = DBUtils.makeConnection();
        try {
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getDate("createdAt").toString());
                subject.setUpdatedAt(rs.getDate("updatedAt").toString());
                subject.setPreRequisite(rs.getString("preRequisite"));//mục này chưa có trong db
                subject.setSemester(rs.getInt("semester"));
                subject.setCredit(rs.getInt("credit"));
                subject.setKnowlegdeCategoryID(rs.getInt("knowlegdeCategoryID"));//đây cũng vậy
            }
        } catch (Exception e) {
            System.out.println("Cant get subject");
        }
        con.close();
        return subject;
    }
    //lấy list môn theo curriculumId
    public static List<Subject> readSubjectList(String curId) throws Exception {
        String query = "select distinct [id], [name], [createdAt], [updatedAt], [preRequisite], [semester], [credit], [knowlegdeCategoryID] from Subject join Subject_to_Cur on id = sub_ID where cur_ID = '?'";
        List<Subject> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setId(rs.getString("id"));
                subject.setName(rs.getString("name"));
                subject.setCreatedAt(rs.getDate("createdAt").toString());
                subject.setUpdatedAt(rs.getDate("updatedAt").toString());
                subject.setPreRequisite(rs.getString("preRequisite"));
                subject.setSemester(rs.getInt("semester"));
                subject.setCredit(rs.getInt("credit"));
                subject.setKnowlegdeCategoryID(rs.getInt("knowlegdeCategoryID"));
                list.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Cant get list");
        }
        con.close();
        return list;
    }
    //lấy list môn theo curriculumId và khối ngành? và cả plo? 
    public static List<Subject> readSubjectList(String curId, String KCId) throws Exception {
        String query = "select * from subject join ... on id = sub_id where cur_id = ? and knowlegdeCategoryID = ?";//cái nay chưa có trong db nên để tạm
        List<Subject> list = null;
        Connection con = DBUtils.makeConnection();
        try {
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
                subject.setSemester(rs.getInt("semester"));
                subject.setCredit(rs.getInt("credit"));
                subject.setKnowlegdeCategoryID(rs.getInt("knowlegdeCategoryID"));
                list.add(subject);
            }
        } catch (Exception e) {
            System.out.println("Cant get list");
        }
        con.close();
        return list;
    }
}

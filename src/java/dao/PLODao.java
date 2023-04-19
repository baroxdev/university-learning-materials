/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.ProgramLearningObjective;
import exceptions.PLOException;
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
public class PLODao {

    //lấy plo theo id (ko chắc có dùng ko :v)
    public static ProgramLearningObjective getPLOById(String id) throws Exception {
        String query = "select * from Program_Learning_Objective where id = ?";
        ProgramLearningObjective plo = null;
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                plo = new ProgramLearningObjective();
                plo.setId(rs.getInt("id"));
                plo.setName(rs.getString("name"));
                plo.setDescription(rs.getString("description"));
                plo.setCreatedAt(rs.getString("createdAt"));
                plo.setUpdatedAt(rs.getString("updatedAt"));
            }
            con.close();
        } catch (Exception e) {
            throw new PLOException("Something went wrong in get plo progress.");
        }
        return plo;
    }

    //lấy list plo theo curriculumID
    public static List<ProgramLearningObjective> readPLOList(String curId) throws Exception {
        String query = "select distinct [id], [name], [description], [createdAt], [updatedAt] from Program_Learning_Objective join Curr_to_PLO on id = PLO_ID where curriculumID = ?";
        List<ProgramLearningObjective> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ProgramLearningObjective plo = new ProgramLearningObjective();
                plo.setId(rs.getInt("id"));
                plo.setName(rs.getString("name"));
                plo.setDescription(rs.getString("description"));
                plo.setCreatedAt(rs.getString("createdAt"));
                plo.setUpdatedAt(rs.getString("updatedAt"));
                list.add(plo);
            }
            con.close();
        } catch (Exception e) {
            throw new PLOException("Something went wrong in read plo progress.");
        }
        return list;
    }

    //link curriculum to plo
    public static void link(Connection con, int curId, int PLO_ID) throws Exception {
        String query = "insert Curr_to_PLO values(?,?)";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setInt(1, curId);
        pre.setInt(2, PLO_ID);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Link curriculum to PLO failed, no rows affected.");
        }
    }

    //link po to plo
    public static void linkToPO(Connection con, int PO_ID, int PLO_ID) throws Exception {
        String query = "insert PO_to_PLO values(?,?)";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setInt(1, PO_ID);
        pre.setInt(2, PLO_ID);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Link curriculum to PLO failed, no rows affected.");
        }
    }

    //Add new plo to db
    public static Integer add(Connection con, ProgramLearningObjective plo) throws Exception {
        Integer id = -1;
        String query = "insert Program_Learning_Objective values(?,?,GETDATE(),?)";
        PreparedStatement pre = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        pre.setString(1, plo.getName());
        pre.setString(2, plo.getDescription());
        pre.setString(3, null);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Add PLO failed, no rows affected.");
        }
        ResultSet generatedId = pre.getGeneratedKeys();
        if (generatedId.next()) {
            id = generatedId.getInt(1);
        } else {
            throw new SQLException("Inserting PLO failed, no ID obtained.");
        }
        return id;
    }
}

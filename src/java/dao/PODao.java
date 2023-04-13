/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.ProgramObjective;
import exceptions.POException;
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
public class PODao {

    //lấy list po theo curriculumID
    public static List<ProgramObjective> readPOList(String curId) throws Exception {
        String query = "select distinct [id], [name], [description], [createdAt], [updatedAt] from Program_Objective join Curr_to_PO on id = PO_ID where curriculumID = ?";
        List<ProgramObjective> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ProgramObjective po = new ProgramObjective();
                po.setId(rs.getInt("id"));
                po.setName(rs.getString("name"));
                po.setDescription(rs.getString("description"));
                po.setCreatedAt(rs.getString("createdAt"));
                po.setUpdatedAt(rs.getString("updatedAt"));
                list.add(po);
            }
            con.close();
        } catch (Exception e) {
            throw new POException("Something went wrong in get po progress.");
        }
        return list;
    }

    //link curriculum to po
    public static void link(int curId, int PO_ID) throws Exception {
        try {
            String query = "insert Curr_to_PO values(?,?)";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setInt(1, curId);
            pre.setInt(2, PO_ID);

            pre.executeUpdate();
            con.close();
        } catch (Exception e) {
            throw new POException("Something went wrong in link curriculum to po progress.");
        }
    }

    //Add new po to db
    public static void add(ProgramObjective po) throws Exception {
        try {
            String query = "insert Program_Objective values(?,?,GETDATE(),?)";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, po.getName());
            pre.setString(2, po.getDescription());
            pre.setString(3, null);

            pre.executeUpdate();
            con.close();
        } catch (Exception e) {
            throw new POException("Something went wrong in add po progress.");
        }
    }
}

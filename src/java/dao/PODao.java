/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.ProgramLearningObjective;
import entities.ProgramObjective;
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
    public static List<ProgramObjective> readPOListByCurId(String curId) throws Exception {
        String query = "select distinct [id], [name], [description], [createdAt], [updatedAt] from Program_Objective join Curr_to_PO on id = PO_ID where curriculumID = ?";
        List<ProgramObjective> list = new ArrayList<>();
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
        return list;
    }
}

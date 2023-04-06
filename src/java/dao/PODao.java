/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.PLO;
import entities.PO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class PODao {
    //lấy list po theo curriculumID
    public static List<PO> readPOListByCurId(String curId) throws Exception {
        String query = "select distinct [id], [name], [description], [createdAt], [updatedAt] from Program_Objective join Curr_to_PO on id = PO_ID where curriculumID = '?'";
        List<PO> list = null;
        Connection con = DBUtils.makeConnection();

        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, curId);
        ResultSet rs = pre.executeQuery();
        while (rs.next()) {
            PO po = new PO();
            po.setId(rs.getInt("id"));
            po.setName(rs.getString("name"));
            po.setDescription(rs.getString("description"));
            po.setCreatedAt(rs.getDate("createdAt").toString());
            po.setUpdatedAt(rs.getDate("updatedAt").toString());
            list.add(po);
        }

        con.close();
        return list;
    }
}

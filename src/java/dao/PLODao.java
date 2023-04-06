/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.PLO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class PLODao {

    //lấy plo theo id (ko chắc có dùng ko :v)
    public static PLO getPLOById(String id) throws Exception {
        String query = "select * from Program_Learning_Objective where id = '?'";
        PLO plo = null;
        Connection con = DBUtils.makeConnection();

        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, id);
        ResultSet rs = pre.executeQuery();
        while (rs.next()) {
            plo = new PLO();
            plo.setId(rs.getInt("id"));
            plo.setName(rs.getString("name"));
            plo.setDescription(rs.getString("description"));
            plo.setCreatedAt(rs.getDate("createdAt").toString());
            plo.setUpdatedAt(rs.getDate("updatedAt").toString());
        }

        con.close();
        return plo;
    }

    //lấy list plo theo curriculumID
    public static List<PLO> readPLOList(String curId) throws Exception {
        String query = "select distinct [id], [name], [description], [createdAt], [updatedAt] from Program_Learning_Objective inner join CLO_to_PLO_from_Cur on id = PLO_ID where curriculumID = '?'";
        List<PLO> list = null;
        Connection con = DBUtils.makeConnection();

        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, curId);
        ResultSet rs = pre.executeQuery();
        while (rs.next()) {
            PLO plo = new PLO();
            plo.setId(rs.getInt("id"));
            plo.setName(rs.getString("name"));
            plo.setDescription(rs.getString("description"));
            plo.setCreatedAt(rs.getDate("createdAt").toString());
            plo.setUpdatedAt(rs.getDate("updatedAt").toString());
            list.add(plo);
        }

        con.close();
        return list;
    }

}

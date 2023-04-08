/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Material;
import exceptions.MaterialException;
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
public class MaterialDao {

    //lấy list material theo syllabusID
    public static List<Material> readMaterialListBySylId(String curId) throws Exception {
        String query = "select * from Material where syllabusID = ?";
        List<Material> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Material material = new Material();
                material.setId(rs.getInt("id"));
                material.setName(rs.getString("name"));
                material.setMaterialUri(rs.getString("materialUri"));
                material.setSyllabusID(rs.getInt("syllabusID"));
                list.add(material);
            }
            con.close();
        } catch (Exception e) {
            throw new MaterialException("Something went wrong in get material progress.");
        }
        return list;
    }
}

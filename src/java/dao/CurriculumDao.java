/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import config.AppConfig;
import entities.Curriculum;
import entities.SearchResult;
import exceptions.CurriculumException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class CurriculumDao {

    //lấy curriculum theo id(curriculum detail)
    public static Curriculum getCurriculumById(String id) throws Exception {
        Curriculum curriculum = null;

        try {
            String query = "select * from Curriculum where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
            }

            con.close();
        } catch (SQLException se) {
            return null;
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return curriculum;
    }

    //lấy list curriculum theo code(search by code)
    public static List<Curriculum> readCurriculumListByCode(String code) throws Exception {
        String query = "select * from Curriculum where code like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in read curriculum progress.");
        }
        return list;
    }

    //Get list curriculum by name(search by name)
    public static List<Curriculum> readCurriculumListByName(String name) throws Exception {
        String query = "select * from Curriculum where name like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    //Get full list curriculum
    public static List<Curriculum> readCurriculumFullList() throws Exception {
        String query = "select * from Curriculum";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    public static List<SearchResult> searchByName(String name) throws Exception {
        String query = "select * from Curriculum where name like ?";
        List<SearchResult> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                SearchResult searchResult = new SearchResult();
                searchResult.setId(rs.getInt("id"));
                System.out.println("id " + rs.getInt("id"));
                searchResult.setName(rs.getString("name"));
                searchResult.setSlug(String.valueOf(rs.getInt("id")));
                searchResult.setRoot_slug(AppConfig.CURRICULUM_ROOT_SLUG);
                list.add(searchResult);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    //Add new curriculum to db
    public static void add(Curriculum curriculum) throws Exception {
        try {
            String query = "insert Curriculum values(?,?,?,?,?,GETDATE(),?)";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curriculum.getCode());
            pre.setString(2, curriculum.getName());
            pre.setString(3, curriculum.getDescription());
            pre.setString(4, curriculum.getDecisionNo());
            pre.setString(5, curriculum.getViName());
            pre.setString(6, null);

            pre.executeUpdate();
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in add curriculum progress.");
        }
    }

    //Update existing curiculum in db
    public static void update(Curriculum curriculum) throws Exception {
        try {
            String query = "update Curriculum set code = ?, name = ?, description = ?, decisionNo = ?, viName = ?, updateAt = GETDATE() where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curriculum.getCode());
            pre.setString(2, curriculum.getName());
            pre.setString(3, curriculum.getDescription());
            pre.setString(4, curriculum.getDecisionNo());
            pre.setString(5, curriculum.getViName());
            pre.setInt(6, curriculum.getId());

            pre.executeUpdate();
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in update curriculum progress.");
        }
    }

    //check exist code
    public static boolean isExist(String curCode) throws Exception {
        try {
            String query = "select * from Curriculum where upper(code) = upper(?)";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curCode);
            ResultSet rs = pre.executeQuery();

            con.close();

            return !rs.wasNull();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
    }
}

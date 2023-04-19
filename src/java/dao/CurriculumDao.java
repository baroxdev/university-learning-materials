/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import config.AppConfig;
import entities.Curriculum;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import entities.SearchResult;
import exceptions.CurriculumException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.jdt.core.compiler.InvalidInputException;
import utils.DBUtils;
import utils.DataUtils;

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
                System.out.println("AFter convert " + DataUtils.getBoolean(rs.getInt("active")));
                curriculum.setActive(DataUtils.getBoolean(rs.getInt("active")));
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
        String query = "select * from Curriculum where active = 1";
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
                curriculum.setActive(DataUtils.getBoolean(rs.getInt("active")));
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

    //Add new curriculum(+po,plo) to db
    public static Integer add(Curriculum curriculum, List<ProgramObjective> poList, List<ProgramLearningObjective> ploList) throws Exception {
        Connection con = null;
        Integer curId = null;
        Integer poId = null;
        Integer ploId = null;
        try {
            con = DBUtils.makeConnection();
            con.setAutoCommit(false);

            if (poList.isEmpty()) {
                throw new IllegalArgumentException("Atleast one PO must be add.");
            }
            if (ploList.isEmpty()) {
                throw new IllegalArgumentException("Atleast one PLO must be add.");
            }

            curId = add(con, curriculum);

            for (ProgramObjective po : poList) {
                poId = PODao.add(con, po);
                PODao.link(con, curId, poId);
            }
            for (ProgramLearningObjective plo : ploList) {
                ploId = PLODao.add(con, plo);
                PLODao.link(con, curId, ploId);
                for (ProgramObjective po : poList) {
                    if (plo.getMapToPO().equals(po.getName())) {
                        PLODao.linkToPO(con, poId, ploId);
                    }
                }
            }

            con.commit();
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return curId;
    }

    //Add new curriculum to db
    public static Integer add(Connection con, Curriculum curriculum) throws Exception {
        Integer id = -1;
        String query = "insert Curriculum values(?,?,?,?,?,cast(GETDATE() as date),?,?)";
        PreparedStatement pre = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        pre.setString(1, curriculum.getCode());
        pre.setString(2, curriculum.getViName());
        pre.setString(3, curriculum.getName());
        pre.setString(4, curriculum.getDescription());
        pre.setString(5, curriculum.getDecisionNo());
        pre.setString(6, null);
        pre.setBoolean(7, true);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Add curriculum failed, no rows affected.");
        }
        ResultSet generatedCurId = pre.getGeneratedKeys();
        if (generatedCurId.next()) {
            id = generatedCurId.getInt(1);
        } else {
            throw new SQLException("Inserting curriculum failed, no ID obtained.");
        }
        return id;
    }

    //Update existing curiculum in db
    public static void update(Curriculum curriculum) throws Exception {
        try {
            String query = "update Curriculum set code = ?, viName = ?, name = ?, description = ?, decisionNo = ?, active = ?, updatedAt = cast(GETDATE() as date) where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curriculum.getCode());
            pre.setNString(2, curriculum.getViName());
            pre.setString(3, curriculum.getName());
            pre.setString(4, curriculum.getDescription());
            pre.setNString(5, curriculum.getDecisionNo());
            pre.setInt(6, DataUtils.getInteger(curriculum.getActive()));
            pre.setInt(7, curriculum.getId());
            System.out.println("after convert in dao " + DataUtils.getInteger(curriculum.getActive()));

            pre.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
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
            boolean isExist = rs.wasNull();

            con.close();
            return isExist;
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
    }
}

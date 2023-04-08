/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Assessment;
import exceptions.AssessmentException;
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
public class AssessmentDao {

    //lấy list assessment theo syllabusID
    public static List<Assessment> readAssessmentListBySylId(String curId) throws Exception {
        String query = "select * from Assessment where syllabusID = ?";
        List<Assessment> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assessment assessment = new Assessment();
                assessment.setId(rs.getInt("id"));
                assessment.setName(rs.getString("name"));
                assessment.setType(rs.getString("type"));
                assessment.setPart(rs.getInt("part"));
                assessment.setWeight(rs.getDouble("weight"));
                assessment.setCompletionCriteria(rs.getString("completionCriteria"));
                assessment.setDuration(rs.getString("duration"));
                assessment.setCLO_ID(rs.getInt("CLO_ID"));
                assessment.setQuestionType(rs.getString("questionType"));
                assessment.setNumberOfQuestion(rs.getString("numbeOfQuestion"));
                assessment.setKnowledgeScope(rs.getString("knowledgeScope"));
                assessment.setGradingGuide(rs.getString("gradingGuide"));
                assessment.setNote(rs.getString("note"));
                assessment.setSyllabusID(rs.getInt("syllabusID"));
                list.add(assessment);
            }
            con.close();
        } catch (Exception e) {
            throw new AssessmentException("Something went wrong in get assessment progress.");
        }
        return list;
    }
}

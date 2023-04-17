/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import dao.CurriculumDao;
import dao.SyllabusDao;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 *
 * @author Admin
 */
public abstract class ExploreList implements List {

    public static List<Explore> getExpList() throws Exception {
        List<Explore> exList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Curriculum> currList = CurriculumDao.readCurriculumFullList();
        List<Syllabus> syllList = SyllabusDao.readSyllabusFullList();
//                List<Explore> exList = new ArrayList<>();

        for (Curriculum curr : currList) {
            Explore ex = new Explore();
            ex.setId(curr.getId());
            ex.setCode(curr.getCode());
            if (curr.getCreatedAt() != null) {
                ex.setCreatedAt(sdf.parse(curr.getCreatedAt()));
            } else {
                ex.setCreatedAt(null);
            }
            if (curr.getUpdatedAt() != null) {
                ex.setUpdatedAt(sdf.parse(curr.getUpdatedAt()));
            } else {
                ex.setUpdatedAt(null);
            }
            ex.setController("curriculums");
            ex.setType("Curriculum");
            exList.add(ex);
        }

        for (Syllabus syll : syllList) {
            Explore ex = new Explore();
            ex.setId(syll.getId());
            ex.setCode(syll.getSubjectID());
            if (syll.getCreatedAt() != null) {
                ex.setCreatedAt(sdf.parse(syll.getCreatedAt()));
            } else {
                ex.setCreatedAt(null);
            }
            if (syll.getUpdatedAt() != null) {
                ex.setUpdatedAt(sdf.parse(syll.getUpdatedAt()));
            } else {
                ex.setUpdatedAt(null);
            }
            ex.setController("syllabus");
            ex.setType("Syllabus");
            exList.add(ex);
        }

        Collections.sort(exList, new Comparator<Explore>() {
            @Override
            public int compare(Explore o1, Explore o2) {
                if (o1.getUpdatedAt() != null && o2.getUpdatedAt() != null) {
                    return o2.getUpdatedAt().compareTo(o1.getUpdatedAt());
                } else if (o1.getUpdatedAt() != null && o2.getUpdatedAt() == null) {
                    return o2.getUpdatedAt().compareTo(o1.getCreatedAt());
                } else if (o1.getUpdatedAt() == null && o2.getUpdatedAt() != null) {
                    return o2.getCreatedAt().compareTo(o1.getUpdatedAt());
                } else {
                    if (o1.getCreatedAt().compareTo(o2.getCreatedAt()) == 0) {
                        return o1.getCode().compareTo(o2.getCode());
                    } else {
                        return o2.getCreatedAt().compareTo(o1.getCreatedAt());
                    }
                }
            }

        });

        return exList;
    }
}

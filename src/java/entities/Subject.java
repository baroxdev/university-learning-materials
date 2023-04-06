/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.Date;

/**
 *
 * @author giahu
 */
public class Subject {

    private String id;
    private String name;
    private String createdAt;
    private String updatedAt;
    private String preRequisite;
    private int semester;
    private int credit;
    private int knowlegdeCategoryID;

    public Subject() {
    }

    public Subject(String id, String name, String createdAt, String updatedAt, String preRequisite, int semester, int credit, int knowlegdeCategoryID) {
        this.id = id;
        this.name = name;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.preRequisite = preRequisite;
        this.semester = semester;
        this.credit = credit;
        this.knowlegdeCategoryID = knowlegdeCategoryID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getPreRequisite() {
        return preRequisite;
    }

    public void setPreRequisite(String preRequisite) {
        this.preRequisite = preRequisite;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public int getKnowlegdeCategoryID() {
        return knowlegdeCategoryID;
    }

    public void setKnowlegdeCategoryID(int knowlegdeCategoryID) {
        this.knowlegdeCategoryID = knowlegdeCategoryID;
    }
}

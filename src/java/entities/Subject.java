/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 * @author giahu
 */
public class Subject {

    private String id;
    private String name;
    private String viName;
    private String createdAt;

    private String updatedAt;
    private String preRequisite;
    private String slug;
    private String semester;

    public Subject() {
    }

    public Subject(String id, String name, String viName, String createdAt, String updatedAt, String preRequisite, String slug, String semester) {
        this.id = id;
        this.name = name;
        this.viName = viName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.preRequisite = preRequisite;
        this.slug = slug;
        this.semester = semester;
    }

    public Subject(String id, String name, String createdAt, String updatedAt, String semester, String slug) {
        this.id = id;
        this.name = name;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.semester = semester;
        this.slug = slug;
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

    public String getViName() {
        return viName;
    }

    public void setViName(String viName) {
        this.viName = viName;
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

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }


}

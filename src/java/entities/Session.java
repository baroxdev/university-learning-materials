/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 *
 * @author giahu
 */
public class Session {

    private int id;
    private String topic;
    private String learningType;
    private String LO_ID;
    private String materials;
    private String studentTasks;
    private int syllabusID;

    public Session() {
    }

    public Session(int id, String topic, String learningType, String LO_ID, String materials, String studentTasks, int syllabusID) {
        this.id = id;
        this.topic = topic;
        this.learningType = learningType;
        this.LO_ID = LO_ID;
        this.materials = materials;
        this.studentTasks = studentTasks;
        this.syllabusID = syllabusID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getLearningType() {
        return learningType;
    }

    public void setLearningType(String learningType) {
        this.learningType = learningType;
    }

    public String getLO_ID() {
        return LO_ID;
    }

    public void setLO_ID(String LO_ID) {
        this.LO_ID = LO_ID;
    }

    public String getMaterials() {
        return materials;
    }

    public void setMaterials(String materials) {
        this.materials = materials;
    }

    public String getStudentTasks() {
        return studentTasks;
    }

    public void setStudentTasks(String studentTasks) {
        this.studentTasks = studentTasks;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

}

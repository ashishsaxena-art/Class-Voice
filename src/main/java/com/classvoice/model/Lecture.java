package com.classvoice.model;

import java.io.Serializable;
import java.time.LocalDate;

public class Lecture implements Serializable {
    private long lectureId, teacherId; private String title, description, status, teacherName; private LocalDate lectureDate; private int topicCount, feedbackCount;
    public long getLectureId(){return lectureId;} public void setLectureId(long v){lectureId=v;}
    public long getTeacherId(){return teacherId;} public void setTeacherId(long v){teacherId=v;}
    public String getTitle(){return title;} public void setTitle(String v){title=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public LocalDate getLectureDate(){return lectureDate;} public void setLectureDate(LocalDate v){lectureDate=v;}
    public String getStatus(){return status;} public void setStatus(String v){status=v;}
    public String getTeacherName(){return teacherName;} public void setTeacherName(String v){teacherName=v;}
    public int getTopicCount(){return topicCount;} public void setTopicCount(int v){topicCount=v;}
    public int getFeedbackCount(){return feedbackCount;} public void setFeedbackCount(int v){feedbackCount=v;}
    public boolean isActive(){return "active".equalsIgnoreCase(status);}
}

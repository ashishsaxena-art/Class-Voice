package com.classvoice.model;
import java.io.Serializable; import java.util.ArrayList; import java.util.List;
public class Topic implements Serializable { private long topicId,lectureId; private String topicName,description; private List<TopicKeyword> keywords=new ArrayList<>();
 public long getTopicId(){return topicId;} public void setTopicId(long v){topicId=v;} public long getLectureId(){return lectureId;} public void setLectureId(long v){lectureId=v;} public String getTopicName(){return topicName;} public void setTopicName(String v){topicName=v;} public String getDescription(){return description;} public void setDescription(String v){description=v;} public List<TopicKeyword> getKeywords(){return keywords;} public void setKeywords(List<TopicKeyword> v){keywords=v;}}

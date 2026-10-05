package com.classvoice.model;
import java.io.Serializable;
public class TopicStats implements Serializable { private long topicId; private String topicName; private int count; private double percentage;
 public TopicStats(){} public TopicStats(long id,String name,int count,double pct){topicId=id;topicName=name;this.count=count;percentage=pct;}
 public long getTopicId(){return topicId;} public void setTopicId(long v){topicId=v;} public String getTopicName(){return topicName;} public void setTopicName(String v){topicName=v;} public int getCount(){return count;} public void setCount(int v){count=v;} public double getPercentage(){return percentage;} public void setPercentage(double v){percentage=v;}}

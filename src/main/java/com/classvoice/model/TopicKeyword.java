package com.classvoice.model;
import java.io.Serializable;
public class TopicKeyword implements Serializable { private long keywordId,topicId; private String keyword;
 public long getKeywordId(){return keywordId;} public void setKeywordId(long v){keywordId=v;} public long getTopicId(){return topicId;} public void setTopicId(long v){topicId=v;} public String getKeyword(){return keyword;} public void setKeyword(String v){keyword=v;}}

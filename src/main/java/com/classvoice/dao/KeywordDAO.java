package com.classvoice.dao;
import com.classvoice.model.TopicKeyword; import com.classvoice.util.DBConnection; import java.sql.*; import java.util.*;
public class KeywordDAO {
 public void add(long topicId,String keyword)throws SQLException{String s="INSERT IGNORE INTO topic_keywords(topic_id,keyword) VALUES(?,?)";try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(s)){p.setLong(1,topicId);p.setString(2,keyword);p.executeUpdate();}}
 public List<TopicKeyword> findByTopic(long topicId)throws SQLException{String s="SELECT * FROM topic_keywords WHERE topic_id=? ORDER BY keyword_id";List<TopicKeyword> out=new ArrayList<>();try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(s)){p.setLong(1,topicId);try(ResultSet r=p.executeQuery()){while(r.next()){TopicKeyword k=new TopicKeyword();k.setKeywordId(r.getLong("keyword_id"));k.setTopicId(topicId);k.setKeyword(r.getString("keyword"));out.add(k);}}}return out;}
}

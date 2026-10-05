package com.classvoice.service;
import com.classvoice.model.*; import java.util.*; import java.util.regex.Pattern;
public class TopicMatchingService {
 public Topic findBestTopic(String feedback,List<Topic> topics){
  if(feedback==null||feedback.isBlank()||topics==null)return null; String text=feedback.toLowerCase(Locale.ROOT); Topic best=null; int bestScore=0;
  for(Topic t:topics){int score=0;for(TopicKeyword k:t.getKeywords()){String kw=k.getKeyword()==null?"":k.getKeyword().trim().toLowerCase(Locale.ROOT);if(!kw.isEmpty()&&contains(text,kw))score++;}if(score>bestScore){bestScore=score;best=t;}}
  return best;
 }
 private boolean contains(String text,String keyword){return Pattern.compile("(?<![a-z0-9])"+Pattern.quote(keyword)+"(?![a-z0-9])",Pattern.CASE_INSENSITIVE).matcher(text).find();}
}

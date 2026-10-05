package com.classvoice.util;
import jakarta.servlet.http.HttpServletRequest;
public final class WebUtil { private WebUtil(){} public static String trim(String s){return s==null?"":s.trim();} public static long longParam(HttpServletRequest r,String name){try{return Long.parseLong(trim(r.getParameter(name)));}catch(Exception e){return -1;}} public static String safeMessage(Exception e){return e.getMessage()==null?"Something went wrong.":e.getMessage();}}

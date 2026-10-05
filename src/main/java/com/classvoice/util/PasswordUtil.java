package com.classvoice.util;

import java.nio.charset.StandardCharsets; import java.security.MessageDigest; import java.security.SecureRandom; import java.util.Base64;

public final class PasswordUtil {
    private static final SecureRandom RANDOM=new SecureRandom(); private PasswordUtil(){}
    public static String hash(String password){
        try { byte[] salt=new byte[16]; RANDOM.nextBytes(salt); return Base64.getEncoder().encodeToString(salt)+":"+Base64.getEncoder().encodeToString(digest(salt,password)); }
        catch(Exception e){throw new IllegalStateException("Unable to hash password",e);}
    }
    public static boolean matches(String password,String stored){
        try { if(stored==null||!stored.contains(":")) return false; String[] p=stored.split(":",2); byte[] salt=Base64.getDecoder().decode(p[0]); byte[] expected=Base64.getDecoder().decode(p[1]); return MessageDigest.isEqual(expected,digest(salt,password)); }
        catch(Exception e){return false;}
    }
    private static byte[] digest(byte[] salt,String password)throws Exception{MessageDigest md=MessageDigest.getInstance("SHA-256"); md.update(salt); return md.digest(password.getBytes(StandardCharsets.UTF_8));}
}
